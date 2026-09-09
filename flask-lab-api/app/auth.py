import datetime
from functools import wraps

import jwt
from flask import request, jsonify, g, current_app

from app.models import Usuario

TOKEN_TTL_HORAS = 12


def generar_token(usuario):
    payload = {
        'sub': usuario.id,
        'username': usuario.username,
        'rol': usuario.rol,
        'iat': datetime.datetime.utcnow(),
        'exp': datetime.datetime.utcnow() + datetime.timedelta(hours=TOKEN_TTL_HORAS),
    }
    return jwt.encode(payload, current_app.config['SECRET_KEY'], algorithm='HS256')


def _extraer_token():
    auth = request.headers.get('Authorization', '')
    if auth.startswith('Bearer '):
        return auth[7:].strip()
    return None


def _resolver_usuario():
    """Valida el JWT de la request y devuelve (usuario, None) o (None, respuesta_de_error)."""
    token = _extraer_token()
    if not token:
        return None, (jsonify({'error': 'No autenticado'}), 401)
    try:
        payload = jwt.decode(token, current_app.config['SECRET_KEY'], algorithms=['HS256'])
    except jwt.ExpiredSignatureError:
        return None, (jsonify({'error': 'La sesión expiró, iniciá sesión de nuevo'}), 401)
    except jwt.InvalidTokenError:
        return None, (jsonify({'error': 'Token inválido'}), 401)

    usuario = Usuario.query.get(payload.get('sub'))
    if not usuario or not usuario.activo:
        return None, (jsonify({'error': 'Usuario inválido o deshabilitado'}), 401)
    return usuario, None


def token_required(f):
    """Exige una sesión válida (cualquier rol). Deja al usuario en g.current_user."""
    @wraps(f)
    def wrapper(*args, **kwargs):
        usuario, error = _resolver_usuario()
        if error:
            return error
        g.current_user = usuario
        return f(*args, **kwargs)
    return wrapper


def admin_required(f):
    """Exige una sesión válida Y rol 'admin': todo lo que escribe (crear,
    modificar, borrar, habilitar/deshabilitar) pasa por acá, porque el rol
    'user' es de sólo lectura en toda la aplicación."""
    @wraps(f)
    def wrapper(*args, **kwargs):
        usuario, error = _resolver_usuario()
        if error:
            return error
        if usuario.rol != 'admin':
            return jsonify({'error': 'No tenés permisos de administrador para esta acción'}), 403
        g.current_user = usuario
        return f(*args, **kwargs)
    return wrapper
