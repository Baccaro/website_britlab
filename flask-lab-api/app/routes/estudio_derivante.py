from flask import Blueprint, request, jsonify
from app.crud import _commit_or_400
from app.database import db
from app.models import EstudioDerivante, Estudio, Metodo, Muestra, Preanalitico, ValorEstudioSector
from app.schemas import EstudioDerivanteCreate, EstudioDerivanteUpdate, EstudioDerivanteOut
from app.utils import paginate_query
from pydantic import ValidationError

bp = Blueprint('estudio_derivante', __name__, url_prefix='/api/estudio-derivante')


def _get_or_create_by_nombre(model, nombre):
    """Resuelve el id de una tabla maestra (metodo/muestra/preanalitico) a partir
    de su nombre, creándola si no existe. Permite que el frontend siga editando
    estos campos como texto libre aunque en la BD sean claves foráneas."""
    nombre = (nombre or '').strip()
    if not nombre:
        return None
    item = model.query.filter_by(nombre=nombre).first()
    if item is None:
        item = model(nombre=nombre)
        db.session.add(item)
        db.session.flush()
    return item.id


@bp.route('', methods=['GET'])
def list_items():
    query = EstudioDerivante.query.order_by(EstudioDerivante.id.asc())
    return paginate_query(query, EstudioDerivanteOut, default_limit=50)


@bp.route('/<int:id>', methods=['GET'])
def get_item(id):
    item = EstudioDerivante.query.get_or_404(id)
    return jsonify(EstudioDerivanteOut.model_validate(item).model_dump(mode='json')), 200


@bp.route('', methods=['POST'])
def create_item():
    try:
        data = EstudioDerivanteCreate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400
    new_item = EstudioDerivante(**data.model_dump())
    db.session.add(new_item)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(EstudioDerivanteOut.model_validate(new_item).model_dump(mode='json')), 201


@bp.route('/<int:id>', methods=['PUT'])
def update_item(id):
    item = EstudioDerivante.query.get_or_404(id)
    payload = request.get_json() or {}

    # El frontend edita método/muestra/preanalítico como texto libre: se resuelven
    # (o crean) contra las tablas maestras antes de validar el resto de campos.
    for field, model in (('metodo', Metodo), ('muestra', Muestra), ('preanalitico', Preanalitico)):
        if field in payload:
            payload[f'id_{field}'] = _get_or_create_by_nombre(model, payload.pop(field))

    try:
        data = EstudioDerivanteUpdate(**payload)
    except ValidationError as e:
        return jsonify(e.errors()), 400

    for field, value in data.model_dump(exclude_unset=True).items():
        setattr(item, field, value)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(EstudioDerivanteOut.model_validate(item).model_dump(mode='json')), 200


@bp.route('/<int:id>', methods=['DELETE'])
def delete_item(id):
    item = EstudioDerivante.query.get_or_404(id)
    db.session.delete(item)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify({"message": f"Registro {id} eliminado correctamente"}), 200


@bp.route('/derivante/<int:derivante_id>', methods=['GET'])
def get_estudios_por_derivante(derivante_id):
    resultados = (
        db.session.query(EstudioDerivante, Estudio)
        .join(Estudio, EstudioDerivante.id_estudio == Estudio.id)
        .outerjoin(Metodo, EstudioDerivante.id_metodo == Metodo.id)
        .outerjoin(Muestra, EstudioDerivante.id_muestra == Muestra.id)
        .outerjoin(Preanalitico, EstudioDerivante.id_preanalitico == Preanalitico.id)
        .outerjoin(ValorEstudioSector, EstudioDerivante.id_sector_laboratorio == ValorEstudioSector.id)
        .filter(EstudioDerivante.derivante_id == derivante_id)
        .order_by(Estudio.descripcion.asc())
        .all()
    )

    respuesta = []
    for reg, estudio in resultados:
        respuesta.append({
            'id': reg.id,
            'estudio_id': estudio.id,
            'nemonico_datatech': reg.nemonico_datatech,
            'paridad_datatech_hexalis': reg.paridad_datatech_hexalis,
            'codigo_hexalis': estudio.codigo_hexalis,
            'estudio_descripcion': estudio.descripcion,
            'metodo': reg.metodo.nombre if reg.metodo else None,
            'preanalitico': reg.preanalitico.nombre if reg.preanalitico else None,
            'muestra': reg.muestra.nombre if reg.muestra else None,
            'indicaciones': reg.indicaciones,
            'valor_referencia': reg.valor_referencia,
            'dias_demora': reg.dias_demora,
            'estado': reg.estado,
            'codigo_laboratorio': reg.codigo_laboratorio,
            'version': reg.version,
            'revisor': reg.revisor,
            'observacion': reg.observacion,
            'sector': reg.sector_laboratorio.sector.nombre if (reg.sector_laboratorio and reg.sector_laboratorio.sector) else None,
            'posicion_informe': reg.sector_laboratorio.posicion_informe if reg.sector_laboratorio else None,
            'rango': reg.sector_laboratorio.rango if reg.sector_laboratorio else None,
        })

    return jsonify(respuesta), 200
