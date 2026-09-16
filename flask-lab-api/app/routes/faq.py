from flask import Blueprint, request, jsonify, g
from sqlalchemy import or_

from app.crud import _commit_or_400
from app.database import db
from app.models import Faq
from app.schemas import FaqCreate, FaqUpdate
from app.auth import modulo_lectura_required, modulo_escritura_required
from app.utils import paginate_query
from pydantic import ValidationError

bp = Blueprint('faq', __name__, url_prefix='/api/faq')

ESTADOS_VALIDOS = ('borrador', 'activo', 'inactivo')


def _serialize(f):
    return {
        'id': f.id,
        'pregunta': f.pregunta,
        'respuesta': f.respuesta,
        'categoria': f.categoria,
        'disponible_web': f.disponible_web,
        'disponible_ia': f.disponible_ia,
        'estado': f.estado,
        'creado_por': f.creado_por.username if f.creado_por else None,
        'actualizado_por': f.actualizado_por.username if f.actualizado_por else None,
        'created_at': f.created_at.isoformat() if f.created_at else None,
        'updated_at': f.updated_at.isoformat() if f.updated_at else None,
    }


def _validar_campos(pregunta, respuesta, categoria, estado):
    # RN-FAQ-01: pregunta, respuesta y categoría son obligatorias.
    if pregunta is not None and not pregunta.strip():
        return 'La pregunta es obligatoria'
    if respuesta is not None and not respuesta.strip():
        return 'La respuesta es obligatoria'
    if categoria is not None and not categoria.strip():
        return 'La categoría es obligatoria'
    if estado is not None and estado not in ESTADOS_VALIDOS:
        return f"Estado inválido, debe ser uno de: {', '.join(ESTADOS_VALIDOS)}"
    return None


@bp.route('', methods=['GET'])
@modulo_lectura_required('faq')
def list_items():
    query = Faq.query

    q = request.args.get('q', '').strip()
    if q:
        like = f'%{q}%'
        query = query.filter(or_(Faq.pregunta.ilike(like), Faq.respuesta.ilike(like)))

    categoria = request.args.get('categoria', '').strip()
    if categoria:
        query = query.filter(Faq.categoria == categoria)

    estado = request.args.get('estado', '').strip()
    if estado:
        query = query.filter(Faq.estado == estado)

    # Disponibilidad: 3 checkboxes independientes (web/ia/interno), OR entre
    # las marcadas; "interno" = ni web ni ia (exclusivamente uso interno).
    quiere_web = request.args.get('web') == 'true'
    quiere_ia = request.args.get('ia') == 'true'
    quiere_interno = request.args.get('interno') == 'true'
    if quiere_web or quiere_ia or quiere_interno:
        condiciones = []
        if quiere_web:
            condiciones.append(Faq.disponible_web.is_(True))
        if quiere_ia:
            condiciones.append(Faq.disponible_ia.is_(True))
        if quiere_interno:
            condiciones.append(db.and_(Faq.disponible_web.is_(False), Faq.disponible_ia.is_(False)))
        query = query.filter(or_(*condiciones))

    query = query.order_by(Faq.updated_at.desc(), Faq.id.desc())
    return paginate_query_faq(query)


def paginate_query_faq(query):
    # No se puede reusar paginate_query genérico (usa Pydantic out_schema):
    # acá la serialización necesita resolver creado_por/actualizado_por.
    page = request.args.get('page', 1, type=int)
    limit = request.args.get('limit', 25, type=int)
    pagination = query.paginate(page=page, per_page=limit, error_out=False)
    return {
        'total': pagination.total,
        'page': page,
        'limit': limit,
        'total_pages': pagination.pages,
        'items': [_serialize(f) for f in pagination.items],
    }, 200


@bp.route('/categorias', methods=['GET'])
@modulo_lectura_required('faq')
def list_categorias():
    """Categorías ya usadas, para el autocompletado (RN-FAQ-02: sin ABM
    separado de categorías, se arman a partir de lo ya cargado)."""
    filas = db.session.query(Faq.categoria).distinct().order_by(Faq.categoria.asc()).all()
    return jsonify([f[0] for f in filas]), 200


@bp.route('/<int:id>', methods=['GET'])
@modulo_lectura_required('faq')
def get_item(id):
    f = Faq.query.get_or_404(id)
    return jsonify(_serialize(f)), 200


@bp.route('', methods=['POST'])
@modulo_escritura_required('faq')
def create_item():
    try:
        data = FaqCreate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400

    error = _validar_campos(data.pregunta, data.respuesta, data.categoria, data.estado)
    if error:
        return jsonify({'error': error}), 400

    nuevo = Faq(
        pregunta=data.pregunta.strip(),
        respuesta=data.respuesta,
        categoria=data.categoria.strip(),
        disponible_web=bool(data.disponible_web),
        disponible_ia=bool(data.disponible_ia),
        estado=data.estado or 'borrador',
        creado_por_id=g.current_user.id,
        actualizado_por_id=g.current_user.id,
    )
    db.session.add(nuevo)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize(nuevo)), 201


@bp.route('/<int:id>', methods=['PUT'])
@modulo_escritura_required('faq')
def update_item(id):
    f = Faq.query.get_or_404(id)
    try:
        data = FaqUpdate(**(request.get_json() or {}))
    except ValidationError as e:
        return jsonify(e.errors()), 400

    campos = data.model_dump(exclude_unset=True)
    error = _validar_campos(campos.get('pregunta'), campos.get('respuesta'), campos.get('categoria'), campos.get('estado'))
    if error:
        return jsonify({'error': error}), 400

    for field, value in campos.items():
        if field in ('pregunta', 'categoria') and isinstance(value, str):
            value = value.strip()
        setattr(f, field, value)
    f.actualizado_por_id = g.current_user.id
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize(f)), 200


@bp.route('/<int:id>', methods=['DELETE'])
@modulo_escritura_required('faq')
def delete_item(id):
    f = Faq.query.get_or_404(id)
    db.session.delete(f)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify({'message': f'Registro {id} eliminado correctamente'}), 200
