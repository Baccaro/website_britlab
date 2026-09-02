from flask import Blueprint, request, jsonify
from app.crud import _commit_or_400
from app.database import db
from app.models import EstudioColegaMuestra
from app.schemas import EstudioColegaMuestraCreate, EstudioColegaMuestraUpdate, EstudioColegaMuestraOut
from app.utils import paginate_query
from pydantic import ValidationError

bp = Blueprint('estudio_colega_muestra', __name__, url_prefix='/api/estudio-colega-muestra')


@bp.route('', methods=['GET'])
def list_items():
    query = EstudioColegaMuestra.query.order_by(EstudioColegaMuestra.id.asc())
    return paginate_query(query, EstudioColegaMuestraOut, default_limit=50)


@bp.route('/<int:id>', methods=['GET'])
def get_item(id):
    item = EstudioColegaMuestra.query.get_or_404(id)
    return jsonify(EstudioColegaMuestraOut.model_validate(item).model_dump(mode='json')), 200


@bp.route('', methods=['POST'])
def create_item():
    try:
        data = EstudioColegaMuestraCreate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400
    new_item = EstudioColegaMuestra(**data.model_dump())
    db.session.add(new_item)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(EstudioColegaMuestraOut.model_validate(new_item).model_dump(mode='json')), 201


@bp.route('/<int:id>', methods=['PUT'])
def update_item(id):
    item = EstudioColegaMuestra.query.get_or_404(id)
    try:
        data = EstudioColegaMuestraUpdate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400
    for field, value in data.model_dump(exclude_unset=True).items():
        setattr(item, field, value)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(EstudioColegaMuestraOut.model_validate(item).model_dump(mode='json')), 200


@bp.route('/<int:id>', methods=['DELETE'])
def delete_item(id):
    item = EstudioColegaMuestra.query.get_or_404(id)
    db.session.delete(item)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify({"message": f"Registro {id} eliminado correctamente"}), 200


def _label(rel):
    return rel.nombre if rel else None


def _serialize_dimensiones(m):
    """Campos comunes a estudio_colega_muestra y su alternativa: catálogos
    resueltos a nombre, para mostrar directo en el front sin pedidos extra."""
    return {
        'id': m.id,
        'orden': m.orden,
        'id_tipo_muestra': m.id_tipo_muestra,
        'tipo_muestra': _label(m.tipo_muestra),
        'id_aditivo': m.id_aditivo,
        'aditivo': _label(m.aditivo),
        'volumen': float(m.volumen) if m.volumen is not None else None,
        'id_unidad_medida': m.id_unidad_medida,
        'unidad_medida': _label(m.unidad_medida),
        'id_recipiente': m.id_recipiente,
        'recipiente': _label(m.recipiente),
        'id_modalidad_recoleccion': m.id_modalidad_recoleccion,
        'modalidad_recoleccion': _label(m.modalidad_recoleccion),
        'id_tecnica_recoleccion': m.id_tecnica_recoleccion,
        'tecnica_recoleccion': _label(m.tecnica_recoleccion),
        'id_conservacion': m.id_conservacion,
        'conservacion': _label(m.conservacion),
        'id_condicion_especial': m.id_condicion_especial,
        'condicion_especial': _label(m.condicion_especial),
        'id_prioridad_envio': m.id_prioridad_envio,
        'prioridad_envio': _label(m.prioridad_envio),
        'observacion': m.observacion,
    }


@bp.route('/estudio-colega/<int:id_estudio_colega>', methods=['GET'])
def list_por_estudio_colega(id_estudio_colega):
    """Muestras de un estudio_colega puntual, con los catálogos ya resueltos
    a su nombre y sus alternativas anidadas (para mostrar directo en el
    front sin pedidos extra)."""
    items = (
        EstudioColegaMuestra.query
        .filter_by(id_estudio_colega=id_estudio_colega)
        .order_by(EstudioColegaMuestra.orden.asc(), EstudioColegaMuestra.id.asc())
        .all()
    )
    respuesta = []
    for m in items:
        fila = {'id_estudio_colega': m.id_estudio_colega, **_serialize_dimensiones(m)}
        fila['alternativas'] = [
            {'id_estudio_colega_muestra': m.id, **_serialize_dimensiones(a)}
            for a in sorted(m.alternativas, key=lambda a: (a.orden, a.id))
        ]
        respuesta.append(fila)
    return jsonify(respuesta), 200
