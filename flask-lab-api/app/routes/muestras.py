from app.crud import make_crud_blueprint
from app.models import Muestra
from app.schemas import MuestraCreate, MuestraUpdate, MuestraOut

bp = make_crud_blueprint(
    'muestras', '/api/muestras', Muestra,
    MuestraCreate, MuestraUpdate, MuestraOut,
)
