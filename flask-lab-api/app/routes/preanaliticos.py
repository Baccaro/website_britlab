from app.crud import make_crud_blueprint
from app.models import Preanalitico
from app.schemas import PreanaliticoCreate, PreanaliticoUpdate, PreanaliticoOut

bp = make_crud_blueprint(
    'preanaliticos', '/api/preanaliticos', Preanalitico,
    PreanaliticoCreate, PreanaliticoUpdate, PreanaliticoOut,
)
