from flask import Blueprint, request, jsonify
from app.crud import _commit_or_400
from app.database import db
from app.models import EstudioColega, Estudio, Colega, Metodo, Muestra, Preanalitico, ValorEstudioSector, EstudioColegaMuestra
from app.schemas import EstudioColegaCreate, EstudioColegaUpdate, EstudioColegaOut
from app.utils import paginate_query
from pydantic import ValidationError

bp = Blueprint('estudio_colega', __name__, url_prefix='/api/estudio-colega')


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


def _componer_texto_muestra(m):
    """Arma el texto de una muestra estructurada concatenando sus dimensiones
    presentes, en el orden: tipo, aditivo, modalidad, condición especial,
    volumen, unidad, técnica de recolección, conservación, prioridad de envío."""
    partes = []
    if m.tipo_muestra:
        partes.append(m.tipo_muestra.nombre)
    if m.aditivo:
        partes.append(m.aditivo.nombre)
    if m.modalidad_recoleccion:
        partes.append(m.modalidad_recoleccion.nombre)
    if m.condicion_especial:
        partes.append(m.condicion_especial.nombre)
    if m.volumen is not None:
        vol = m.volumen
        partes.append(str(int(vol)) if vol == vol.to_integral_value() else str(vol))
    if m.unidad_medida:
        partes.append(m.unidad_medida.nombre)
    if m.tecnica_recoleccion:
        partes.append(m.tecnica_recoleccion.nombre)
    if m.conservacion:
        partes.append(m.conservacion.nombre)
    if m.prioridad_envio:
        partes.append(m.prioridad_envio.nombre)
    return ' · '.join(partes)


@bp.route('', methods=['GET'])
def list_items():
    query = EstudioColega.query.order_by(EstudioColega.id.asc())
    return paginate_query(query, EstudioColegaOut, default_limit=50)


@bp.route('/<int:id>', methods=['GET'])
def get_item(id):
    item = EstudioColega.query.get_or_404(id)
    return jsonify(EstudioColegaOut.model_validate(item).model_dump(mode='json')), 200


@bp.route('', methods=['POST'])
def create_item():
    try:
        data = EstudioColegaCreate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400
    new_item = EstudioColega(**data.model_dump())
    db.session.add(new_item)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(EstudioColegaOut.model_validate(new_item).model_dump(mode='json')), 201


@bp.route('/<int:id>', methods=['PUT'])
def update_item(id):
    item = EstudioColega.query.get_or_404(id)
    payload = request.get_json() or {}

    # El frontend edita método/muestra/preanalítico como texto libre: se resuelven
    # (o crean) contra las tablas maestras antes de validar el resto de campos.
    for field, model in (('metodo', Metodo), ('muestra', Muestra), ('preanalitico', Preanalitico)):
        if field in payload:
            payload[f'id_{field}'] = _get_or_create_by_nombre(model, payload.pop(field))

    try:
        data = EstudioColegaUpdate(**payload)
    except ValidationError as e:
        return jsonify(e.errors()), 400

    for field, value in data.model_dump(exclude_unset=True).items():
        setattr(item, field, value)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(EstudioColegaOut.model_validate(item).model_dump(mode='json')), 200


@bp.route('/<int:id>', methods=['DELETE'])
def delete_item(id):
    item = EstudioColega.query.get_or_404(id)
    db.session.delete(item)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify({"message": f"Registro {id} eliminado correctamente"}), 200


@bp.route('/todos', methods=['GET'])
def get_todos_los_estudios():
    """Catálogo maestro de Estudios (uno por código hexalis, sin repetirse),
    con los colegas donde cada uno está autorizado como lista liviana para
    mostrar como chips en el front, sin pedidos extra por estudio."""
    resultados = (
        db.session.query(Estudio, EstudioColega, Colega)
        .outerjoin(EstudioColega, EstudioColega.id_estudio == Estudio.id)
        .outerjoin(Colega, EstudioColega.colega_id == Colega.id)
        .order_by(Estudio.codigo_hexalis.asc())
        .all()
    )
    agrupado = {}
    for estudio, reg, colega in resultados:
        entry = agrupado.setdefault(estudio.codigo_hexalis, {
            'id_estudio': estudio.id,
            'codigo_hexalis': estudio.codigo_hexalis,
            'estudio_descripcion': estudio.descripcion,
            'colegas': []
        })
        if reg is not None:
            entry['colegas'].append({
                'id_estudio_colega': reg.id,
                'colega_id': colega.id,
                'colega_descripcion': colega.descripcion,
                'estado': reg.estado,
            })
    return jsonify(list(agrupado.values())), 200


@bp.route('/colega/<int:colega_id>', methods=['GET'])
def get_estudios_por_colega(colega_id):
    resultados = (
        db.session.query(EstudioColega, Estudio)
        .join(Estudio, EstudioColega.id_estudio == Estudio.id)
        .outerjoin(Metodo, EstudioColega.id_metodo == Metodo.id)
        .outerjoin(Muestra, EstudioColega.id_muestra == Muestra.id)
        .outerjoin(Preanalitico, EstudioColega.id_preanalitico == Preanalitico.id)
        .outerjoin(ValorEstudioSector, EstudioColega.id_sector_laboratorio == ValorEstudioSector.id)
        .filter(EstudioColega.colega_id == colega_id)
        .order_by(Estudio.descripcion.asc())
        .all()
    )

    ids_regs = [reg.id for reg, _ in resultados]
    muestras_por_registro = {}
    if ids_regs:
        muestras_query = (
            EstudioColegaMuestra.query
            .filter(EstudioColegaMuestra.id_estudio_colega.in_(ids_regs))
            .order_by(EstudioColegaMuestra.orden.asc(), EstudioColegaMuestra.id.asc())
        )
        for m in muestras_query.all():
            muestras_por_registro.setdefault(m.id_estudio_colega, []).append(m)

    respuesta = []
    for reg, estudio in resultados:
        muestras_texto = '; '.join(
            _componer_texto_muestra(m) for m in muestras_por_registro.get(reg.id, [])
        ) or None

        respuesta.append({
            'id': reg.id,
            'estudio_id': estudio.id,
            'nemonico_datatech': reg.nemonico_datatech,
            'paridad_datatech_hexalis': reg.paridad_datatech_hexalis,
            'codigo_hexalis': estudio.codigo_hexalis,
            'estudio_descripcion': estudio.descripcion,
            'metodo': reg.metodo.nombre if reg.metodo else None,
            'preanalitico': reg.preanalitico.nombre if reg.preanalitico else None,
            'muestra': muestras_texto,
            'indicaciones_pacientes': reg.indicaciones_pacientes,
            'indicaciones_colega': reg.indicaciones_colega,
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
