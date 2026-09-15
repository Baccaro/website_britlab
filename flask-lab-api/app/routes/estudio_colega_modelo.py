from flask import Blueprint, request, jsonify, Response
from app.crud import _commit_or_400
from app.database import db
from app.models import EstudioColegaModelo, EstudioColega
from app.auth import modulo_lectura_required, modulo_escritura_required

bp = Blueprint('estudio_colega_modelo', __name__, url_prefix='/api/estudio-colega-modelo')

MAX_BYTES = 15 * 1024 * 1024  # 15 MB por archivo
CATEGORIAS_VALIDAS = ('preanalitico', 'paciente', 'colega')


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

    EstudioColega.query.get_or_404(id_estudio_colega)

    nombre = archivo.filename or 'documento.pdf'
    if not nombre.lower().endswith('.pdf'):
        return jsonify({'error': 'Sólo se aceptan archivos PDF'}), 400

    contenido = archivo.read()
    if not contenido:
        return jsonify({'error': 'El archivo está vacío'}), 400
    if len(contenido) > MAX_BYTES:
        return jsonify({'error': f'El archivo supera el máximo permitido ({MAX_BYTES // (1024 * 1024)} MB)'}), 400

    nuevo = EstudioColegaModelo(
        id_estudio_colega=id_estudio_colega,
        nombre_archivo=nombre,
        contenido=contenido,
        tamanio_bytes=len(contenido),
        categoria=categoria,
        descripcion=descripcion,
    )
    db.session.add(nuevo)
    error_response = _commit_or_400()
    if error_response:
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
    return Response(
        m.contenido,
        mimetype='application/pdf',
        headers={'Content-Disposition': f'inline; filename="{m.nombre_archivo}"'}
    )


@bp.route('/<int:id>', methods=['DELETE'])
@modulo_escritura_required('estudios')
def delete(id):
    m = EstudioColegaModelo.query.get_or_404(id)
    db.session.delete(m)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify({'message': f'Registro {id} eliminado correctamente'}), 200
