from flask import Blueprint, request, jsonify
from app.crud import _commit_or_400
from app.database import db
from app.models import EstudioColegaMuestraAlternativa
from app.schemas import (
    EstudioColegaMuestraAlternativaCreate,
    EstudioColegaMuestraAlternativaUpdate,
    EstudioColegaMuestraAlternativaOut,
)
from app.utils import paginate_query
from app.auth import token_required, admin_required
from pydantic import ValidationError

bp = Blueprint('estudio_colega_muestra_alternativa', __name__, url_prefix='/api/estudio-colega-muestra-alternativa')


@bp.route('', methods=['GET'])
@token_required
def list_items():
    query = EstudioColegaMuestraAlternativa.query.order_by(EstudioColegaMuestraAlternativa.id.asc())
    return paginate_query(query, EstudioColegaMuestraAlternativaOut, default_limit=25)


@bp.route('/<int:id>', methods=['GET'])
@token_required
def get_item(id):
    item = EstudioColegaMuestraAlternativa.query.get_or_404(id)
    return jsonify(EstudioColegaMuestraAlternativaOut.model_validate(item).model_dump(mode='json')), 200


@bp.route('', methods=['POST'])
@admin_required
def create_item():
    try:
        data = EstudioColegaMuestraAlternativaCreate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400
    new_item = EstudioColegaMuestraAlternativa(**data.model_dump())
    db.session.add(new_item)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(EstudioColegaMuestraAlternativaOut.model_validate(new_item).model_dump(mode='json')), 201


@bp.route('/<int:id>', methods=['PUT'])
@admin_required
def update_item(id):
    item = EstudioColegaMuestraAlternativa.query.get_or_404(id)
    try:
        data = EstudioColegaMuestraAlternativaUpdate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400
    for field, value in data.model_dump(exclude_unset=True).items():
        setattr(item, field, value)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(EstudioColegaMuestraAlternativaOut.model_validate(item).model_dump(mode='json')), 200


@bp.route('/<int:id>', methods=['DELETE'])
@admin_required
def delete_item(id):
    item = EstudioColegaMuestraAlternativa.query.get_or_404(id)
    db.session.delete(item)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify({"message": f"Registro {id} eliminado correctamente"}), 200
