import secrets

from flask import Blueprint, request, jsonify
from pydantic import ValidationError
from werkzeug.security import generate_password_hash

from app.database import db
from app.crud import _commit_or_400
from app.models import Usuario
from app.schemas import UsuarioCreate, UsuarioUpdate, UsuarioOut, AdminResetearContrasenaRequest
from app.auth import admin_required

bp = Blueprint('usuarios', __name__, url_prefix='/api/usuarios')

ROLES_VALIDOS = ('admin', 'user')


@bp.route('', methods=['GET'])
@admin_required
def list_items():
    items = Usuario.query.order_by(Usuario.username.asc()).all()
    return jsonify([UsuarioOut.model_validate(u).model_dump(mode='json') for u in items]), 200


@bp.route('/<int:id>', methods=['GET'])
@admin_required
def get_item(id):
    usuario = Usuario.query.get_or_404(id)
    return jsonify(UsuarioOut.model_validate(usuario).model_dump(mode='json')), 200


@bp.route('', methods=['POST'])
@admin_required
def create_item():
    try:
        data = UsuarioCreate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400

    username = data.username.strip()
    if not username or len(data.password) < 6:
        return jsonify({'error': 'El usuario es obligatorio y la contraseña debe tener al menos 6 caracteres'}), 400
    if data.rol not in ROLES_VALIDOS:
        return jsonify({'error': f"Rol inválido, debe ser uno de: {', '.join(ROLES_VALIDOS)}"}), 400

    nuevo = Usuario(
        username=username,
        nombre_completo=data.nombre_completo,
        email=data.email,
        password_hash=generate_password_hash(data.password),
        rol=data.rol,
        activo=data.activo if data.activo is not None else True,
        permisos=data.permisos,
    )
    db.session.add(nuevo)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(UsuarioOut.model_validate(nuevo).model_dump(mode='json')), 201


@bp.route('/<int:id>', methods=['PUT'])
@admin_required
def update_item(id):
    """Edita datos, rol, activo y/o permisos (pantallas/columnas visibles) de
    un usuario. No toca la contraseña: para eso está /resetear-password."""
    usuario = Usuario.query.get_or_404(id)
    try:
        data = UsuarioUpdate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400

    if data.rol is not None and data.rol not in ROLES_VALIDOS:
        return jsonify({'error': f"Rol inválido, debe ser uno de: {', '.join(ROLES_VALIDOS)}"}), 400

    for field, value in data.model_dump(exclude_unset=True).items():
        setattr(usuario, field, value)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(UsuarioOut.model_validate(usuario).model_dump(mode='json')), 200


@bp.route('/<int:id>/resetear-password', methods=['POST'])
@admin_required
def resetear_password(id):
    """Reseteo directo de contraseña por un admin (sin token/email): si no
    mandan 'password' se genera una provisoria al azar y se devuelve en la
    respuesta para que el admin se la pase al usuario."""
    usuario = Usuario.query.get_or_404(id)
    try:
        data = AdminResetearContrasenaRequest(**(request.get_json(silent=True) or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400

    nueva_password = data.password
    generada = False
    if not nueva_password:
        nueva_password = secrets.token_urlsafe(9)
        generada = True
    elif len(nueva_password) < 6:
        return jsonify({'error': 'La contraseña debe tener al menos 6 caracteres'}), 400

    usuario.password_hash = generate_password_hash(nueva_password)
    error_response = _commit_or_400()
    if error_response:
        return error_response

    respuesta = {'mensaje': 'Contraseña actualizada correctamente'}
    if generada:
        respuesta['password_generada'] = nueva_password
    return jsonify(respuesta), 200
