from flask import Blueprint, request, jsonify
from sqlalchemy.exc import IntegrityError
from app.database import db
from app.utils import paginate_query
from pydantic import ValidationError


def _commit_or_400():
    """Confirma la transacción; si viola una restricción de la BD (nombre/código
    duplicado, o un registro todavía referenciado por otra tabla) hace rollback
    y devuelve un 409 legible en vez de dejar pasar un 500 con stack trace."""
    try:
        db.session.commit()
        return None
    except IntegrityError as e:
        db.session.rollback()
        detail = getattr(getattr(e, 'orig', None), 'diag', None)
        msg = detail.message_detail if detail and detail.message_detail else str(e.orig or e)
        return jsonify({"error": "No se pudo guardar: violación de una restricción de la base de datos.", "detail": msg}), 409


def make_crud_blueprint(name, url_prefix, model, create_schema, update_schema, out_schema, order_by='id'):
    """Fábrica de Blueprints CRUD genéricos (list/get/create/update/delete) para
    las tablas maestras simples del esquema (derivante, estudio, metodo, muestra,
    preanalitico, sector, valor_estudio_sector)."""
    bp = Blueprint(name, __name__, url_prefix=url_prefix)

    @bp.route('', methods=['GET'])
    def list_items():
        query = model.query.order_by(getattr(model, order_by).asc())
        return paginate_query(query, out_schema, default_limit=50)

    @bp.route('/<int:id>', methods=['GET'])
    def get_item(id):
        item = model.query.get_or_404(id)
        return jsonify(out_schema.model_validate(item).model_dump(mode='json')), 200

    @bp.route('', methods=['POST'])
    def create_item():
        try:
            data = create_schema(**(request.get_json() or {}))
        except ValidationError as e:
            return jsonify(e.errors()), 400
        new_item = model(**data.model_dump())
        db.session.add(new_item)
        error_response = _commit_or_400()
        if error_response:
            return error_response
        return jsonify(out_schema.model_validate(new_item).model_dump(mode='json')), 201

    @bp.route('/<int:id>', methods=['PUT'])
    def update_item(id):
        item = model.query.get_or_404(id)
        try:
            data = update_schema(**(request.get_json() or {}))
        except ValidationError as e:
            return jsonify(e.errors()), 400
        for field, value in data.model_dump(exclude_unset=True).items():
            setattr(item, field, value)
        error_response = _commit_or_400()
        if error_response:
            return error_response
        return jsonify(out_schema.model_validate(item).model_dump(mode='json')), 200

    @bp.route('/<int:id>', methods=['DELETE'])
    def delete_item(id):
        item = model.query.get_or_404(id)
        db.session.delete(item)
        error_response = _commit_or_400()
        if error_response:
            return error_response
        return jsonify({"message": f"Registro {id} eliminado correctamente"}), 200

    return bp
