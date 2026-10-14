from app.crud import make_crud_blueprint
from app.models import Sector
from app.schemas import SectorCreate, SectorUpdate, SectorOut

bp = make_crud_blueprint(
    'sectores', '/api/sectores', Sector,
    SectorCreate, SectorUpdate, SectorOut,
    order_by='nombre',
)
