from app.database import db
from datetime import datetime


class Colega(db.Model):
    __tablename__ = 'colega'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    descripcion = db.Column(db.String(255), unique=True, nullable=False)
    es_propio = db.Column(db.Boolean, nullable=False, default=False)
    # No se borran colegas (quedarían huérfanos sus estudios): se habilitan o
    # deshabilitan. Al deshabilitar, opcionalmente se pasan a 'pendiente' todos
    # sus registros Estudio x Colega (ver routes/colegas.py).
    habilitado = db.Column(db.Boolean, nullable=False, default=True)
    portal_url = db.Column(db.Text, nullable=True)
    # Credenciales del portal externo del colega: sensibles, sólo un admin (o
    # un 'user' con permisos.ver_credenciales_colegas) las ve en la API (ver
    # app/crud.py _redactar_sensibles). No van hasheadas ni cifradas: son
    # credenciales de un sistema externo que el admin necesita leer tal cual,
    # no una contraseña de acceso a esta aplicación.
    portal_usuario = db.Column(db.String(150), nullable=True)
    portal_password = db.Column(db.String(255), nullable=True)
    observaciones = db.Column(db.Text, nullable=True)


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
    paridad_datatech_hexalis = db.Column(db.String(20), nullable=False, default='No')
    id_estudio = db.Column(db.Integer, db.ForeignKey('public.estudio.id', ondelete='RESTRICT'), nullable=False)
    id_metodo = db.Column(db.Integer, db.ForeignKey('public.metodo.id', ondelete='SET NULL'), nullable=True)
    id_muestra = db.Column(db.Integer, db.ForeignKey('public.muestra.id', ondelete='SET NULL'), nullable=True)
    id_sector_laboratorio = db.Column(db.Integer, db.ForeignKey('public.valor_estudio_sector.id', ondelete='SET NULL'), nullable=True)
    indicaciones_pacientes = db.Column(db.Text, nullable=True)
    indicaciones_colega = db.Column(db.Text, nullable=True)
    # Descripción propia del dropdown "Preanalítico" (ya no hay catálogo
    # id_preanalitico: se eliminó junto con la tabla preanalitico) y
    # Observaciones del dropdown "Modelo Derivante" (independiente de
    # indicaciones_colega, que quedó sólo texto).
    preanalitico_descripcion = db.Column(db.Text, nullable=True)
    modelo_derivante_observaciones = db.Column(db.Text, nullable=True)
    dias_demora = db.Column(db.Integer, default=0)
    estado = db.Column(db.String(20), nullable=False, default='pendiente')
    codigo_laboratorio = db.Column(db.String(50), nullable=True)
    codigo_ams = db.Column(db.String(100), nullable=True)
    habilitar_web = db.Column(db.Boolean, nullable=False, default=False)
    habilitar_ia = db.Column(db.Boolean, nullable=False, default=False)
    version = db.Column(db.Integer, nullable=False, default=1)
    revisor = db.Column(db.String(100), nullable=False)
    observacion = db.Column(db.Text, nullable=True)
    creado_por_id = db.Column(db.Integer, db.ForeignKey('public.usuario.id', ondelete='SET NULL'), nullable=True)
    actualizado_por_id = db.Column(db.Integer, db.ForeignKey('public.usuario.id', ondelete='SET NULL'), nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    colega_id = db.Column(db.Integer, db.ForeignKey('public.colega.id', ondelete='RESTRICT'), nullable=False)

    estudio = db.relationship('Estudio')
    metodo = db.relationship('Metodo')
    muestra = db.relationship('Muestra')
    sector_laboratorio = db.relationship('ValorEstudioSector')
    colega = db.relationship('Colega')
    creado_por = db.relationship('Usuario', foreign_keys=[creado_por_id])
    actualizado_por = db.relationship('Usuario', foreign_keys=[actualizado_por_id])

    @property
    def creado_por_username(self):
        return self.creado_por.username if self.creado_por else None

    @property
    def actualizado_por_username(self):
        return self.actualizado_por.username if self.actualizado_por else None


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
    # A qué dropdown pertenece: 'preanalitico', 'paciente' o 'colega' (Modelo
    # Derivante). 'descripcion' es el comentario propio de cada archivo
    # (pensado para 'colega', pero disponible para cualquier categoría).
    categoria = db.Column(db.String(20), nullable=False, default='colega')
    descripcion = db.Column(db.Text, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)


class Usuario(db.Model):
    """Cuenta de acceso al sistema. 'admin' tiene acceso total (incluye este
    panel de usuarios); 'user' es de sólo lectura, acotado a las pantallas y
    columnas de Estudios que 'permisos' le habilite (None/vacío = puede ver
    todo, sólo restringe lo que el admin marque explícitamente)."""
    __tablename__ = 'usuario'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), unique=True, nullable=False)
    nombre_completo = db.Column(db.String(150), nullable=True)
    email = db.Column(db.String(255), unique=True, nullable=True)
    password_hash = db.Column(db.String(255), nullable=False)
    rol = db.Column(db.String(20), nullable=False, default='user')
    activo = db.Column(db.Boolean, nullable=False, default=True)
    permisos = db.Column(db.JSON, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)


class PasswordResetToken(db.Model):
    """Token de un solo uso para 'olvidé mi contraseña'. Sin un servicio de
    email configurado todavía, el link con este token se muestra en pantalla
    en vez de enviarse (ver routes/auth.py)."""
    __tablename__ = 'password_reset_token'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    id_usuario = db.Column(db.Integer, db.ForeignKey('public.usuario.id', ondelete='CASCADE'), nullable=False)
    token = db.Column(db.String(255), unique=True, nullable=False)
    expira = db.Column(db.DateTime, nullable=False)
    usado = db.Column(db.Boolean, nullable=False, default=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    usuario = db.relationship('Usuario')


class Faq(db.Model):
    """Pregunta frecuente del Laboratorio Británico (módulo FAQ). 'categoria'
    es texto libre autocompletable, sin ABM separado (RN-FAQ-02): las
    opciones del autocompletado salen de las categorías ya usadas en otras
    FAQ. 'estado' gobierna visibilidad pública (borrador/inactivo no son
    públicas); disponible_web/disponible_ia son independientes entre sí."""
    __tablename__ = 'faq'
    __table_args__ = (
        db.CheckConstraint("estado IN ('borrador', 'activo', 'inactivo')", name='chk_faq_estado'),
        {'schema': 'public'}
    )

    id = db.Column(db.Integer, primary_key=True)
    pregunta = db.Column(db.Text, nullable=False)
    respuesta = db.Column(db.Text, nullable=False)
    categoria = db.Column(db.String(150), nullable=False)
    disponible_web = db.Column(db.Boolean, nullable=False, default=False)
    disponible_ia = db.Column(db.Boolean, nullable=False, default=False)
    estado = db.Column(db.String(20), nullable=False, default='borrador')
    creado_por_id = db.Column(db.Integer, db.ForeignKey('public.usuario.id', ondelete='SET NULL'), nullable=True)
    actualizado_por_id = db.Column(db.Integer, db.ForeignKey('public.usuario.id', ondelete='SET NULL'), nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    creado_por = db.relationship('Usuario', foreign_keys=[creado_por_id])
    actualizado_por = db.relationship('Usuario', foreign_keys=[actualizado_por_id])
