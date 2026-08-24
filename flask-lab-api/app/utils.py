from flask import request

def paginate_query(query, schema_cls, default_limit=50):
    page = request.args.get('page', 1, type=int)
    limit = request.args.get('limit', default_limit, type=int)

    pagination = query.paginate(page=page, per_page=limit, error_out=False)

    items_data = [schema_cls.model_validate(item).model_dump(mode='json') for item in pagination.items]

    return {
        "total": pagination.total,
        "page": page,
        "limit": limit,
        "total_pages": pagination.pages,
        "items": items_data
    }, 200
