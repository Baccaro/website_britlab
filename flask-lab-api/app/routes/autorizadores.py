from app.crud import make_crud_blueprint
from app.models import Autorizador
from app.schemas import AutorizadorCreate, AutorizadorUpdate, AutorizadorOut

# Reutilizable entre Obras Sociales (relación M2M en obra_social_autorizador,
# que además guarda las credenciales propias de cada relación): no se borra,
# sólo se inactiva (allow_delete=False), como pide el documento de negocio.
bp = make_crud_blueprint(
    'autorizadores', '/api/autorizadores', Autorizador,
    AutorizadorCreate, AutorizadorUpdate, AutorizadorOut,
    order_by='nombre', allow_delete=False, search_field='nombre',
    unique_name_field='nombre', modulo='obras_sociales',
)
