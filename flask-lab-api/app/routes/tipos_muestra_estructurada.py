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

# Todos son "id + nombre": buscables por nombre y con nombre único (sin
# distinguir mayúsculas/tildes, ver app/utils.py normalizar_nombre) para no
# poder cargar, p.ej., "Calculo" si ya existe "Cálculo".
bp_tipo_muestra = make_crud_blueprint(
    'tipos_muestra', '/api/tipos-muestra', TipoMuestra,
    TipoMuestraCreate, TipoMuestraUpdate, TipoMuestraOut,
    allow_delete=False, search_field='nombre', unique_name_field='nombre',
)
bp_aditivo = make_crud_blueprint(
    'aditivos', '/api/aditivos', Aditivo,
    AditivoCreate, AditivoUpdate, AditivoOut,
    allow_delete=False, search_field='nombre', unique_name_field='nombre',
)
bp_unidad_medida = make_crud_blueprint(
    'unidades_medida', '/api/unidades-medida', UnidadMedida,
    UnidadMedidaCreate, UnidadMedidaUpdate, UnidadMedidaOut,
    allow_delete=False, search_field='nombre', unique_name_field='nombre',
)
bp_recipiente = make_crud_blueprint(
    'recipientes', '/api/recipientes', Recipiente,
    RecipienteCreate, RecipienteUpdate, RecipienteOut,
    allow_delete=False, search_field='nombre', unique_name_field='nombre',
)
bp_modalidad_recoleccion = make_crud_blueprint(
    'modalidades_recoleccion', '/api/modalidades-recoleccion', ModalidadRecoleccion,
    ModalidadRecoleccionCreate, ModalidadRecoleccionUpdate, ModalidadRecoleccionOut,
    allow_delete=False, search_field='nombre', unique_name_field='nombre',
)
bp_tecnica_recoleccion = make_crud_blueprint(
    'tecnicas_recoleccion', '/api/tecnicas-recoleccion', TecnicaRecoleccion,
    TecnicaRecoleccionCreate, TecnicaRecoleccionUpdate, TecnicaRecoleccionOut,
    allow_delete=False, search_field='nombre', unique_name_field='nombre',
)
bp_conservacion = make_crud_blueprint(
    'conservaciones', '/api/conservaciones', Conservacion,
    ConservacionCreate, ConservacionUpdate, ConservacionOut,
    allow_delete=False, search_field='nombre', unique_name_field='nombre',
)
bp_condicion_especial = make_crud_blueprint(
    'condiciones_especiales', '/api/condiciones-especiales', CondicionEspecial,
    CondicionEspecialCreate, CondicionEspecialUpdate, CondicionEspecialOut,
    allow_delete=False, search_field='nombre', unique_name_field='nombre',
)
bp_prioridad_envio = make_crud_blueprint(
    'prioridades_envio', '/api/prioridades-envio', PrioridadEnvio,
    PrioridadEnvioCreate, PrioridadEnvioUpdate, PrioridadEnvioOut,
    allow_delete=False, search_field='nombre', unique_name_field='nombre',
)

ALL_BLUEPRINTS = [
    bp_tipo_muestra, bp_aditivo, bp_unidad_medida, bp_recipiente,
    bp_modalidad_recoleccion, bp_tecnica_recoleccion, bp_conservacion,
    bp_condicion_especial, bp_prioridad_envio,
]
