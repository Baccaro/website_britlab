from app.database import db
from datetime import datetime


class Colega(db.Model):
    __tablename__ = 'colega'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    descripcion = db.Column(db.String(255), nullable=False)
    es_propio = db.Column(db.Boolean, nullable=False, default=False)


class Estudio(db.Model):
    __tablename__ = 'estudio'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    codigo_hexalis = db.Column(db.String(50), unique=True, nullable=False)
    descripcion = db.Column(db.Text, nullable=False)


class Metodo(db.Model):
    __tablename__ = 'metodo'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), unique=True, nullable=False)
    descripcion = db.Column(db.Text, nullable=True)


class Muestra(db.Model):
    __tablename__ = 'muestra'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(150), unique=True, nullable=False)
    observacion = db.Column(db.Text, nullable=True)


class Preanalitico(db.Model):
    __tablename__ = 'preanalitico'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(150), unique=True, nullable=False)
    descripcion = db.Column(db.Text, nullable=True)


class Sector(db.Model):
    __tablename__ = 'sector'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(150), unique=True, nullable=False)


class ValorEstudioSector(db.Model):
    __tablename__ = 'valor_estudio_sector'
    __table_args__ = (
        db.UniqueConstraint('id_estudio', 'id_sector', 'posicion_informe', name='uq_estudio_sector_posicion'),
        {'schema': 'public'}
    )

    id = db.Column(db.Integer, primary_key=True)
    id_estudio = db.Column(db.Integer, db.ForeignKey('public.estudio.id', ondelete='CASCADE'), nullable=False)
    id_sector = db.Column(db.Integer, db.ForeignKey('public.sector.id'), nullable=False)
    posicion_informe = db.Column(db.Integer, nullable=False)
    rango = db.Column(db.String(100), nullable=True)

    sector = db.relationship('Sector')


class EstudioColega(db.Model):
    __tablename__ = 'estudio_colega'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    nemonico_datatech = db.Column(db.String(50), nullable=False)
    # Enums de Postgres (estado_paridad_enum / estado_registro_enum) manejados como texto plano
    # del lado de SQLAlchemy; la validación de valores permitidos vive en el propio tipo de la BD.
    paridad_datatech_hexalis = db.Column(db.String(20), nullable=False, default='pendiente')
    id_estudio = db.Column(db.Integer, db.ForeignKey('public.estudio.id', ondelete='RESTRICT'), nullable=False)
    id_metodo = db.Column(db.Integer, db.ForeignKey('public.metodo.id', ondelete='SET NULL'), nullable=True)
    id_preanalitico = db.Column(db.Integer, db.ForeignKey('public.preanalitico.id', ondelete='SET NULL'), nullable=True)
    id_muestra = db.Column(db.Integer, db.ForeignKey('public.muestra.id', ondelete='SET NULL'), nullable=True)
    id_sector_laboratorio = db.Column(db.Integer, db.ForeignKey('public.valor_estudio_sector.id', ondelete='SET NULL'), nullable=True)
    indicaciones_pacientes = db.Column(db.Text, nullable=True)
    indicaciones_colega = db.Column(db.Text, nullable=True)
    valor_referencia = db.Column(db.Text, nullable=True)
    dias_demora = db.Column(db.Integer, default=0)
    estado = db.Column(db.String(20), nullable=False, default='pendiente')
    codigo_laboratorio = db.Column(db.String(50), nullable=True)
    version = db.Column(db.Integer, nullable=False, default=1)
    revisor = db.Column(db.String(100), nullable=False)
    observacion = db.Column(db.Text, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    colega_id = db.Column(db.Integer, db.ForeignKey('public.colega.id', ondelete='RESTRICT'), nullable=False)

    estudio = db.relationship('Estudio')
    metodo = db.relationship('Metodo')
    preanalitico = db.relationship('Preanalitico')
    muestra = db.relationship('Muestra')
    sector_laboratorio = db.relationship('ValorEstudioSector')
    colega = db.relationship('Colega')


# --- Muestras estructuradas (1..N por estudio_colega) ------------------------
# Aditivo respecto del modelo anterior: 'muestra' / 'estudio_colega.id_muestra'
# se mantienen tal cual; esto es una capacidad nueva.

class TipoMuestra(db.Model):
    __tablename__ = 'tipo_muestra'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(150), unique=True, nullable=False)


class Aditivo(db.Model):
    __tablename__ = 'aditivo'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), unique=True, nullable=False)


class UnidadMedida(db.Model):
    __tablename__ = 'unidad_medida'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(50), unique=True, nullable=False)


class Recipiente(db.Model):
    __tablename__ = 'recipiente'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), unique=True, nullable=False)


class ModalidadRecoleccion(db.Model):
    __tablename__ = 'modalidad_recoleccion'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(150), unique=True, nullable=False)


class TecnicaRecoleccion(db.Model):
    __tablename__ = 'tecnica_recoleccion'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(150), unique=True, nullable=False)


class Conservacion(db.Model):
    __tablename__ = 'conservacion'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), unique=True, nullable=False)


class CondicionEspecial(db.Model):
    __tablename__ = 'condicion_especial'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), unique=True, nullable=False)


class PrioridadEnvio(db.Model):
    __tablename__ = 'prioridad_envio'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), unique=True, nullable=False)


class EstudioColegaMuestra(db.Model):
    __tablename__ = 'estudio_colega_muestra'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    id_estudio_colega = db.Column(db.Integer, db.ForeignKey('public.estudio_colega.id', ondelete='CASCADE'), nullable=False)
    id_tipo_muestra = db.Column(db.Integer, db.ForeignKey('public.tipo_muestra.id'), nullable=False)
    id_aditivo = db.Column(db.Integer, db.ForeignKey('public.aditivo.id', ondelete='SET NULL'), nullable=True)
    volumen = db.Column(db.Numeric(10, 2), nullable=True)
    id_unidad_medida = db.Column(db.Integer, db.ForeignKey('public.unidad_medida.id', ondelete='SET NULL'), nullable=True)
    id_recipiente = db.Column(db.Integer, db.ForeignKey('public.recipiente.id', ondelete='SET NULL'), nullable=True)
    id_modalidad_recoleccion = db.Column(db.Integer, db.ForeignKey('public.modalidad_recoleccion.id', ondelete='SET NULL'), nullable=True)
    id_tecnica_recoleccion = db.Column(db.Integer, db.ForeignKey('public.tecnica_recoleccion.id', ondelete='SET NULL'), nullable=True)
    id_conservacion = db.Column(db.Integer, db.ForeignKey('public.conservacion.id', ondelete='SET NULL'), nullable=True)
    id_condicion_especial = db.Column(db.Integer, db.ForeignKey('public.condicion_especial.id', ondelete='SET NULL'), nullable=True)
    id_prioridad_envio = db.Column(db.Integer, db.ForeignKey('public.prioridad_envio.id', ondelete='SET NULL'), nullable=True)
    orden = db.Column(db.Integer, nullable=False, default=1)
    observacion = db.Column(db.Text, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    tipo_muestra = db.relationship('TipoMuestra')
    aditivo = db.relationship('Aditivo')
    unidad_medida = db.relationship('UnidadMedida')
    recipiente = db.relationship('Recipiente')
    modalidad_recoleccion = db.relationship('ModalidadRecoleccion')
    tecnica_recoleccion = db.relationship('TecnicaRecoleccion')
    conservacion = db.relationship('Conservacion')
    condicion_especial = db.relationship('CondicionEspecial')
    prioridad_envio = db.relationship('PrioridadEnvio')
    alternativas = db.relationship('EstudioColegaMuestraAlternativa', order_by='EstudioColegaMuestraAlternativa.orden')


class EstudioColegaMuestraAlternativa(db.Model):
    """Alternativa de una muestra puntual (no del estudio_colega directamente):
    un estudio tiene N muestras, y cada muestra puede tener N alternativas."""
    __tablename__ = 'estudio_colega_muestra_alternativa'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    id_estudio_colega_muestra = db.Column(db.Integer, db.ForeignKey('public.estudio_colega_muestra.id', ondelete='CASCADE'), nullable=False)
    id_tipo_muestra = db.Column(db.Integer, db.ForeignKey('public.tipo_muestra.id'), nullable=False)
    id_aditivo = db.Column(db.Integer, db.ForeignKey('public.aditivo.id', ondelete='SET NULL'), nullable=True)
    volumen = db.Column(db.Numeric(10, 2), nullable=True)
    id_unidad_medida = db.Column(db.Integer, db.ForeignKey('public.unidad_medida.id', ondelete='SET NULL'), nullable=True)
    id_recipiente = db.Column(db.Integer, db.ForeignKey('public.recipiente.id', ondelete='SET NULL'), nullable=True)
    id_modalidad_recoleccion = db.Column(db.Integer, db.ForeignKey('public.modalidad_recoleccion.id', ondelete='SET NULL'), nullable=True)
    id_tecnica_recoleccion = db.Column(db.Integer, db.ForeignKey('public.tecnica_recoleccion.id', ondelete='SET NULL'), nullable=True)
    id_conservacion = db.Column(db.Integer, db.ForeignKey('public.conservacion.id', ondelete='SET NULL'), nullable=True)
    id_condicion_especial = db.Column(db.Integer, db.ForeignKey('public.condicion_especial.id', ondelete='SET NULL'), nullable=True)
    id_prioridad_envio = db.Column(db.Integer, db.ForeignKey('public.prioridad_envio.id', ondelete='SET NULL'), nullable=True)
    orden = db.Column(db.Integer, nullable=False, default=1)
    observacion = db.Column(db.Text, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    tipo_muestra = db.relationship('TipoMuestra')
    aditivo = db.relationship('Aditivo')
    unidad_medida = db.relationship('UnidadMedida')
    recipiente = db.relationship('Recipiente')
    modalidad_recoleccion = db.relationship('ModalidadRecoleccion')
    tecnica_recoleccion = db.relationship('TecnicaRecoleccion')
    conservacion = db.relationship('Conservacion')
    condicion_especial = db.relationship('CondicionEspecial')
    prioridad_envio = db.relationship('PrioridadEnvio')


class EstudioColegaModelo(db.Model):
    """Modelo de informe (PDF) que el colega adjunta a un Estudio x Colega:
    1..N por registro, guardados como bytea en la BD."""
    __tablename__ = 'estudio_colega_modelo'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    id_estudio_colega = db.Column(db.Integer, db.ForeignKey('public.estudio_colega.id', ondelete='CASCADE'), nullable=False)
    nombre_archivo = db.Column(db.String(255), nullable=False)
    contenido = db.Column(db.LargeBinary, nullable=False)
    tamanio_bytes = db.Column(db.Integer, nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
