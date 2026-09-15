import datetime
from functools import wraps

import jwt
from flask import request, jsonify, g, current_app

from app.models import Usuario

TOKEN_TTL_HORAS = 12

# Módulos del sistema (ver especificación de roles y permisos): cada uno
# admite, por usuario, un rol independiente ('consultor' o 'administrador')
# en permisos.modulos. 'administracion' no está acá a propósito: gestionar
# usuarios es exclusivo de SuperAdmin, no se asigna por módulo.
MODULOS_VALIDOS = ('estudios', 'obras_sociales', 'web', 'faq')
ROLES_MODULO_VALIDOS = ('consultor', 'administrador')


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


def rol_en_modulo(usuario, modulo):
    """Rol efectivo de 'usuario' en 'modulo': None (sin acceso), 'consultor' o
    'administrador'. SuperAdmin siempre resuelve a 'administrador' en
    cualquier módulo (acceso íntegro). Para el resto, un módulo ausente de
    permisos.modulos = sin acceso — a diferencia del esquema anterior
    (pantallas), acá el default es NO ver el módulo hasta que un SuperAdmin
    se lo asigne explícitamente."""
    if usuario.rol == 'superadmin':
        return 'administrador'
    modulos = (usuario.permisos or {}).get('modulos') or {}
    rol = modulos.get(modulo)
    return rol if rol in ROLES_MODULO_VALIDOS else None


def token_required(f):
    """Exige una sesión válida (cualquier rol/módulo). Deja al usuario en
    g.current_user. Uso: endpoints que no dependen de un módulo puntual
    (p.ej. /api/auth/me)."""
    @wraps(f)
    def wrapper(*args, **kwargs):
        usuario, error = _resolver_usuario()
        if error:
            return error
        g.current_user = usuario
        return f(*args, **kwargs)
    return wrapper


def modulo_lectura_required(modulo):
    """Exige rol 'consultor' o 'administrador' en 'modulo' (o SuperAdmin).
    Cubre lectura, filtros/búsquedas, ver detalle y exportar — todo lo que en
    la especificación puede hacer un Consultor."""
    def decorador(f):
        @wraps(f)
        def wrapper(*args, **kwargs):
            usuario, error = _resolver_usuario()
            if error:
                return error
            if rol_en_modulo(usuario, modulo) not in ROLES_MODULO_VALIDOS:
                return jsonify({'error': f'No tenés acceso al módulo "{modulo}"'}), 403
            g.current_user = usuario
            return f(*args, **kwargs)
        return wrapper
    return decorador


def modulo_escritura_required(modulo):
    """Exige rol 'administrador' en 'modulo' (o SuperAdmin): crear, modificar,
    cambiar estado, eliminar/deshabilitar. Un Consultor en ese módulo (o sin
    ningún rol asignado) recibe 403."""
    def decorador(f):
        @wraps(f)
        def wrapper(*args, **kwargs):
            usuario, error = _resolver_usuario()
            if error:
                return error
            if rol_en_modulo(usuario, modulo) != 'administrador':
                return jsonify({'error': f'No tenés permisos de Administrador en el módulo "{modulo}" para esta acción'}), 403
            g.current_user = usuario
            return f(*args, **kwargs)
        return wrapper
    return decorador


def superadmin_required(f):
    """Exige rol 'superadmin': administración de usuarios, roles y permisos,
    y configuración global del sistema — según la especificación, ni siquiera
    un 'administrador' de módulo tiene acceso a esto."""
    @wraps(f)
    def wrapper(*args, **kwargs):
        usuario, error = _resolver_usuario()
        if error:
            return error
        if usuario.rol != 'superadmin':
            return jsonify({'error': 'Esta acción requiere el rol SuperAdmin'}), 403
        g.current_user = usuario
        return f(*args, **kwargs)
    return wrapper
