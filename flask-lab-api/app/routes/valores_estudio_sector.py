from app.crud import make_crud_blueprint
from app.models import ValorEstudioSector
from app.schemas import ValorEstudioSectorCreate, ValorEstudioSectorUpdate, ValorEstudioSectorOut

bp = make_crud_blueprint(
    'valores_estudio_sector', '/api/valores-estudio-sector', ValorEstudioSector,
    ValorEstudioSectorCreate, ValorEstudioSectorUpdate, ValorEstudioSectorOut,
)
