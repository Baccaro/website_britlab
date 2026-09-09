from app.crud import make_crud_blueprint
from app.models import Metodo
from app.schemas import MetodoCreate, MetodoUpdate, MetodoOut

bp = make_crud_blueprint(
    'metodos', '/api/metodos', Metodo,
    MetodoCreate, MetodoUpdate, MetodoOut,
    allow_delete=False, search_field='nombre',
)
