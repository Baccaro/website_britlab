from pydantic import BaseModel, ConfigDict
from typing import Optional, List, Generic, TypeVar
from datetime import datetime

T = TypeVar('T')

class PaginatedResponse(BaseModel, Generic[T]):
    total: int
    page: int
    limit: int
    total_pages: int
    items: List[T]

# --- Colega ---
class ColegaBase(BaseModel):
    descripcion: str
    es_propio: Optional[bool] = False
    habilitado: Optional[bool] = True
    portal_url: Optional[str] = None
    # Sensibles: se redactan en la respuesta salvo admin o permiso explícito
    # (ver app/crud.py _redactar_sensibles y app/routes/colegas.py).
    portal_usuario: Optional[str] = None
    portal_password: Optional[str] = None
    observaciones: Optional[str] = None

class ColegaCreate(ColegaBase):
    pass

class ColegaUpdate(BaseModel):
    descripcion: Optional[str] = None
    es_propio: Optional[bool] = None
    habilitado: Optional[bool] = None
    portal_url: Optional[str] = None
    portal_usuario: Optional[str] = None
    portal_password: Optional[str] = None
    observaciones: Optional[str] = None

class ColegaOut(ColegaBase):
    id: int
    model_config = ConfigDict(from_attributes=True)

# --- Estudio ---
class EstudioBase(BaseModel):
    codigo_hexalis: str
    descripcion: str

class EstudioCreate(EstudioBase):
    pass

class EstudioUpdate(BaseModel):
    codigo_hexalis: Optional[str] = None
    descripcion: Optional[str] = None

class EstudioOut(EstudioBase):
    id: int
    model_config = ConfigDict(from_attributes=True)

# --- Metodo ---
class MetodoBase(BaseModel):
    nombre: str
    descripcion: Optional[str] = None

class MetodoCreate(MetodoBase):
    pass

class MetodoUpdate(BaseModel):
    nombre: Optional[str] = None
    descripcion: Optional[str] = None

class MetodoOut(MetodoBase):
    id: int
    model_config = ConfigDict(from_attributes=True)

# --- Muestra ---
class MuestraBase(BaseModel):
    nombre: str
    observacion: Optional[str] = None

class MuestraCreate(MuestraBase):
    pass

class MuestraUpdate(BaseModel):
    nombre: Optional[str] = None
    observacion: Optional[str] = None

class MuestraOut(MuestraBase):
    id: int
    model_config = ConfigDict(from_attributes=True)

# --- Sector ---
class SectorBase(BaseModel):
    nombre: str

class SectorCreate(SectorBase):
    pass

class SectorUpdate(BaseModel):
    nombre: Optional[str] = None

class SectorOut(SectorBase):
    id: int
    model_config = ConfigDict(from_attributes=True)

# --- Valor Estudio Sector ---
class ValorEstudioSectorBase(BaseModel):
    id_estudio: int
    id_sector: int
    posicion_informe: int
    rango: Optional[str] = None

class ValorEstudioSectorCreate(ValorEstudioSectorBase):
    pass

class ValorEstudioSectorUpdate(BaseModel):
    id_estudio: Optional[int] = None
    id_sector: Optional[int] = None
    posicion_informe: Optional[int] = None
    rango: Optional[str] = None

class ValorEstudioSectorOut(ValorEstudioSectorBase):
    id: int
    model_config = ConfigDict(from_attributes=True)

# --- Estudio Colega ---
class EstudioColegaBase(BaseModel):
    nemonico_datatech: str
    paridad_datatech_hexalis: Optional[str] = 'pendiente'
    id_estudio: int
    id_metodo: Optional[int] = None
    id_muestra: Optional[int] = None
    id_sector_laboratorio: Optional[int] = None
    indicaciones_pacientes: Optional[str] = None
    indicaciones_colega: Optional[str] = None
    preanalitico_descripcion: Optional[str] = None
    modelo_derivante_observaciones: Optional[str] = None
    dias_demora: Optional[int] = 0
    estado: Optional[str] = 'pendiente'
    codigo_laboratorio: Optional[str] = None
    version: Optional[int] = 1
    revisor: str
    observacion: Optional[str] = None
    colega_id: int

class EstudioColegaCreate(EstudioColegaBase):
    pass

class EstudioColegaUpdate(BaseModel):
    nemonico_datatech: Optional[str] = None
    paridad_datatech_hexalis: Optional[str] = None
    id_estudio: Optional[int] = None
    id_metodo: Optional[int] = None
    id_muestra: Optional[int] = None
    id_sector_laboratorio: Optional[int] = None
    indicaciones_pacientes: Optional[str] = None
    indicaciones_colega: Optional[str] = None
    preanalitico_descripcion: Optional[str] = None
    modelo_derivante_observaciones: Optional[str] = None
    dias_demora: Optional[int] = None
    estado: Optional[str] = None
    codigo_laboratorio: Optional[str] = None
    version: Optional[int] = None
    revisor: Optional[str] = None
    observacion: Optional[str] = None
    colega_id: Optional[int] = None

class EstudioColegaOut(EstudioColegaBase):
    id: int
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None
    model_config = ConfigDict(from_attributes=True)


# --- Catálogos de Muestras estructuradas (todos son "id + nombre") ---
class TipoMuestraBase(BaseModel):
    nombre: str

class TipoMuestraCreate(TipoMuestraBase):
    pass

class TipoMuestraUpdate(BaseModel):
    nombre: Optional[str] = None

class TipoMuestraOut(TipoMuestraBase):
    id: int
    model_config = ConfigDict(from_attributes=True)


class AditivoBase(BaseModel):
    nombre: str

class AditivoCreate(AditivoBase):
    pass

class AditivoUpdate(BaseModel):
    nombre: Optional[str] = None

class AditivoOut(AditivoBase):
    id: int
    model_config = ConfigDict(from_attributes=True)


class UnidadMedidaBase(BaseModel):
    nombre: str

class UnidadMedidaCreate(UnidadMedidaBase):
    pass

class UnidadMedidaUpdate(BaseModel):
    nombre: Optional[str] = None

class UnidadMedidaOut(UnidadMedidaBase):
    id: int
    model_config = ConfigDict(from_attributes=True)


class RecipienteBase(BaseModel):
    nombre: str

class RecipienteCreate(RecipienteBase):
    pass

class RecipienteUpdate(BaseModel):
    nombre: Optional[str] = None

class RecipienteOut(RecipienteBase):
    id: int
    model_config = ConfigDict(from_attributes=True)


class ModalidadRecoleccionBase(BaseModel):
    nombre: str

class ModalidadRecoleccionCreate(ModalidadRecoleccionBase):
    pass

class ModalidadRecoleccionUpdate(BaseModel):
    nombre: Optional[str] = None

class ModalidadRecoleccionOut(ModalidadRecoleccionBase):
    id: int
    model_config = ConfigDict(from_attributes=True)


class TecnicaRecoleccionBase(BaseModel):
    nombre: str

class TecnicaRecoleccionCreate(TecnicaRecoleccionBase):
    pass

class TecnicaRecoleccionUpdate(BaseModel):
    nombre: Optional[str] = None

class TecnicaRecoleccionOut(TecnicaRecoleccionBase):
    id: int
    model_config = ConfigDict(from_attributes=True)


class ConservacionBase(BaseModel):
    nombre: str

class ConservacionCreate(ConservacionBase):
    pass

class ConservacionUpdate(BaseModel):
    nombre: Optional[str] = None

class ConservacionOut(ConservacionBase):
    id: int
    model_config = ConfigDict(from_attributes=True)


class CondicionEspecialBase(BaseModel):
    nombre: str

class CondicionEspecialCreate(CondicionEspecialBase):
    pass

class CondicionEspecialUpdate(BaseModel):
    nombre: Optional[str] = None

class CondicionEspecialOut(CondicionEspecialBase):
    id: int
    model_config = ConfigDict(from_attributes=True)


class PrioridadEnvioBase(BaseModel):
    nombre: str

class PrioridadEnvioCreate(PrioridadEnvioBase):
    pass

class PrioridadEnvioUpdate(BaseModel):
    nombre: Optional[str] = None

class PrioridadEnvioOut(PrioridadEnvioBase):
    id: int
    model_config = ConfigDict(from_attributes=True)

# --- Estudio Colega Muestra ---
class EstudioColegaMuestraBase(BaseModel):
    id_estudio_colega: int
    id_tipo_muestra: int
    id_aditivo: Optional[int] = None
    volumen: Optional[float] = None
    id_unidad_medida: Optional[int] = None
    id_recipiente: Optional[int] = None
    id_modalidad_recoleccion: Optional[int] = None
    id_tecnica_recoleccion: Optional[int] = None
    id_conservacion: Optional[int] = None
    id_condicion_especial: Optional[int] = None
    id_prioridad_envio: Optional[int] = None
    orden: Optional[int] = 1
    observacion: Optional[str] = None

class EstudioColegaMuestraCreate(EstudioColegaMuestraBase):
    pass

class EstudioColegaMuestraUpdate(BaseModel):
    id_estudio_colega: Optional[int] = None
    id_tipo_muestra: Optional[int] = None
    id_aditivo: Optional[int] = None
    volumen: Optional[float] = None
    id_unidad_medida: Optional[int] = None
    id_recipiente: Optional[int] = None
    id_modalidad_recoleccion: Optional[int] = None
    id_tecnica_recoleccion: Optional[int] = None
    id_conservacion: Optional[int] = None
    id_condicion_especial: Optional[int] = None
    id_prioridad_envio: Optional[int] = None
    orden: Optional[int] = None
    observacion: Optional[str] = None

class EstudioColegaMuestraOut(EstudioColegaMuestraBase):
    id: int
    created_at: Optional[datetime] = None
    model_config = ConfigDict(from_attributes=True)


# --- Estudio Colega Muestra Alternativa ---
class EstudioColegaMuestraAlternativaBase(BaseModel):
    id_estudio_colega_muestra: int
    id_tipo_muestra: int
    id_aditivo: Optional[int] = None
    volumen: Optional[float] = None
    id_unidad_medida: Optional[int] = None
    id_recipiente: Optional[int] = None
    id_modalidad_recoleccion: Optional[int] = None
    id_tecnica_recoleccion: Optional[int] = None
    id_conservacion: Optional[int] = None
    id_condicion_especial: Optional[int] = None
    id_prioridad_envio: Optional[int] = None
    orden: Optional[int] = 1
    observacion: Optional[str] = None

class EstudioColegaMuestraAlternativaCreate(EstudioColegaMuestraAlternativaBase):
    pass

class EstudioColegaMuestraAlternativaUpdate(BaseModel):
    id_estudio_colega_muestra: Optional[int] = None
    id_tipo_muestra: Optional[int] = None
    id_aditivo: Optional[int] = None
    volumen: Optional[float] = None
    id_unidad_medida: Optional[int] = None
    id_recipiente: Optional[int] = None
    id_modalidad_recoleccion: Optional[int] = None
    id_tecnica_recoleccion: Optional[int] = None
    id_conservacion: Optional[int] = None
    id_condicion_especial: Optional[int] = None
    id_prioridad_envio: Optional[int] = None
    orden: Optional[int] = None
    observacion: Optional[str] = None

class EstudioColegaMuestraAlternativaOut(EstudioColegaMuestraAlternativaBase):
    id: int
    created_at: Optional[datetime] = None
    model_config = ConfigDict(from_attributes=True)


# --- Usuario / autenticación ---
class UsuarioBase(BaseModel):
    username: str
    nombre_completo: Optional[str] = None
    email: Optional[str] = None
    rol: str = 'user'
    activo: Optional[bool] = True
    permisos: Optional[dict] = None

class UsuarioCreate(UsuarioBase):
    password: str

class UsuarioUpdate(BaseModel):
    nombre_completo: Optional[str] = None
    email: Optional[str] = None
    rol: Optional[str] = None
    activo: Optional[bool] = None
    permisos: Optional[dict] = None

class UsuarioOut(UsuarioBase):
    id: int
    created_at: Optional[datetime] = None
    model_config = ConfigDict(from_attributes=True)

class LoginRequest(BaseModel):
    username: str
    password: str

class RegistroRequest(BaseModel):
    username: str
    password: str
    nombre_completo: Optional[str] = None
    email: Optional[str] = None

class OlvideContrasenaRequest(BaseModel):
    username: str

class ResetearContrasenaRequest(BaseModel):
    token: str
    password: str

class AdminResetearContrasenaRequest(BaseModel):
    password: Optional[str] = None


# --- FAQ ---
class FaqCreate(BaseModel):
    pregunta: str
    respuesta: str
    categoria: str
    disponible_web: Optional[bool] = False
    disponible_ia: Optional[bool] = False
    estado: Optional[str] = 'borrador'

class FaqUpdate(BaseModel):
    pregunta: Optional[str] = None
    respuesta: Optional[str] = None
    categoria: Optional[str] = None
    disponible_web: Optional[bool] = None
    disponible_ia: Optional[bool] = None
    estado: Optional[str] = None
