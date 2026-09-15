from flask import request, jsonify
from app.crud import make_crud_blueprint, _commit_or_400
from app.database import db
from app.models import Colega, EstudioColega
from app.schemas import ColegaCreate, ColegaUpdate, ColegaOut
from app.auth import modulo_escritura_required

bp = make_crud_blueprint(
    'colegas', '/api/colegas', Colega,
    ColegaCreate, ColegaUpdate, ColegaOut,
    allow_delete=False, search_field='descripcion',
    sensitive_fields=['portal_usuario', 'portal_password'],
    sensitive_permiso='ver_credenciales_colegas',
    unique_name_field='descripcion',
)


@bp.route('/<int:id>/deshabilitar', methods=['POST'])
@modulo_escritura_required('estudios')
def deshabilitar(id):
    """Deshabilita un colega (no se borra: dejaría huérfanos sus estudios).
    Opcionalmente pasa a 'pendiente' todos sus registros Estudio x Colega."""
    colega = Colega.query.get_or_404(id)
    colega.habilitado = False

    marcar_pendiente = bool((request.get_json(silent=True) or {}).get('marcar_pendiente'))
    afectados = 0
    if marcar_pendiente:
        afectados = (
            EstudioColega.query
            .filter_by(colega_id=id)
            .update({'estado': 'pendiente'}, synchronize_session=False)
        )

    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify({
        'id': colega.id,
        'habilitado': colega.habilitado,
        'estudios_marcados_pendiente': afectados,
    }), 200


@bp.route('/<int:id>/habilitar', methods=['POST'])
@modulo_escritura_required('estudios')
def habilitar(id):
    colega = Colega.query.get_or_404(id)
    colega.habilitado = True
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify({'id': colega.id, 'habilitado': colega.habilitado}), 200
