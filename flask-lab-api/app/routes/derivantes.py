from app.crud import make_crud_blueprint
from app.models import Derivante
from app.schemas import DerivanteCreate, DerivanteUpdate, DerivanteOut

bp = make_crud_blueprint(
    'derivantes', '/api/derivantes', Derivante,
    DerivanteCreate, DerivanteUpdate, DerivanteOut,
)
