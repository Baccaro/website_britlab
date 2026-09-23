from flask import Blueprint, request, jsonify, g
from sqlalchemy.exc import IntegrityError
from app.database import db
from app.utils import paginate_query, normalizar_nombre
from app.auth import modulo_lectura_required, modulo_escritura_required
from pydantic import ValidationError


def _redactar_sensibles(data, sensitive_fields, sensitive_permiso):
    """Oculta campos sensibles (p.ej. credenciales de un portal externo) de un
    dict ya serializado, salvo que quien pide sea SuperAdmin o tenga el
    permiso puntual habilitado. A diferencia del rol por módulo (opt-in: sin
    asignación no se ve el módulo), esto es una restricción adicional DENTRO
    de un módulo ya accesible: por defecto ni un Administrador de módulo ve
    estos campos — hay que habilitárselo explícitamente. Además de
    ocultarlos, deja un '<campo>_cargado' (bool) calculado ANTES de redactar,
    para que el frontend pueda distinguir "sin dato" de "dato oculto"."""
    if not sensitive_fields:
        return data
    for field in sensitive_fields:
        data[f'{field}_cargado'] = bool(data.get(field))
    usuario = getattr(g, 'current_user', None)
    if usuario and usuario.rol == 'superadmin':
        return data
    permisos = (usuario.permisos if usuario else None) or {}
    if permisos.get(sensitive_permiso):
        return data
    for field in sensitive_fields:
        data[field] = None
    return data


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


def make_crud_blueprint(name, url_prefix, model, create_schema, update_schema, out_schema, order_by='id', allow_delete=True, search_field=None, sensitive_fields=None, sensitive_permiso=None, unique_name_field=None, modulo='estudios'):
    """Fábrica de Blueprints CRUD genéricos (list/get/create/update[/delete]) para
    las tablas maestras simples del esquema (colega, estudio, metodo, muestra,
    sector, valor_estudio_sector). Con allow_delete=False no se registra la
    ruta DELETE: catálogos como método o tipo de muestra sólo se pueden
    modificar, nunca borrar (evita dejar referencias rotas). Con search_field,
    ?q=texto filtra ese campo (ILIKE) antes de paginar. Con sensitive_fields
    (+ sensitive_permiso), esos campos se redactan en las respuestas de
    lectura salvo SuperAdmin o el permiso puntual (ver _redactar_sensibles);
    no aplica a create/update porque esas rutas ya requieren rol Administrador
    en el módulo. Con unique_name_field, create/update rechazan (409) un
    nombre que ya existe ignorando mayúsculas y tildes ('Cálculo' ==
    'calculo') — es un chequeo a nivel aplicación, no una constraint de la
    BD, así que no le afecta si ya hay datos históricos duplicados cargados
    de antes. 'modulo' (default 'estudios') es el módulo del nuevo esquema de
    roles/permisos que gobierna el acceso a este blueprint: todas las tablas
    maestras actuales (colega, método, muestras estructuradas, etc.)
    pertenecen al módulo Estudios."""
    bp = Blueprint(name, __name__, url_prefix=url_prefix)

    def _nombre_duplicado(valor, excluir_id=None):
        if not unique_name_field or not valor:
            return None
        objetivo = normalizar_nombre(valor)
        query = model.query
        if excluir_id is not None:
            query = query.filter(model.id != excluir_id)
        for existente in query.all():
            if normalizar_nombre(getattr(existente, unique_name_field, None)) == objetivo:
                return jsonify({
                    'error': f'Ya existe un registro con ese nombre: "{getattr(existente, unique_name_field)}".'
                }), 409
        return None

    @bp.route('', methods=['GET'])
    @modulo_lectura_required(modulo)
    def list_items():
        query = model.query.order_by(getattr(model, order_by).asc())
        if search_field:
            q = request.args.get('q', '').strip()
            if q:
                query = query.filter(getattr(model, search_field).ilike(f'%{q}%'))
        post_process = (lambda d: _redactar_sensibles(d, sensitive_fields, sensitive_permiso)) if sensitive_fields else None
        return paginate_query(query, out_schema, default_limit=25, post_process=post_process)

    @bp.route('/<int:id>', methods=['GET'])
    @modulo_lectura_required(modulo)
    def get_item(id):
        item = model.query.get_or_404(id)
        data = out_schema.model_validate(item).model_dump(mode='json')
        data = _redactar_sensibles(data, sensitive_fields, sensitive_permiso)
        return jsonify(data), 200

    @bp.route('', methods=['POST'])
    @modulo_escritura_required(modulo)
    def create_item():
        try:
            data = create_schema(**(request.get_json() or {}))
        except ValidationError as e:
            return jsonify(e.errors()), 400
        error_response = _nombre_duplicado(getattr(data, unique_name_field, None))
        if error_response:
            return error_response
        new_item = model(**data.model_dump())
        # Si el modelo tiene columnas de auditoría (Nomenclador, Autorizador,
        # etc.), se completan solas; los catálogos que no las tienen (Colega,
        # Método...) quedan exactamente igual que antes.
        if hasattr(new_item, 'creado_por_id'):
            new_item.creado_por_id = g.current_user.id
        if hasattr(new_item, 'actualizado_por_id'):
            new_item.actualizado_por_id = g.current_user.id
        db.session.add(new_item)
        error_response = _commit_or_400()
        if error_response:
            return error_response
        return jsonify(out_schema.model_validate(new_item).model_dump(mode='json')), 201

    @bp.route('/<int:id>', methods=['PUT'])
    @modulo_escritura_required(modulo)
    def update_item(id):
        item = model.query.get_or_404(id)
        try:
            data = update_schema(**(request.get_json() or {}))
        except ValidationError as e:
            return jsonify(e.errors()), 400
        campos = data.model_dump(exclude_unset=True)
        if unique_name_field in campos:
            error_response = _nombre_duplicado(campos[unique_name_field], excluir_id=id)
            if error_response:
                return error_response
        for field, value in campos.items():
            setattr(item, field, value)
        if hasattr(item, 'actualizado_por_id'):
            item.actualizado_por_id = g.current_user.id
        error_response = _commit_or_400()
        if error_response:
            return error_response
        return jsonify(out_schema.model_validate(item).model_dump(mode='json')), 200

    if allow_delete:
        @bp.route('/<int:id>', methods=['DELETE'])
        @modulo_escritura_required(modulo)
        def delete_item(id):
            item = model.query.get_or_404(id)
            db.session.delete(item)
            error_response = _commit_or_400()
            if error_response:
                return error_response
            return jsonify({"message": f"Registro {id} eliminado correctamente"}), 200

    return bp
