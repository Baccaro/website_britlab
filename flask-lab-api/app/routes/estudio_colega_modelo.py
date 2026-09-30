import os
import re
from flask import Blueprint, request, jsonify, current_app, send_file
from app.crud import _commit_or_400
from app.database import db
from app.models import EstudioColegaModelo, EstudioColega
from app.auth import modulo_lectura_required, modulo_escritura_required

bp = Blueprint('estudio_colega_modelo', __name__, url_prefix='/api/estudio-colega-modelo')

MAX_BYTES = 15 * 1024 * 1024  # 15 MB por archivo
# 'paciente' (Indicaciones Paciente) ya no admite subida de PDFs nuevos, pero
# se mantiene como categoría válida para poder seguir listando/descargando
# los que ya se hubieran subido antes de este cambio.
CATEGORIAS_VALIDAS = ('preanalitico', 'colega')
# Sufijo de archivo por categoría (ver _nombre_archivo_disco).
CATEGORIA_SUFIJO = {'preanalitico': 'pre', 'colega': 'md'}


def _ruta_absoluta(ruta_relativa):
    return os.path.join(current_app.config['FILES_DIR'], ruta_relativa)


def _slug(texto):
    """Recorta un texto libre (nombre del laboratorio, etc.) a algo seguro
    para usar en un nombre de archivo: sólo letras/números, todo lo demás
    (espacios, paréntesis, tildes tal cual vienen, etc.) se vuelve '_'."""
    texto = re.sub(r'[^A-Za-z0-9]+', '_', (texto or '').strip())
    return texto.strip('_') or 'sn'


def _nombre_archivo_disco(estudio_colega, categoria):
    """Arma el nombre del archivo en disco: CODIGOHEXALIS_LABORATORIO_pre|md_N.pdf,
    directamente adentro de FILES_DIR (sin subcarpeta). El "N" es correlativo:
    cuenta cuántos PDFs ya existen para ese mismo Estudio + Laboratorio
    Procesante + categoría (preanalítico o modelo derivante), y evita pisar un
    archivo existente si por lo que sea el conteo no diera el próximo número
    libre (p.ej. alguno se borró de por medio)."""
    codigo_hexalis = estudio_colega.estudio.codigo_hexalis if estudio_colega.estudio else 'sn'
    nombre_colega = estudio_colega.colega.descripcion if estudio_colega.colega else 'sn'
    sufijo = CATEGORIA_SUFIJO.get(categoria, categoria)
    base = f'{_slug(codigo_hexalis)}_{_slug(nombre_colega)}_{sufijo}'

    ya_existentes = db.session.query(EstudioColegaModelo).join(
        EstudioColega, EstudioColegaModelo.id_estudio_colega == EstudioColega.id
    ).filter(
        EstudioColega.id_estudio == estudio_colega.id_estudio,
        EstudioColega.colega_id == estudio_colega.colega_id,
        EstudioColegaModelo.categoria == categoria,
    ).count()

    numero = ya_existentes + 1
    while True:
        candidato = f'{base}_{numero}.pdf'
        if not os.path.exists(_ruta_absoluta(candidato)):
            return candidato
        numero += 1


def _serialize(m):
    return {
        'id': m.id,
        'id_estudio_colega': m.id_estudio_colega,
        'nombre_archivo': m.nombre_archivo,
        'tamanio_bytes': m.tamanio_bytes,
        'categoria': m.categoria,
        'descripcion': m.descripcion,
        'created_at': m.created_at.isoformat() if m.created_at else None,
    }


@bp.route('/estudio-colega/<int:id_estudio_colega>', methods=['GET'])
@modulo_lectura_required('estudios')
def list_por_estudio_colega(id_estudio_colega):
    # ?categoria= filtra a un solo dropdown (preanalitico/paciente/colega);
    # sin filtro trae todo (usado antes de que existiera esta distinción).
    query = EstudioColegaModelo.query.filter_by(id_estudio_colega=id_estudio_colega)
    categoria = request.args.get('categoria')
    if categoria:
        query = query.filter_by(categoria=categoria)
    items = query.order_by(EstudioColegaModelo.created_at.asc(), EstudioColegaModelo.id.asc()).all()
    return jsonify([_serialize(m) for m in items]), 200


@bp.route('', methods=['POST'])
@modulo_escritura_required('estudios')
def upload():
    id_estudio_colega = request.form.get('id_estudio_colega', type=int)
    archivo = request.files.get('archivo')
    categoria = request.form.get('categoria', 'colega')
    descripcion = request.form.get('descripcion') or None
    if not id_estudio_colega or not archivo:
        return jsonify({'error': 'Faltan datos: id_estudio_colega y archivo son obligatorios'}), 400
    if categoria not in CATEGORIAS_VALIDAS:
        return jsonify({'error': f"Categoría inválida, debe ser una de: {', '.join(CATEGORIAS_VALIDAS)}"}), 400

    ec = EstudioColega.query.get_or_404(id_estudio_colega)

    nombre = archivo.filename or 'documento.pdf'
    if not nombre.lower().endswith('.pdf'):
        return jsonify({'error': 'Sólo se aceptan archivos PDF'}), 400

    contenido = archivo.read()
    if not contenido:
        return jsonify({'error': 'El archivo está vacío'}), 400
    if len(contenido) > MAX_BYTES:
        return jsonify({'error': f'El archivo supera el máximo permitido ({MAX_BYTES // (1024 * 1024)} MB)'}), 400

    ruta_relativa = _nombre_archivo_disco(ec, categoria)
    ruta_absoluta = _ruta_absoluta(ruta_relativa)
    try:
        os.makedirs(current_app.config['FILES_DIR'], exist_ok=True)
        with open(ruta_absoluta, 'wb') as f:
            f.write(contenido)
    except OSError:
        return jsonify({'error': 'No se pudo guardar el archivo en el servidor'}), 500

    nuevo = EstudioColegaModelo(
        id_estudio_colega=id_estudio_colega,
        nombre_archivo=nombre,
        ruta_archivo=ruta_relativa,
        tamanio_bytes=len(contenido),
        categoria=categoria,
        descripcion=descripcion,
    )
    db.session.add(nuevo)
    error_response = _commit_or_400()
    if error_response:
        if os.path.exists(ruta_absoluta):
            os.remove(ruta_absoluta)  # el registro no quedó guardado: no dejar el archivo huérfano
        return error_response
    return jsonify(_serialize(nuevo)), 201


@bp.route('/<int:id>', methods=['PUT'])
@modulo_escritura_required('estudios')
def update_descripcion(id):
    """Sólo permite editar la descripción de un archivo ya subido (nombre,
    contenido y categoría no se pueden cambiar: para eso hay que volver a
    subirlo)."""
    m = EstudioColegaModelo.query.get_or_404(id)
    data = request.get_json(silent=True) or {}
    if 'descripcion' in data:
        m.descripcion = data['descripcion'] or None
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize(m)), 200


@bp.route('/<int:id>/descargar', methods=['GET'])
@modulo_lectura_required('estudios')
def descargar(id):
    m = EstudioColegaModelo.query.get_or_404(id)
    ruta_absoluta = _ruta_absoluta(m.ruta_archivo)
    if not os.path.exists(ruta_absoluta):
        return jsonify({'error': 'El archivo ya no está disponible en el servidor'}), 404
    return send_file(
        ruta_absoluta,
        mimetype='application/pdf',
        as_attachment=False,
        download_name=m.nombre_archivo,
    )


@bp.route('/<int:id>', methods=['DELETE'])
@modulo_escritura_required('estudios')
def delete(id):
    m = EstudioColegaModelo.query.get_or_404(id)
    ruta_absoluta = _ruta_absoluta(m.ruta_archivo)
    db.session.delete(m)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    if os.path.exists(ruta_absoluta):
        try:
            os.remove(ruta_absoluta)
        except OSError:
            pass  # el registro ya se borró de la BD; no bloquear la respuesta por esto
    return jsonify({'message': f'Registro {id} eliminado correctamente'}), 200
