import os
import re
import uuid
from datetime import datetime

from flask import Blueprint, request, jsonify, current_app, send_file, g
from sqlalchemy import or_

from app.crud import _commit_or_400
from app.database import db
from app.models import Noticia
from app.auth import modulo_lectura_required, modulo_escritura_required

bp = Blueprint('noticias', __name__, url_prefix='/api/noticias')

MAX_BYTES = 5 * 1024 * 1024  # 5 MB por imagen
EXTENSIONES_VALIDAS = ('.jpg', '.jpeg', '.png', '.webp')


def _ruta_absoluta(ruta_relativa):
    return os.path.join(current_app.config['FILES_DIR'], ruta_relativa)


def _slug(texto):
    texto = re.sub(r'[^A-Za-z0-9]+', '_', (texto or '').strip())
    return texto.strip('_') or 'sn'


def _serialize(n, con_cuerpo=False):
    data = {
        'id': n.id,
        'titulo': n.titulo,
        'descripcion': n.descripcion,
        'categoria': n.categoria,
        'fecha': n.fecha.isoformat() if n.fecha else None,
        'tiene_imagen': bool(n.imagen_ruta),
        'creado_por': n.creado_por.username if n.creado_por else None,
        'actualizado_por': n.actualizado_por.username if n.actualizado_por else None,
        'created_at': n.created_at.isoformat() if n.created_at else None,
        'updated_at': n.updated_at.isoformat() if n.updated_at else None,
    }
    if con_cuerpo:
        data['cuerpo'] = n.cuerpo
    return data


def _validar_campos(titulo, descripcion, cuerpo, categoria, fecha_str):
    if titulo is not None and not titulo.strip():
        return 'El título es obligatorio', None
    if descripcion is not None and not descripcion.strip():
        return 'La descripción es obligatoria', None
    if cuerpo is not None and not cuerpo.strip():
        return 'El cuerpo es obligatorio', None
    if categoria is not None and not categoria.strip():
        return 'La categoría es obligatoria', None
    fecha = None
    if fecha_str is not None:
        if not fecha_str.strip():
            return 'La fecha es obligatoria', None
        try:
            fecha = datetime.strptime(fecha_str.strip(), '%Y-%m-%d').date()
        except ValueError:
            return 'Fecha inválida, formato esperado AAAA-MM-DD', None
    return None, fecha


def _guardar_imagen(titulo, archivo):
    """Valida y guarda en disco la imagen de una noticia; devuelve
    (ruta_relativa, nombre_original, error_response) -- error_response no es
    None si algo falló (y entonces los otros dos valores son None)."""
    nombre_original = archivo.filename or 'imagen'
    ext = os.path.splitext(nombre_original)[1].lower()
    if ext not in EXTENSIONES_VALIDAS:
        return None, None, (jsonify({'error': f"La imagen debe ser uno de estos formatos: {', '.join(EXTENSIONES_VALIDAS)}"}), 400)

    contenido = archivo.read()
    if not contenido:
        return None, None, (jsonify({'error': 'La imagen está vacía'}), 400)
    if len(contenido) > MAX_BYTES:
        return None, None, (jsonify({'error': f'La imagen supera el máximo permitido ({MAX_BYTES // (1024 * 1024)} MB)'}), 400)

    ruta_relativa = f'noticias/{_slug(titulo)}_{uuid.uuid4().hex[:8]}{ext}'
    ruta_absoluta = _ruta_absoluta(ruta_relativa)
    try:
        os.makedirs(os.path.dirname(ruta_absoluta), exist_ok=True)
        with open(ruta_absoluta, 'wb') as f:
            f.write(contenido)
    except OSError:
        return None, None, (jsonify({'error': 'No se pudo guardar la imagen en el servidor'}), 500)

    return ruta_relativa, nombre_original, None


# --- Pública: la consume la web pública sin login (ver CORS en app/__init__.py) --
@bp.route('', methods=['GET'])
def list_items():
    query = Noticia.query

    q = request.args.get('q', '').strip()
    if q:
        like = f'%{q}%'
        query = query.filter(or_(Noticia.titulo.ilike(like), Noticia.descripcion.ilike(like)))

    categoria = request.args.get('categoria', '').strip()
    if categoria:
        query = query.filter(Noticia.categoria == categoria)

    query = query.order_by(Noticia.fecha.desc(), Noticia.id.desc())

    page = request.args.get('page', 1, type=int)
    limit = request.args.get('limit', 25, type=int)
    pagination = query.paginate(page=page, per_page=limit, error_out=False)
    return jsonify({
        'total': pagination.total,
        'page': page,
        'limit': limit,
        'total_pages': pagination.pages,
        'items': [_serialize(n) for n in pagination.items],
    }), 200


@bp.route('/categorias', methods=['GET'])
@modulo_lectura_required('web')
def list_categorias():
    filas = db.session.query(Noticia.categoria).distinct().order_by(Noticia.categoria.asc()).all()
    return jsonify([f[0] for f in filas]), 200


@bp.route('/<int:id>', methods=['GET'])
def get_item(id):
    n = Noticia.query.get_or_404(id)
    return jsonify(_serialize(n, con_cuerpo=True)), 200


@bp.route('/<int:id>/imagen', methods=['GET'])
def imagen(id):
    n = Noticia.query.get_or_404(id)
    if not n.imagen_ruta:
        return jsonify({'error': 'Esta noticia no tiene imagen cargada'}), 404
    ruta_absoluta = _ruta_absoluta(n.imagen_ruta)
    if not os.path.exists(ruta_absoluta):
        return jsonify({'error': 'La imagen ya no está disponible en el servidor'}), 404
    return send_file(ruta_absoluta, download_name=n.imagen_nombre_archivo)


# --- Interna: alta/edición/baja, sólo panel (módulo "web") ------------------
@bp.route('', methods=['POST'])
@modulo_escritura_required('web')
def create_item():
    titulo = (request.form.get('titulo') or '').strip()
    descripcion = (request.form.get('descripcion') or '').strip()
    cuerpo = request.form.get('cuerpo') or ''
    categoria = (request.form.get('categoria') or '').strip()
    fecha_str = request.form.get('fecha') or ''
    archivo = request.files.get('imagen')

    error, fecha = _validar_campos(titulo, descripcion, cuerpo, categoria, fecha_str)
    if error:
        return jsonify({'error': error}), 400

    imagen_ruta = None
    imagen_nombre_archivo = None
    if archivo:
        imagen_ruta, imagen_nombre_archivo, error_response = _guardar_imagen(titulo, archivo)
        if error_response:
            return error_response

    nuevo = Noticia(
        titulo=titulo,
        descripcion=descripcion,
        cuerpo=cuerpo,
        categoria=categoria,
        fecha=fecha,
        imagen_ruta=imagen_ruta,
        imagen_nombre_archivo=imagen_nombre_archivo,
        creado_por_id=g.current_user.id,
        actualizado_por_id=g.current_user.id,
    )
    db.session.add(nuevo)
    error_response = _commit_or_400()
    if error_response:
        if imagen_ruta and os.path.exists(_ruta_absoluta(imagen_ruta)):
            os.remove(_ruta_absoluta(imagen_ruta))
        return error_response
    return jsonify(_serialize(nuevo, con_cuerpo=True)), 201


@bp.route('/<int:id>', methods=['PUT'])
@modulo_escritura_required('web')
def update_item(id):
    n = Noticia.query.get_or_404(id)

    titulo = request.form.get('titulo')
    descripcion = request.form.get('descripcion')
    cuerpo = request.form.get('cuerpo')
    categoria = request.form.get('categoria')
    fecha_str = request.form.get('fecha')
    archivo = request.files.get('imagen')

    error, fecha = _validar_campos(titulo, descripcion, cuerpo, categoria, fecha_str)
    if error:
        return jsonify({'error': error}), 400

    nueva_imagen_ruta = None
    if archivo:
        nueva_imagen_ruta, nueva_imagen_nombre, error_response = _guardar_imagen(titulo or n.titulo, archivo)
        if error_response:
            return error_response

    if titulo is not None:
        n.titulo = titulo.strip()
    if descripcion is not None:
        n.descripcion = descripcion.strip()
    if cuerpo is not None:
        n.cuerpo = cuerpo
    if categoria is not None:
        n.categoria = categoria.strip()
    if fecha is not None:
        n.fecha = fecha

    imagen_vieja_ruta = n.imagen_ruta
    if nueva_imagen_ruta:
        n.imagen_ruta = nueva_imagen_ruta
        n.imagen_nombre_archivo = nueva_imagen_nombre

    n.actualizado_por_id = g.current_user.id
    error_response = _commit_or_400()
    if error_response:
        if nueva_imagen_ruta and os.path.exists(_ruta_absoluta(nueva_imagen_ruta)):
            os.remove(_ruta_absoluta(nueva_imagen_ruta))
        return error_response

    # Reemplazó la imagen: recién ahora, con el cambio ya confirmado en la
    # BD, se borra el archivo viejo (si falla no pasa nada grave, queda
    # huérfano en disco, pero no se pierde la noticia).
    if nueva_imagen_ruta and imagen_vieja_ruta:
        ruta_vieja_absoluta = _ruta_absoluta(imagen_vieja_ruta)
        if os.path.exists(ruta_vieja_absoluta):
            os.remove(ruta_vieja_absoluta)

    return jsonify(_serialize(n, con_cuerpo=True)), 200


@bp.route('/<int:id>', methods=['DELETE'])
@modulo_escritura_required('web')
def delete_item(id):
    n = Noticia.query.get_or_404(id)
    imagen_ruta = n.imagen_ruta
    db.session.delete(n)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    if imagen_ruta:
        ruta_absoluta = _ruta_absoluta(imagen_ruta)
        if os.path.exists(ruta_absoluta):
            os.remove(ruta_absoluta)
    return jsonify({'message': f'Registro {id} eliminado correctamente'}), 200
