import unicodedata

from flask import request


def normalizar_nombre(texto):
    """Minúsculas + sin tildes/diacríticos, para comparar nombres de catálogos
    (colega, método, tipo de muestra, etc.) sin distinguir mayúsculas ni
    acentos: 'Cálculo' y 'calculo' deben verse como el mismo nombre."""
    if not texto:
        return ''
    sin_acentos = unicodedata.normalize('NFKD', texto).encode('ascii', 'ignore').decode('ascii')
    return sin_acentos.strip().lower()


def paginate_query(query, schema_cls, default_limit=50, post_process=None):
    page = request.args.get('page', 1, type=int)
    limit = request.args.get('limit', default_limit, type=int)

    pagination = query.paginate(page=page, per_page=limit, error_out=False)

    items_data = [schema_cls.model_validate(item).model_dump(mode='json') for item in pagination.items]
    if post_process:
        items_data = [post_process(d) for d in items_data]

    return {
        "total": pagination.total,
        "page": page,
        "limit": limit,
        "total_pages": pagination.pages,
        "items": items_data
    }, 200
