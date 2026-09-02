"""Blueprints CRUD para los catálogos de la muestra estructurada
(1..N muestras por estudio_colega, ver estudio_colega_muestra.py)."""
from app.crud import make_crud_blueprint
from app.models import (
    TipoMuestra, Aditivo, UnidadMedida, Recipiente, ModalidadRecoleccion,
    TecnicaRecoleccion, Conservacion, CondicionEspecial, PrioridadEnvio,
)
from app.schemas import (
    TipoMuestraCreate, TipoMuestraUpdate, TipoMuestraOut,
    AditivoCreate, AditivoUpdate, AditivoOut,
    UnidadMedidaCreate, UnidadMedidaUpdate, UnidadMedidaOut,
    RecipienteCreate, RecipienteUpdate, RecipienteOut,
    ModalidadRecoleccionCreate, ModalidadRecoleccionUpdate, ModalidadRecoleccionOut,
    TecnicaRecoleccionCreate, TecnicaRecoleccionUpdate, TecnicaRecoleccionOut,
    ConservacionCreate, ConservacionUpdate, ConservacionOut,
    CondicionEspecialCreate, CondicionEspecialUpdate, CondicionEspecialOut,
    PrioridadEnvioCreate, PrioridadEnvioUpdate, PrioridadEnvioOut,
)

bp_tipo_muestra = make_crud_blueprint(
    'tipos_muestra', '/api/tipos-muestra', TipoMuestra,
    TipoMuestraCreate, TipoMuestraUpdate, TipoMuestraOut,
)
bp_aditivo = make_crud_blueprint(
    'aditivos', '/api/aditivos', Aditivo,
    AditivoCreate, AditivoUpdate, AditivoOut,
)
bp_unidad_medida = make_crud_blueprint(
    'unidades_medida', '/api/unidades-medida', UnidadMedida,
    UnidadMedidaCreate, UnidadMedidaUpdate, UnidadMedidaOut,
)
bp_recipiente = make_crud_blueprint(
    'recipientes', '/api/recipientes', Recipiente,
    RecipienteCreate, RecipienteUpdate, RecipienteOut,
)
bp_modalidad_recoleccion = make_crud_blueprint(
    'modalidades_recoleccion', '/api/modalidades-recoleccion', ModalidadRecoleccion,
    ModalidadRecoleccionCreate, ModalidadRecoleccionUpdate, ModalidadRecoleccionOut,
)
bp_tecnica_recoleccion = make_crud_blueprint(
    'tecnicas_recoleccion', '/api/tecnicas-recoleccion', TecnicaRecoleccion,
    TecnicaRecoleccionCreate, TecnicaRecoleccionUpdate, TecnicaRecoleccionOut,
)
bp_conservacion = make_crud_blueprint(
    'conservaciones', '/api/conservaciones', Conservacion,
    ConservacionCreate, ConservacionUpdate, ConservacionOut,
)
bp_condicion_especial = make_crud_blueprint(
    'condiciones_especiales', '/api/condiciones-especiales', CondicionEspecial,
    CondicionEspecialCreate, CondicionEspecialUpdate, CondicionEspecialOut,
)
bp_prioridad_envio = make_crud_blueprint(
    'prioridades_envio', '/api/prioridades-envio', PrioridadEnvio,
    PrioridadEnvioCreate, PrioridadEnvioUpdate, PrioridadEnvioOut,
)

ALL_BLUEPRINTS = [
    bp_tipo_muestra, bp_aditivo, bp_unidad_medida, bp_recipiente,
    bp_modalidad_recoleccion, bp_tecnica_recoleccion, bp_conservacion,
    bp_condicion_especial, bp_prioridad_envio,
]
