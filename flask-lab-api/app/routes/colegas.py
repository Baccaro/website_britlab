from app.crud import make_crud_blueprint
from app.models import Colega
from app.schemas import ColegaCreate, ColegaUpdate, ColegaOut

bp = make_crud_blueprint(
    'colegas', '/api/colegas', Colega,
    ColegaCreate, ColegaUpdate, ColegaOut,
)
