from datetime import datetime
from flask import Blueprint, request, jsonify, g
from sqlalchemy import or_

from app.crud import _commit_or_400, _redactar_sensibles
from app.database import db
from app.utils import normalizar_nombre
from app.models import (
    ObraSocial, ObraSocialAlias, ObraSocialPlan, ObraSocialHistorialEstado,
    ObraSocialContacto, ObraSocialNomenclador, ObraSocialAutorizador,
    Nomenclador, Autorizador,
)
from app.schemas import (
    ObraSocialCreate, ObraSocialUpdate, ObraSocialPlanCreate, ObraSocialPlanUpdate,
    ObraSocialEstadoUpdate, ObraSocialContactoCreate, ObraSocialContactoUpdate,
    ObraSocialAutorizadorCreate, ObraSocialAutorizadorUpdate,
)
from app.auth import modulo_lectura_required, modulo_escritura_required
from pydantic import ValidationError

bp = Blueprint('obras_sociales', __name__, url_prefix='/api/obras-sociales')

ESTADOS_ATENCION = ('activo', 'limitada', 'suspendida', 'sin_atencion')
ESTADOS_INFORMACION = ('borrador', 'validada')
TIPOS_CONTACTO = ('General', 'Autorizaciones', 'Auditoría', 'Convenios', 'Facturación', 'Otro')
PRIORIDADES_AUTORIZADOR = ('principal', 'alternativo')

CREDENCIALES_AUTORIZADOR_PERMISO = 'ver_credenciales_autorizadores'


def _serialize_plan(p):
    return {
        'id': p.id, 'id_obra_social': p.id_obra_social, 'nombre': p.nombre,
        'codigo_datatech_gravado': p.codigo_datatech_gravado, 'codigo_datatech_exento': p.codigo_datatech_exento,
        'estado': p.estado, 'observacion': p.observacion,
    }


def _serialize_contacto(c):
    return {
        'id': c.id, 'id_obra_social': c.id_obra_social, 'tipo': c.tipo, 'nombre': c.nombre,
        'telefono': c.telefono, 'whatsapp': c.whatsapp, 'email': c.email, 'observacion': c.observacion,
    }


def _serialize_historial(h):
    return {
        'id': h.id, 'id_obra_social': h.id_obra_social, 'id_plan': h.id_plan,
        'plan_nombre': h.plan.nombre if h.plan else None,
        'estado_anterior': h.estado_anterior, 'estado_nuevo': h.estado_nuevo,
        'comunicado_por': h.comunicado_por, 'motivo': h.motivo,
        'creado_por': h.creado_por_username,
        'created_at': h.created_at.isoformat() if h.created_at else None,
    }


def _serialize_nomenclador_rel(r):
    n = r.nomenclador
    return {
        'id': r.id, 'id_obra_social': r.id_obra_social, 'id_nomenclador': r.id_nomenclador,
        'nombre': n.nombre if n else None, 'tipo': n.tipo if n else None,
        'version_o_fecha': n.version_o_fecha if n else None, 'estado': n.estado if n else None,
        'vigencia': n.vigencia if n else None, 'link': n.link if n else None,
        'observacion': n.observacion if n else None,
        'creado_por_username': n.creado_por_username if n else None,
        'actualizado_por_username': n.actualizado_por_username if n else None,
    }


def _serialize_autorizador_rel(r):
    a = r.autorizador
    data = {
        'id': r.id, 'id_obra_social': r.id_obra_social, 'id_autorizador': r.id_autorizador,
        'nombre': a.nombre if a else None, 'tipo': a.tipo if a else None, 'link': a.link if a else None,
        'prioridad': r.prioridad, 'usuario': r.usuario, 'password': r.password, 'observacion': r.observacion,
    }
    return _redactar_sensibles(data, ['usuario', 'password'], CREDENCIALES_AUTORIZADOR_PERMISO)


def _serialize_obra_social(o, detalle=False):
    data = {
        'id': o.id,
        'nombre': o.nombre,
        'alias': [a.alias for a in o.alias],
        'estado': o.estado,
        'estado_informacion': o.estado_informacion,
        'mostrar_web': o.mostrar_web,
        'habilitar_ia': o.habilitar_ia,
        'modalidad_autorizacion': o.modalidad_autorizacion,
        'observacion_general': o.observacion_general,
        'informacion_publica': o.informacion_publica,
        'cantidad_planes': len(o.planes),
        # Resumen liviano (nombre + estado) para el listado: alcanza para
        # mostrar "OSDE → Limitada / Plan 310 → Limitada" sin traer todo.
        'planes_resumen': [{'id': p.id, 'nombre': p.nombre, 'estado': p.estado} for p in o.planes],
        'nomencladores_resumen': [
            {'id': r.nomenclador.id, 'nombre': r.nomenclador.nombre, 'link': r.nomenclador.link}
            for r in o.nomencladores_rel if r.nomenclador
        ],
        'fecha_ultima_validacion': o.fecha_ultima_validacion.isoformat() if o.fecha_ultima_validacion else None,
        'validado_por': o.validado_por_username,
        'creado_por': o.creado_por_username,
        'actualizado_por': o.actualizado_por_username,
        'created_at': o.created_at.isoformat() if o.created_at else None,
        'updated_at': o.updated_at.isoformat() if o.updated_at else None,
    }
    if detalle:
        data['planes'] = [_serialize_plan(p) for p in o.planes]
        data['contactos'] = [_serialize_contacto(c) for c in o.contactos]
        data['nomencladores'] = [_serialize_nomenclador_rel(r) for r in o.nomencladores_rel]
        data['autorizadores'] = [_serialize_autorizador_rel(r) for r in o.autorizadores_rel]
    return data


def _validar_estado(estado, valores, campo='estado'):
    if estado is not None and estado not in valores:
        return f"{campo} inválido, debe ser uno de: {', '.join(valores)}"
    return None


def _set_alias(obra_social, alias_list):
    obra_social.alias.clear()
    for a in (alias_list or []):
        a = (a or '').strip()
        if a:
            obra_social.alias.append(ObraSocialAlias(alias=a))


def _nombre_obra_social_duplicado(nombre, excluir_id=None):
    if not nombre:
        return None
    objetivo = normalizar_nombre(nombre)
    query = ObraSocial.query
    if excluir_id is not None:
        query = query.filter(ObraSocial.id != excluir_id)
    for existente in query.all():
        if normalizar_nombre(existente.nombre) == objetivo:
            return jsonify({'error': f'Ya existe una Obra Social con ese nombre: "{existente.nombre}".'}), 409
    return None


@bp.route('', methods=['GET'])
@modulo_lectura_required('obras_sociales')
def list_items():
    query = ObraSocial.query

    q = request.args.get('q', '').strip()
    if q:
        like = f'%{q}%'
        query = query.filter(or_(
            ObraSocial.nombre.ilike(like),
            ObraSocial.id.in_(db.session.query(ObraSocialAlias.id_obra_social).filter(ObraSocialAlias.alias.ilike(like))),
        ))

    estado = request.args.get('estado', '').strip()
    if estado:
        query = query.filter(ObraSocial.estado == estado)

    estado_informacion = request.args.get('estado_informacion', '').strip()
    if estado_informacion:
        query = query.filter(ObraSocial.estado_informacion == estado_informacion)

    query = query.order_by(ObraSocial.nombre.asc())

    page = request.args.get('page', 1, type=int)
    limit = request.args.get('limit', 25, type=int)
    pagination = query.paginate(page=page, per_page=limit, error_out=False)
    return jsonify({
        'total': pagination.total,
        'page': page,
        'limit': limit,
        'total_pages': pagination.pages,
        'items': [_serialize_obra_social(o) for o in pagination.items],
    }), 200


@bp.route('/<int:id>', methods=['GET'])
@modulo_lectura_required('obras_sociales')
def get_item(id):
    o = ObraSocial.query.get_or_404(id)
    return jsonify(_serialize_obra_social(o, detalle=True)), 200


@bp.route('', methods=['POST'])
@modulo_escritura_required('obras_sociales')
def create_item():
    try:
        data = ObraSocialCreate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400

    error = (_validar_estado(data.estado, ESTADOS_ATENCION) or
             _validar_estado(data.estado_informacion, ESTADOS_INFORMACION, 'estado_informacion'))
    if error:
        return jsonify({'error': error}), 400

    error_response = _nombre_obra_social_duplicado(data.nombre)
    if error_response:
        return error_response

    nuevo = ObraSocial(
        nombre=data.nombre.strip(),
        estado=data.estado or 'activo',
        estado_informacion=data.estado_informacion or 'borrador',
        mostrar_web=bool(data.mostrar_web),
        habilitar_ia=bool(data.habilitar_ia),
        modalidad_autorizacion=data.modalidad_autorizacion,
        observacion_general=data.observacion_general,
        informacion_publica=data.informacion_publica,
        creado_por_id=g.current_user.id,
        actualizado_por_id=g.current_user.id,
    )
    _set_alias(nuevo, data.alias)
    db.session.add(nuevo)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize_obra_social(nuevo, detalle=True)), 201


@bp.route('/<int:id>', methods=['PUT'])
@modulo_escritura_required('obras_sociales')
def update_item(id):
    o = ObraSocial.query.get_or_404(id)
    try:
        data = ObraSocialUpdate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400

    campos = data.model_dump(exclude_unset=True)
    error = (_validar_estado(campos.get('estado'), ESTADOS_ATENCION) or
             _validar_estado(campos.get('estado_informacion'), ESTADOS_INFORMACION, 'estado_informacion'))
    if error:
        return jsonify({'error': error}), 400

    if 'nombre' in campos:
        error_response = _nombre_obra_social_duplicado(campos['nombre'], excluir_id=id)
        if error_response:
            return error_response

    alias = campos.pop('alias', None)
    if alias is not None:
        _set_alias(o, alias)
    for field, value in campos.items():
        if field == 'nombre' and isinstance(value, str):
            value = value.strip()
        setattr(o, field, value)
    o.actualizado_por_id = g.current_user.id
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize_obra_social(o, detalle=True)), 200


@bp.route('/<int:id>', methods=['DELETE'])
@modulo_escritura_required('obras_sociales')
def delete_item(id):
    o = ObraSocial.query.get_or_404(id)
    db.session.delete(o)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify({'message': f'Obra Social {id} eliminada correctamente'}), 200


@bp.route('/<int:id>/validar', methods=['POST'])
@modulo_escritura_required('obras_sociales')
def validar(id):
    """Pasa la Obra Social de Borrador a Validada (RN: sólo lo Validado puede
    publicarse en Web/IA, ver mostrar_web/habilitar_ia)."""
    o = ObraSocial.query.get_or_404(id)
    o.estado_informacion = 'validada'
    o.fecha_ultima_validacion = datetime.utcnow()
    o.validado_por_id = g.current_user.id
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize_obra_social(o, detalle=True)), 200


@bp.route('/<int:id>/volver-a-borrador', methods=['POST'])
@modulo_escritura_required('obras_sociales')
def volver_a_borrador(id):
    o = ObraSocial.query.get_or_404(id)
    o.estado_informacion = 'borrador'
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize_obra_social(o, detalle=True)), 200


@bp.route('/<int:id>/estado', methods=['POST'])
@modulo_escritura_required('obras_sociales')
def cambiar_estado(id):
    """Cambia el estado de atención de la Obra Social y deja historial
    (fecha, quién lo comunicó del lado de la Obra Social, motivo)."""
    o = ObraSocial.query.get_or_404(id)
    try:
        data = ObraSocialEstadoUpdate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400
    error = _validar_estado(data.estado, ESTADOS_ATENCION)
    if error:
        return jsonify({'error': error}), 400

    db.session.add(ObraSocialHistorialEstado(
        id_obra_social=id, id_plan=None, estado_anterior=o.estado, estado_nuevo=data.estado,
        comunicado_por=data.comunicado_por, motivo=data.motivo, creado_por_id=g.current_user.id,
    ))
    o.estado = data.estado
    o.actualizado_por_id = g.current_user.id
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize_obra_social(o, detalle=True)), 200


@bp.route('/<int:id>/historial', methods=['GET'])
@modulo_lectura_required('obras_sociales')
def historial(id):
    ObraSocial.query.get_or_404(id)
    filas = (
        ObraSocialHistorialEstado.query
        .filter_by(id_obra_social=id)
        .order_by(ObraSocialHistorialEstado.created_at.desc())
        .all()
    )
    return jsonify([_serialize_historial(h) for h in filas]), 200


# --- Planes ------------------------------------------------------------------

@bp.route('/<int:id>/planes', methods=['POST'])
@modulo_escritura_required('obras_sociales')
def crear_plan(id):
    ObraSocial.query.get_or_404(id)
    try:
        data = ObraSocialPlanCreate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400
    error = _validar_estado(data.estado, ESTADOS_ATENCION)
    if error:
        return jsonify({'error': error}), 400

    plan = ObraSocialPlan(id_obra_social=id, **data.model_dump())
    db.session.add(plan)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize_plan(plan)), 201


@bp.route('/planes/<int:plan_id>', methods=['PUT'])
@modulo_escritura_required('obras_sociales')
def actualizar_plan(plan_id):
    plan = ObraSocialPlan.query.get_or_404(plan_id)
    try:
        data = ObraSocialPlanUpdate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400
    campos = data.model_dump(exclude_unset=True)
    error = _validar_estado(campos.get('estado'), ESTADOS_ATENCION)
    if error:
        return jsonify({'error': error}), 400
    for field, value in campos.items():
        setattr(plan, field, value)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize_plan(plan)), 200


@bp.route('/planes/<int:plan_id>/estado', methods=['POST'])
@modulo_escritura_required('obras_sociales')
def cambiar_estado_plan(plan_id):
    plan = ObraSocialPlan.query.get_or_404(plan_id)
    try:
        data = ObraSocialEstadoUpdate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400
    error = _validar_estado(data.estado, ESTADOS_ATENCION)
    if error:
        return jsonify({'error': error}), 400

    db.session.add(ObraSocialHistorialEstado(
        id_obra_social=plan.id_obra_social, id_plan=plan.id, estado_anterior=plan.estado,
        estado_nuevo=data.estado, comunicado_por=data.comunicado_por, motivo=data.motivo,
        creado_por_id=g.current_user.id,
    ))
    plan.estado = data.estado
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize_plan(plan)), 200


@bp.route('/planes/<int:plan_id>', methods=['DELETE'])
@modulo_escritura_required('obras_sociales')
def eliminar_plan(plan_id):
    plan = ObraSocialPlan.query.get_or_404(plan_id)
    db.session.delete(plan)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify({'message': f'Plan {plan_id} eliminado correctamente'}), 200


# --- Contactos -----------------------------------------------------------

@bp.route('/<int:id>/contactos', methods=['POST'])
@modulo_escritura_required('obras_sociales')
def crear_contacto(id):
    ObraSocial.query.get_or_404(id)
    try:
        data = ObraSocialContactoCreate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400
    error = _validar_estado(data.tipo, TIPOS_CONTACTO, 'tipo')
    if error:
        return jsonify({'error': error}), 400
    contacto = ObraSocialContacto(id_obra_social=id, **data.model_dump())
    db.session.add(contacto)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize_contacto(contacto)), 201


@bp.route('/contactos/<int:contacto_id>', methods=['PUT'])
@modulo_escritura_required('obras_sociales')
def actualizar_contacto(contacto_id):
    contacto = ObraSocialContacto.query.get_or_404(contacto_id)
    try:
        data = ObraSocialContactoUpdate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400
    campos = data.model_dump(exclude_unset=True)
    error = _validar_estado(campos.get('tipo'), TIPOS_CONTACTO, 'tipo')
    if error:
        return jsonify({'error': error}), 400
    for field, value in campos.items():
        setattr(contacto, field, value)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize_contacto(contacto)), 200


@bp.route('/contactos/<int:contacto_id>', methods=['DELETE'])
@modulo_escritura_required('obras_sociales')
def eliminar_contacto(contacto_id):
    contacto = ObraSocialContacto.query.get_or_404(contacto_id)
    db.session.delete(contacto)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify({'message': f'Contacto {contacto_id} eliminado correctamente'}), 200


# --- Nomencladores (relación M2M simple) --------------------------------

@bp.route('/<int:id>/nomencladores', methods=['POST'])
@modulo_escritura_required('obras_sociales')
def agregar_nomenclador(id):
    ObraSocial.query.get_or_404(id)
    id_nomenclador = (request.get_json(silent=True) or {}).get('id_nomenclador')
    if not id_nomenclador:
        return jsonify({'error': 'id_nomenclador es obligatorio'}), 400
    Nomenclador.query.get_or_404(id_nomenclador)
    ya_existe = ObraSocialNomenclador.query.filter_by(id_obra_social=id, id_nomenclador=id_nomenclador).first()
    if ya_existe:
        return jsonify({'error': 'Ese nomenclador ya está asociado a esta Obra Social'}), 400
    rel = ObraSocialNomenclador(id_obra_social=id, id_nomenclador=id_nomenclador)
    db.session.add(rel)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize_nomenclador_rel(rel)), 201


@bp.route('/nomencladores-rel/<int:rel_id>', methods=['DELETE'])
@modulo_escritura_required('obras_sociales')
def quitar_nomenclador(rel_id):
    rel = ObraSocialNomenclador.query.get_or_404(rel_id)
    db.session.delete(rel)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify({'message': f'Relación {rel_id} eliminada correctamente'}), 200


# --- Autorizadores (relación M2M con credenciales propias) --------------

@bp.route('/<int:id>/autorizadores', methods=['POST'])
@modulo_escritura_required('obras_sociales')
def agregar_autorizador(id):
    ObraSocial.query.get_or_404(id)
    try:
        data = ObraSocialAutorizadorCreate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400
    error = _validar_estado(data.prioridad, PRIORIDADES_AUTORIZADOR, 'prioridad')
    if error:
        return jsonify({'error': error}), 400
    Autorizador.query.get_or_404(data.id_autorizador)
    ya_existe = ObraSocialAutorizador.query.filter_by(id_obra_social=id, id_autorizador=data.id_autorizador).first()
    if ya_existe:
        return jsonify({'error': 'Ese autorizador ya está asociado a esta Obra Social'}), 400

    rel = ObraSocialAutorizador(id_obra_social=id, **data.model_dump())
    db.session.add(rel)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize_autorizador_rel(rel)), 201


@bp.route('/autorizadores-rel/<int:rel_id>', methods=['PUT'])
@modulo_escritura_required('obras_sociales')
def actualizar_autorizador_rel(rel_id):
    rel = ObraSocialAutorizador.query.get_or_404(rel_id)
    try:
        data = ObraSocialAutorizadorUpdate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400
    campos = data.model_dump(exclude_unset=True)
    error = _validar_estado(campos.get('prioridad'), PRIORIDADES_AUTORIZADOR, 'prioridad')
    if error:
        return jsonify({'error': error}), 400
    for field, value in campos.items():
        setattr(rel, field, value)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize_autorizador_rel(rel)), 200


@bp.route('/autorizadores-rel/<int:rel_id>', methods=['DELETE'])
@modulo_escritura_required('obras_sociales')
def quitar_autorizador(rel_id):
    rel = ObraSocialAutorizador.query.get_or_404(rel_id)
    db.session.delete(rel)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify({'message': f'Relación {rel_id} eliminada correctamente'}), 200
