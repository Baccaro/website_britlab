from app.crud import make_crud_blueprint
from app.models import Nomenclador
from app.schemas import NomencladorCreate, NomencladorUpdate, NomencladorOut

# Reutilizable entre Obras Sociales (relación M2M en obra_social_nomenclador):
# no se borra, sólo se inactiva (allow_delete=False) para no dejar huérfanas
# esas relaciones ni perder historial de qué nomenclador usó cada una.
bp = make_crud_blueprint(
    'nomencladores', '/api/nomencladores', Nomenclador,
    NomencladorCreate, NomencladorUpdate, NomencladorOut,
    order_by='nombre', allow_delete=False, search_field='nombre',
    unique_name_field='nombre', modulo='obras_sociales',
)
