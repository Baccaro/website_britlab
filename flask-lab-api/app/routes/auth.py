import datetime
import secrets

from flask import Blueprint, request, jsonify, g
from pydantic import ValidationError
from werkzeug.security import generate_password_hash, check_password_hash

from app.database import db
from app.models import Usuario, PasswordResetToken
from app.schemas import (
    LoginRequest, RegistroRequest, OlvideContrasenaRequest,
    ResetearContrasenaRequest, UsuarioOut,
)
from app.auth import generar_token, token_required

bp = Blueprint('auth', __name__, url_prefix='/api/auth')

RESET_TOKEN_TTL_HORAS = 2


def _usuario_dict(usuario):
    return UsuarioOut.model_validate(usuario).model_dump(mode='json')


@bp.route('/login', methods=['POST'])
def login():
    try:
        data = LoginRequest(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400

    usuario = Usuario.query.filter_by(username=data.username.strip()).first()
    if not usuario or not check_password_hash(usuario.password_hash, data.password):
        return jsonify({'error': 'Usuario o contraseña incorrectos'}), 401
    if not usuario.activo:
        return jsonify({'error': 'Tu usuario está deshabilitado, consultá a un administrador'}), 403

    token = generar_token(usuario)
    return jsonify({'token': token, 'usuario': _usuario_dict(usuario)}), 200


@bp.route('/register', methods=['POST'])
def register():
    """Alta de un usuario nuevo con rol 'user' (sólo lectura). Un administrador
    puede después ascenderlo a 'admin' o ajustarle los permisos desde el panel."""
    try:
        data = RegistroRequest(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400

    username = data.username.strip()
    if not username or len(data.password) < 6:
        return jsonify({'error': 'El usuario es obligatorio y la contraseña debe tener al menos 6 caracteres'}), 400

    if Usuario.query.filter_by(username=username).first():
        return jsonify({'error': 'Ese nombre de usuario ya existe'}), 409
    if data.email and Usuario.query.filter_by(email=data.email).first():
        return jsonify({'error': 'Ese email ya está registrado'}), 409

    nuevo = Usuario(
        username=username,
        nombre_completo=data.nombre_completo,
        email=data.email,
        password_hash=generate_password_hash(data.password),
        rol='user',
        activo=True,
    )
    db.session.add(nuevo)
    db.session.commit()

    token = generar_token(nuevo)
    return jsonify({'token': token, 'usuario': _usuario_dict(nuevo)}), 201


@bp.route('/forgot-password', methods=['POST'])
def forgot_password():
    """Genera un token de reseteo de un solo uso. No hay servicio de email
    configurado en esta aplicación todavía: el link se devuelve directo en la
    respuesta para que el usuario lo use, en vez de enviarse por correo."""
    try:
        data = OlvideContrasenaRequest(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400

    usuario = Usuario.query.filter_by(username=data.username.strip()).first()
    # Responde igual exista o no el usuario, para no revelar qué usuarios existen.
    mensaje = {
        'mensaje': (
            'Si el usuario existe, se generó un link para restablecer la contraseña. '
            'Todavía no hay un servicio de email configurado, así que el link se muestra '
            'acá directamente en vez de enviarse por correo.'
        )
    }
    if not usuario or not usuario.activo:
        return jsonify(mensaje), 200

    token = secrets.token_urlsafe(32)
    reset = PasswordResetToken(
        id_usuario=usuario.id,
        token=token,
        expira=datetime.datetime.utcnow() + datetime.timedelta(hours=RESET_TOKEN_TTL_HORAS),
    )
    db.session.add(reset)
    db.session.commit()

    mensaje['token'] = token
    mensaje['expira'] = reset.expira.isoformat()
    return jsonify(mensaje), 200


@bp.route('/reset-password', methods=['POST'])
def reset_password():
    try:
        data = ResetearContrasenaRequest(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400

    if len(data.password) < 6:
        return jsonify({'error': 'La contraseña debe tener al menos 6 caracteres'}), 400

    reset = PasswordResetToken.query.filter_by(token=data.token).first()
    if not reset or reset.usado or reset.expira < datetime.datetime.utcnow():
        return jsonify({'error': 'El link de recuperación es inválido o expiró, generá uno nuevo'}), 400

    usuario = Usuario.query.get(reset.id_usuario)
    if not usuario or not usuario.activo:
        return jsonify({'error': 'Usuario inválido o deshabilitado'}), 400

    usuario.password_hash = generate_password_hash(data.password)
    reset.usado = True
    db.session.commit()
    return jsonify({'mensaje': 'Contraseña actualizada correctamente'}), 200


@bp.route('/me', methods=['GET'])
@token_required
def me():
    return jsonify(_usuario_dict(g.current_user)), 200
