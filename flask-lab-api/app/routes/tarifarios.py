from flask import Blueprint, request, jsonify, g
from sqlalchemy import or_

from app.crud import _commit_or_400
from app.database import db
from app.models import Tarifario, TarifarioItem, TarifarioItemPeriodo, Estudio
from app.schemas import (
    TarifarioCreate, TarifarioUpdate,
    TarifarioItemCreate, TarifarioItemUpdate,
    TarifarioItemPeriodoCreate, TarifarioItemPeriodoUpdate,
)
from app.auth import modulo_lectura_required, modulo_escritura_required
from pydantic import ValidationError

bp = Blueprint('tarifarios', __name__, url_prefix='/api/tarifarios')

TIPOS_VALIDOS = ('TARIFARIO', 'CONVENIO', 'DERIVACION', 'LISTA', 'ANEXO')
ESTADOS_TARIFARIO = ('activo', 'inactivo')
ESTADOS_ITEM = ('Activo', 'Inactivo')


@bp.route('/estudios-disponibles', methods=['GET'])
@modulo_lectura_required('obras_sociales')
def estudios_disponibles():
    """Catálogo de Estudios para el picker de ítems: propia (no /api/estudios,
    que exige el módulo 'estudios') porque un usuario con sólo acceso a
    'obras_sociales' tiene que poder buscar un Estudio para agregarlo a un
    tarifario sin que además le hagan falta permisos del módulo Estudios."""
    q = request.args.get('q', '').strip()
    query = Estudio.query
    if q:
        like = f'%{q}%'
        query = query.filter(or_(Estudio.descripcion.ilike(like), Estudio.codigo_hexalis.ilike(like)))
    items = query.order_by(Estudio.descripcion.asc()).limit(3000).all()
    return jsonify([{'id': e.id, 'codigo_hexalis': e.codigo_hexalis, 'descripcion': e.descripcion} for e in items]), 200

def _serialize_periodo(p):
    """La auditoría de cada período (quién y cuándo lo creó/editó) sólo la ve
    SuperAdmin (pedido explícito de negocio): a diferencia del resto del RBAC
    por módulo, acá ni un Administrador de 'obras_sociales' la desbloquea."""
    data = {
        'id': p.id,
        'id_tarifario_item': p.id_tarifario_item,
        'periodo': p.periodo,
        'precio': float(p.precio),
    }
    usuario = getattr(g, 'current_user', None)
    if usuario and usuario.rol == 'superadmin':
        data['creado_por_username'] = p.creado_por_username
        data['actualizado_por_username'] = p.actualizado_por_username
        data['created_at'] = p.created_at.isoformat() if p.created_at else None
        data['updated_at'] = p.updated_at.isoformat() if p.updated_at else None
    else:
        data['creado_por_username'] = None
        data['actualizado_por_username'] = None
        data['created_at'] = None
        data['updated_at'] = None
    return data


def _serialize_item(item, con_periodos=False):
    vigente = item.periodo_vigente
    data = {
        'id': item.id,
        'id_tarifario': item.id_tarifario,
        'id_estudio': item.id_estudio,
        'estudio_descripcion': item.estudio.descripcion if item.estudio else None,
        'estudio_codigo_hexalis': item.estudio.codigo_hexalis if item.estudio else None,
        'nemonico': item.nemonico,
        'codigo': item.codigo,
        'estado': item.estado,
        'nota': item.nota,
        'precio_vigente': float(vigente.precio) if vigente else None,
        'periodo_vigente': vigente.periodo if vigente else None,
        'cantidad_periodos': len(item.periodos),
    }
    if con_periodos:
        data['periodos'] = [_serialize_periodo(p) for p in item.periodos]
    return data


def _serialize_tarifario(t, con_items=False):
    data = {
        'id': t.id,
        'nombre': t.nombre,
        'tipo': t.tipo,
        'tipo_relacionado': t.tipo_relacionado,
        'entidad': t.entidad,
        'moneda': t.moneda,
        'estado': t.estado,
        'observaciones': t.observaciones,
        'cantidad_items': len(t.items),
        'creado_por': t.creado_por_username,
        'actualizado_por': t.actualizado_por_username,
        'created_at': t.created_at.isoformat() if t.created_at else None,
        'updated_at': t.updated_at.isoformat() if t.updated_at else None,
    }
    if con_items:
        data['items'] = [_serialize_item(i) for i in t.items]
    return data


def _validar_tarifario(tipo, estado):
    if tipo is not None and tipo not in TIPOS_VALIDOS:
        return f"Tipo inválido, debe ser uno de: {', '.join(TIPOS_VALIDOS)}"
    if estado is not None and estado not in ESTADOS_TARIFARIO:
        return f"Estado inválido, debe ser uno de: {', '.join(ESTADOS_TARIFARIO)}"
    return None


@bp.route('', methods=['GET'])
@modulo_lectura_required('obras_sociales')
def list_items():
    query = Tarifario.query

    q = request.args.get('q', '').strip()
    if q:
        like = f'%{q}%'
        query = query.filter(or_(Tarifario.nombre.ilike(like), Tarifario.entidad.ilike(like)))

    tipo = request.args.get('tipo', '').strip()
    if tipo:
        query = query.filter(Tarifario.tipo == tipo)

    estado = request.args.get('estado', '').strip()
    if estado:
        query = query.filter(Tarifario.estado == estado)

    query = query.order_by(Tarifario.nombre.asc())

    page = request.args.get('page', 1, type=int)
    limit = request.args.get('limit', 25, type=int)
    pagination = query.paginate(page=page, per_page=limit, error_out=False)
    return jsonify({
        'total': pagination.total,
        'page': page,
        'limit': limit,
        'total_pages': pagination.pages,
        'items': [_serialize_tarifario(t) for t in pagination.items],
    }), 200


@bp.route('/<int:id>', methods=['GET'])
@modulo_lectura_required('obras_sociales')
def get_item(id):
    t = Tarifario.query.get_or_404(id)
    return jsonify(_serialize_tarifario(t, con_items=True)), 200


@bp.route('', methods=['POST'])
@modulo_escritura_required('obras_sociales')
def create_item():
    try:
        data = TarifarioCreate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400

    error = _validar_tarifario(data.tipo, data.estado)
    if error:
        return jsonify({'error': error}), 400

    nuevo = Tarifario(
        nombre=data.nombre.strip(),
        tipo=data.tipo or 'TARIFARIO',
        tipo_relacionado=data.tipo_relacionado or 'Laboratorio / Procesador externo',
        entidad=(data.entidad or '').strip() or None,
        moneda=data.moneda or 'ARS',
        estado=data.estado or 'activo',
        observaciones=data.observaciones,
        creado_por_id=g.current_user.id,
        actualizado_por_id=g.current_user.id,
    )
    db.session.add(nuevo)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize_tarifario(nuevo)), 201


@bp.route('/<int:id>', methods=['PUT'])
@modulo_escritura_required('obras_sociales')
def update_item(id):
    t = Tarifario.query.get_or_404(id)
    try:
        data = TarifarioUpdate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400

    campos = data.model_dump(exclude_unset=True)
    error = _validar_tarifario(campos.get('tipo'), campos.get('estado'))
    if error:
        return jsonify({'error': error}), 400

    for field, value in campos.items():
        if field in ('nombre', 'entidad') and isinstance(value, str):
            value = value.strip() or None
        setattr(t, field, value)
    t.actualizado_por_id = g.current_user.id
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize_tarifario(t)), 200


@bp.route('/<int:id>', methods=['DELETE'])
@modulo_escritura_required('obras_sociales')
def delete_item(id):
    t = Tarifario.query.get_or_404(id)
    db.session.delete(t)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify({'message': f'Tarifario {id} eliminado correctamente'}), 200


@bp.route('/<int:id>/items', methods=['POST'])
@modulo_escritura_required('obras_sociales')
def create_tarifario_item(id):
    Tarifario.query.get_or_404(id)
    try:
        data = TarifarioItemCreate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400

    if data.estado is not None and data.estado not in ESTADOS_ITEM:
        return jsonify({'error': f"Estado inválido, debe ser uno de: {', '.join(ESTADOS_ITEM)}"}), 400
    if not data.periodo.strip():
        return jsonify({'error': 'El período es obligatorio'}), 400

    Estudio.query.get_or_404(data.id_estudio)

    item = TarifarioItem(
        id_tarifario=id,
        id_estudio=data.id_estudio,
        nemonico=data.nemonico,
        codigo=data.codigo,
        estado=data.estado or 'Activo',
        nota=data.nota,
    )
    db.session.add(item)
    db.session.flush()
    periodo = TarifarioItemPeriodo(
        id_tarifario_item=item.id,
        periodo=data.periodo.strip(),
        precio=data.precio,
        creado_por_id=g.current_user.id,
        actualizado_por_id=g.current_user.id,
    )
    db.session.add(periodo)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize_item(item, con_periodos=True)), 201


@bp.route('/items/<int:item_id>', methods=['PUT'])
@modulo_escritura_required('obras_sociales')
def update_tarifario_item(item_id):
    item = TarifarioItem.query.get_or_404(item_id)
    try:
        data = TarifarioItemUpdate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400

    campos = data.model_dump(exclude_unset=True)
    if campos.get('estado') is not None and campos['estado'] not in ESTADOS_ITEM:
        return jsonify({'error': f"Estado inválido, debe ser uno de: {', '.join(ESTADOS_ITEM)}"}), 400
    if 'id_estudio' in campos:
        Estudio.query.get_or_404(campos['id_estudio'])

    for field, value in campos.items():
        setattr(item, field, value)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize_item(item, con_periodos=True)), 200


@bp.route('/items/<int:item_id>', methods=['DELETE'])
@modulo_escritura_required('obras_sociales')
def delete_tarifario_item(item_id):
    item = TarifarioItem.query.get_or_404(item_id)
    db.session.delete(item)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify({'message': f'Ítem {item_id} eliminado correctamente'}), 200


@bp.route('/items/<int:item_id>/periodos', methods=['GET'])
@modulo_lectura_required('obras_sociales')
def list_periodos(item_id):
    item = TarifarioItem.query.get_or_404(item_id)
    return jsonify([_serialize_periodo(p) for p in item.periodos]), 200


@bp.route('/items/<int:item_id>/periodos', methods=['POST'])
@modulo_escritura_required('obras_sociales')
def create_periodo(item_id):
    item = TarifarioItem.query.get_or_404(item_id)
    try:
        data = TarifarioItemPeriodoCreate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400

    periodo_limpio = data.periodo.strip()
    if not periodo_limpio:
        return jsonify({'error': 'El período es obligatorio'}), 400
    ya_existe = TarifarioItemPeriodo.query.filter_by(id_tarifario_item=item_id, periodo=periodo_limpio).first()
    if ya_existe:
        return jsonify({'error': f'Ya hay un precio cargado para el período "{periodo_limpio}" en este ítem: para actualizar el precio, ingresá un período distinto.'}), 400

    nuevo = TarifarioItemPeriodo(
        id_tarifario_item=item_id,
        periodo=periodo_limpio,
        precio=data.precio,
        creado_por_id=g.current_user.id,
        actualizado_por_id=g.current_user.id,
    )
    db.session.add(nuevo)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize_periodo(nuevo)), 201


@bp.route('/periodos/<int:periodo_id>', methods=['PUT'])
@modulo_escritura_required('obras_sociales')
def update_periodo(periodo_id):
    """Corrige un período ya cargado (p.ej. error de tipeo): a diferencia de
    /items/<id>/periodos (POST), esto no representa una actualización de
    precio real, así que si sólo se quiere cambiar el precio hay que crear un
    período nuevo en vez de usar esta ruta."""
    p = TarifarioItemPeriodo.query.get_or_404(periodo_id)
    try:
        data = TarifarioItemPeriodoUpdate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400

    campos = data.model_dump(exclude_unset=True)
    if 'periodo' in campos:
        periodo_limpio = (campos['periodo'] or '').strip()
        if not periodo_limpio:
            return jsonify({'error': 'El período es obligatorio'}), 400
        duplicado = TarifarioItemPeriodo.query.filter(
            TarifarioItemPeriodo.id_tarifario_item == p.id_tarifario_item,
            TarifarioItemPeriodo.periodo == periodo_limpio,
            TarifarioItemPeriodo.id != periodo_id,
        ).first()
        if duplicado:
            return jsonify({'error': f'Ya hay un precio cargado para el período "{periodo_limpio}" en este ítem.'}), 400
        campos['periodo'] = periodo_limpio

    for field, value in campos.items():
        setattr(p, field, value)
    p.actualizado_por_id = g.current_user.id
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize_periodo(p)), 200


@bp.route('/periodos/<int:periodo_id>', methods=['DELETE'])
@modulo_escritura_required('obras_sociales')
def delete_periodo(periodo_id):
    p = TarifarioItemPeriodo.query.get_or_404(periodo_id)
    db.session.delete(p)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify({'message': f'Período {periodo_id} eliminado correctamente'}), 200
