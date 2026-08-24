from app.crud import make_crud_blueprint
from app.models import Estudio
from app.schemas import EstudioCreate, EstudioUpdate, EstudioOut

bp = make_crud_blueprint(
    'estudios', '/api/estudios', Estudio,
    EstudioCreate, EstudioUpdate, EstudioOut,
)
