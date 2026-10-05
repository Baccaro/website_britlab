import os
import re
import uuid
from flask import Blueprint, request, jsonify, current_app, send_file
from app.crud import _commit_or_400
from app.database import db
from app.models import Cv
from app.auth import modulo_lectura_required

bp = Blueprint('cv', __name__, url_prefix='/api/cv')

MAX_BYTES = 10 * 1024 * 1024  # 10 MB


def _ruta_absoluta(ruta_relativa):
    return os.path.join(current_app.config['FILES_DIR'], ruta_relativa)


def _slug(texto):
    texto = re.sub(r'[^A-Za-z0-9]+', '_', (texto or '').strip())
    return texto.strip('_') or 'sn'


def _serialize(c):
    return {
        'id': c.id,
        'nombre_completo': c.nombre_completo,
        'email': c.email,
        'nombre_archivo': c.nombre_archivo,
        'tamanio_bytes': c.tamanio_bytes,
        'created_at': c.created_at.isoformat() if c.created_at else None,
    }


# --- Pública: la postulación la envía cualquier visitante de la web, sin   --
# --- sesión (ver app/__init__.py: CORS sólo habilitado para esta ruta).    --
@bp.route('', methods=['POST'])
def enviar_cv():
    nombre_completo = (request.form.get('nombre_completo') or '').strip()
    email = (request.form.get('email') or '').strip()
    archivo = request.files.get('archivo')
    if not nombre_completo or not email or not archivo:
        return jsonify({'error': 'Faltan datos: nombre, correo electrónico y CV son obligatorios'}), 400

    nombre_original = archivo.filename or 'cv.pdf'
    if not nombre_original.lower().endswith('.pdf'):
        return jsonify({'error': 'El CV debe ser un archivo PDF'}), 400

    contenido = archivo.read()
    if not contenido:
        return jsonify({'error': 'El archivo está vacío'}), 400
    if len(contenido) > MAX_BYTES:
        return jsonify({'error': f'El archivo supera el máximo permitido ({MAX_BYTES // (1024 * 1024)} MB)'}), 400

    ruta_relativa = f'cv/{_slug(nombre_completo)}_{uuid.uuid4().hex[:8]}.pdf'
    ruta_absoluta = _ruta_absoluta(ruta_relativa)
    try:
        os.makedirs(os.path.dirname(ruta_absoluta), exist_ok=True)
        with open(ruta_absoluta, 'wb') as f:
            f.write(contenido)
    except OSError:
        return jsonify({'error': 'No se pudo guardar el archivo en el servidor'}), 500

    nuevo = Cv(
        nombre_completo=nombre_completo,
        email=email,
        nombre_archivo=nombre_original,
        ruta_archivo=ruta_relativa,
        tamanio_bytes=len(contenido),
    )
    db.session.add(nuevo)
    error_response = _commit_or_400()
    if error_response:
        if os.path.exists(ruta_absoluta):
            os.remove(ruta_absoluta)
        return error_response
    return jsonify({'message': 'CV recibido correctamente'}), 201


# --- Interna: listar y descargar, desde el panel (módulo "web") -----------
@bp.route('', methods=['GET'])
@modulo_lectura_required('web')
def listar():
    query = Cv.query.order_by(Cv.created_at.desc())
    page = request.args.get('page', 1, type=int)
    limit = request.args.get('limit', 25, type=int)
    pagination = query.paginate(page=page, per_page=limit, error_out=False)
    return jsonify({
        'total': pagination.total,
        'page': page,
        'limit': limit,
        'total_pages': pagination.pages,
        'items': [_serialize(c) for c in pagination.items],
    }), 200


@bp.route('/<int:id>/descargar', methods=['GET'])
@modulo_lectura_required('web')
def descargar(id):
    c = Cv.query.get_or_404(id)
    ruta_absoluta = _ruta_absoluta(c.ruta_archivo)
    if not os.path.exists(ruta_absoluta):
        return jsonify({'error': 'El archivo ya no está disponible en el servidor'}), 404
    return send_file(
        ruta_absoluta,
        mimetype='application/pdf',
        as_attachment=False,
        download_name=c.nombre_archivo,
    )
