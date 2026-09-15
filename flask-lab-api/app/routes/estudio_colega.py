from flask import Blueprint, request, jsonify
from app.crud import _commit_or_400
from app.database import db
from app.models import EstudioColega, Estudio, Colega, Metodo, Muestra, ValorEstudioSector, EstudioColegaMuestra, EstudioColegaModelo
from app.schemas import EstudioColegaCreate, EstudioColegaUpdate, EstudioColegaOut
from app.utils import paginate_query
from app.auth import modulo_lectura_required, modulo_escritura_required
from pydantic import ValidationError

bp = Blueprint('estudio_colega', __name__, url_prefix='/api/estudio-colega')


def _get_or_create_by_nombre(model, nombre):
    """Resuelve el id de una tabla maestra (metodo/muestra) a partir de su
    nombre, creándola si no existe. Permite que el frontend siga editando
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
@modulo_lectura_required('estudios')
def list_items():
    query = EstudioColega.query.order_by(EstudioColega.id.asc())
    return paginate_query(query, EstudioColegaOut, default_limit=25)


@bp.route('/<int:id>', methods=['GET'])
@modulo_lectura_required('estudios')
def get_item(id):
    item = EstudioColega.query.get_or_404(id)
    return jsonify(EstudioColegaOut.model_validate(item).model_dump(mode='json')), 200


@bp.route('', methods=['POST'])
@modulo_escritura_required('estudios')
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
@modulo_escritura_required('estudios')
def update_item(id):
    item = EstudioColega.query.get_or_404(id)
    payload = request.get_json() or {}

    # El frontend edita método/muestra como texto libre: se resuelven (o
    # crean) contra las tablas maestras antes de validar el resto de campos.
    for field, model in (('metodo', Metodo), ('muestra', Muestra)):
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
@modulo_escritura_required('estudios')
def delete_item(id):
    item = EstudioColega.query.get_or_404(id)
    db.session.delete(item)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify({"message": f"Registro {id} eliminado correctamente"}), 200


def _listar_estudios_colega(colega_id=None):
    """Registros Estudio x Colega, opcionalmente filtrados a un colega. Sin
    filtro trae TODOS los colegas sin deduplicar: si un estudio está
    autorizado en 2 colegas aparece 2 veces, una por cada uno (nunca se
    combina en una sola fila)."""
    query = (
        db.session.query(EstudioColega, Estudio, Colega)
        .join(Estudio, EstudioColega.id_estudio == Estudio.id)
        .join(Colega, EstudioColega.colega_id == Colega.id)
        .outerjoin(Metodo, EstudioColega.id_metodo == Metodo.id)
        .outerjoin(Muestra, EstudioColega.id_muestra == Muestra.id)
        .outerjoin(ValorEstudioSector, EstudioColega.id_sector_laboratorio == ValorEstudioSector.id)
    )
    if colega_id is not None:
        query = query.filter(EstudioColega.colega_id == colega_id)
    resultados = query.order_by(Estudio.descripcion.asc(), Colega.descripcion.asc()).all()

    ids_regs = [reg.id for reg, _, _ in resultados]
    muestras_por_registro = {}
    if ids_regs:
        muestras_query = (
            EstudioColegaMuestra.query
            .filter(EstudioColegaMuestra.id_estudio_colega.in_(ids_regs))
            .order_by(EstudioColegaMuestra.orden.asc(), EstudioColegaMuestra.id.asc())
        )
        for m in muestras_query.all():
            muestras_por_registro.setdefault(m.id_estudio_colega, []).append(m)

    # Conteo de PDFs por registro Y categoría (preanalitico/paciente/colega):
    # cada dropdown de documentación necesita saber si tiene algo para mostrar
    # el link "Ver" o no, sin pedir de a uno por fila.
    pdfs_por_registro = {}
    if ids_regs:
        conteos = (
            db.session.query(
                EstudioColegaModelo.id_estudio_colega,
                EstudioColegaModelo.categoria,
                db.func.count(EstudioColegaModelo.id),
            )
            .filter(EstudioColegaModelo.id_estudio_colega.in_(ids_regs))
            .group_by(EstudioColegaModelo.id_estudio_colega, EstudioColegaModelo.categoria)
            .all()
        )
        for id_ec, categoria, cantidad in conteos:
            pdfs_por_registro.setdefault(id_ec, {})[categoria] = cantidad

    respuesta = []
    for reg, estudio, colega in resultados:
        muestras_texto = '; '.join(
            _componer_texto_muestra(m) for m in muestras_por_registro.get(reg.id, [])
        ) or None

        respuesta.append({
            'id': reg.id,
            'estudio_id': estudio.id,
            'colega_id': colega.id,
            'colega_descripcion': colega.descripcion,
            'colega_es_propio': colega.es_propio,
            'nemonico_datatech': reg.nemonico_datatech,
            'paridad_datatech_hexalis': reg.paridad_datatech_hexalis,
            'codigo_hexalis': estudio.codigo_hexalis,
            'estudio_descripcion': estudio.descripcion,
            'metodo': reg.metodo.nombre if reg.metodo else None,
            'muestra': muestras_texto,
            'muestra_count': len(muestras_por_registro.get(reg.id, [])),
            'indicaciones_pacientes': reg.indicaciones_pacientes,
            'indicaciones_colega': reg.indicaciones_colega,
            'preanalitico_descripcion': reg.preanalitico_descripcion,
            'modelo_derivante_observaciones': reg.modelo_derivante_observaciones,
            'pdfs_preanalitico_count': pdfs_por_registro.get(reg.id, {}).get('preanalitico', 0),
            'pdfs_paciente_count': pdfs_por_registro.get(reg.id, {}).get('paciente', 0),
            'pdfs_colega_count': pdfs_por_registro.get(reg.id, {}).get('colega', 0),
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

    return respuesta


@bp.route('/todos', methods=['GET'])
@modulo_lectura_required('estudios')
def get_todos_los_estudios():
    return jsonify(_listar_estudios_colega()), 200


@bp.route('/colega/<int:colega_id>', methods=['GET'])
@modulo_lectura_required('estudios')
def get_estudios_por_colega(colega_id):
    return jsonify(_listar_estudios_colega(colega_id)), 200
