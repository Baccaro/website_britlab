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

# --- Derivante ---
class DerivanteBase(BaseModel):
    descripcion: str

class DerivanteCreate(DerivanteBase):
    pass

class DerivanteUpdate(BaseModel):
    descripcion: Optional[str] = None

class DerivanteOut(DerivanteBase):
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

# --- Preanalitico ---
class PreanaliticoBase(BaseModel):
    nombre: str
    descripcion: Optional[str] = None

class PreanaliticoCreate(PreanaliticoBase):
    pass

class PreanaliticoUpdate(BaseModel):
    nombre: Optional[str] = None
    descripcion: Optional[str] = None

class PreanaliticoOut(PreanaliticoBase):
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

# --- Estudio Derivante ---
class EstudioDerivanteBase(BaseModel):
    nemonico_datatech: str
    paridad_datatech_hexalis: Optional[str] = 'pendiente'
    id_estudio: int
    id_metodo: Optional[int] = None
    id_preanalitico: Optional[int] = None
    id_muestra: Optional[int] = None
    id_sector_laboratorio: Optional[int] = None
    indicaciones: Optional[str] = None
    valor_referencia: Optional[str] = None
    dias_demora: Optional[int] = 0
    estado: Optional[str] = 'pendiente'
    codigo_laboratorio: Optional[str] = None
    version: Optional[int] = 1
    revisor: str
    observacion: Optional[str] = None
    derivante_id: int

class EstudioDerivanteCreate(EstudioDerivanteBase):
    pass

class EstudioDerivanteUpdate(BaseModel):
    nemonico_datatech: Optional[str] = None
    paridad_datatech_hexalis: Optional[str] = None
    id_estudio: Optional[int] = None
    id_metodo: Optional[int] = None
    id_preanalitico: Optional[int] = None
    id_muestra: Optional[int] = None
    id_sector_laboratorio: Optional[int] = None
    indicaciones: Optional[str] = None
    valor_referencia: Optional[str] = None
    dias_demora: Optional[int] = None
    estado: Optional[str] = None
    codigo_laboratorio: Optional[str] = None
    version: Optional[int] = None
    revisor: Optional[str] = None
    observacion: Optional[str] = None
    derivante_id: Optional[int] = None

class EstudioDerivanteOut(EstudioDerivanteBase):
    id: int
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None
    model_config = ConfigDict(from_attributes=True)
