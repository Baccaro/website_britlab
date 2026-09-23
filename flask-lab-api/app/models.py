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


# --- Tarifarios (módulo Obras Sociales) -------------------------------------
# Un Tarifario/Convenio tiene N ítems (un Estudio dentro de ese tarifario), y
# cada ítem tiene N períodos: actualizar un precio no pisa el anterior, agrega
# un período nuevo (uq_tarifario_item_periodo obliga a que sea distinto). El
# precio "vigente" de un ítem es el de su período con created_at más reciente.

class Tarifario(db.Model):
    __tablename__ = 'tarifario'
    __table_args__ = (
        db.CheckConstraint("tipo IN ('TARIFARIO', 'CONVENIO', 'DERIVACION', 'LISTA', 'ANEXO')", name='chk_tarifario_tipo'),
        db.CheckConstraint("estado IN ('activo', 'inactivo')", name='chk_tarifario_estado'),
        {'schema': 'public'}
    )

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(255), nullable=False)
    tipo = db.Column(db.String(20), nullable=False, default='TARIFARIO')
    tipo_relacionado = db.Column(db.String(50), nullable=False, default='Laboratorio / Procesador externo')
    entidad = db.Column(db.String(255), nullable=True)
    moneda = db.Column(db.String(10), nullable=False, default='ARS')
    estado = db.Column(db.String(20), nullable=False, default='activo')
    observaciones = db.Column(db.Text, nullable=True)
    creado_por_id = db.Column(db.Integer, db.ForeignKey('public.usuario.id', ondelete='SET NULL'), nullable=True)
    actualizado_por_id = db.Column(db.Integer, db.ForeignKey('public.usuario.id', ondelete='SET NULL'), nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    creado_por = db.relationship('Usuario', foreign_keys=[creado_por_id])
    actualizado_por = db.relationship('Usuario', foreign_keys=[actualizado_por_id])
    items = db.relationship('TarifarioItem', backref='tarifario', cascade='all, delete-orphan')

    @property
    def creado_por_username(self):
        return self.creado_por.username if self.creado_por else None

    @property
    def actualizado_por_username(self):
        return self.actualizado_por.username if self.actualizado_por else None


class TarifarioItem(db.Model):
    __tablename__ = 'tarifario_item'
    __table_args__ = (
        db.CheckConstraint("estado IN ('Activo', 'Inactivo')", name='chk_tarifario_item_estado'),
        {'schema': 'public'}
    )

    id = db.Column(db.Integer, primary_key=True)
    id_tarifario = db.Column(db.Integer, db.ForeignKey('public.tarifario.id', ondelete='CASCADE'), nullable=False)
    id_estudio = db.Column(db.Integer, db.ForeignKey('public.estudio.id', ondelete='RESTRICT'), nullable=False)
    nemonico = db.Column(db.String(50), nullable=True)
    codigo = db.Column(db.String(50), nullable=True)
    estado = db.Column(db.String(20), nullable=False, default='Activo')
    nota = db.Column(db.Text, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    estudio = db.relationship('Estudio')
    periodos = db.relationship(
        'TarifarioItemPeriodo', backref='item', cascade='all, delete-orphan',
        order_by='TarifarioItemPeriodo.created_at.desc()'
    )

    @property
    def periodo_vigente(self):
        return self.periodos[0] if self.periodos else None


class TarifarioItemPeriodo(db.Model):
    __tablename__ = 'tarifario_item_periodo'
    __table_args__ = (
        db.UniqueConstraint('id_tarifario_item', 'periodo', name='uq_tarifario_item_periodo'),
        {'schema': 'public'}
    )

    id = db.Column(db.Integer, primary_key=True)
    id_tarifario_item = db.Column(db.Integer, db.ForeignKey('public.tarifario_item.id', ondelete='CASCADE'), nullable=False)
    periodo = db.Column(db.String(100), nullable=False)
    precio = db.Column(db.Numeric(14, 2), nullable=False)
    creado_por_id = db.Column(db.Integer, db.ForeignKey('public.usuario.id', ondelete='SET NULL'), nullable=True)
    actualizado_por_id = db.Column(db.Integer, db.ForeignKey('public.usuario.id', ondelete='SET NULL'), nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    creado_por = db.relationship('Usuario', foreign_keys=[creado_por_id])
    actualizado_por = db.relationship('Usuario', foreign_keys=[actualizado_por_id])

    @property
    def creado_por_username(self):
        return self.creado_por.username if self.creado_por else None

    @property
    def actualizado_por_username(self):
        return self.actualizado_por.username if self.actualizado_por else None


# --- Obras Sociales, Nomencladores y Autorizadores --------------------------
# Alcance de esta etapa (ver documento de negocio): ABM de Obra Social (+
# Planes, alias de búsqueda, contactos, historial de estados), Nomencladores
# y Autorizadores (ambos ABMs propios y reutilizables entre Obras Sociales).
# Reglas/excepciones por práctica quedan para una etapa posterior.

class Nomenclador(db.Model):
    __tablename__ = 'nomenclador'
    __table_args__ = (
        db.CheckConstraint("tipo IN ('NBU', 'especial', 'convenio_particular', 'listado_anexo')", name='chk_nomenclador_tipo'),
        db.CheckConstraint("estado IN ('activo', 'inactivo')", name='chk_nomenclador_estado'),
        {'schema': 'public'}
    )

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(255), nullable=False)
    tipo = db.Column(db.String(30), nullable=False, default='NBU')
    version_o_fecha = db.Column(db.String(100), nullable=True)
    vigencia = db.Column(db.String(100), nullable=True)
    link = db.Column(db.Text, nullable=True)
    observacion = db.Column(db.Text, nullable=True)
    estado = db.Column(db.String(20), nullable=False, default='activo')
    creado_por_id = db.Column(db.Integer, db.ForeignKey('public.usuario.id', ondelete='SET NULL'), nullable=True)
    actualizado_por_id = db.Column(db.Integer, db.ForeignKey('public.usuario.id', ondelete='SET NULL'), nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    creado_por = db.relationship('Usuario', foreign_keys=[creado_por_id])
    actualizado_por = db.relationship('Usuario', foreign_keys=[actualizado_por_id])

    @property
    def creado_por_username(self):
        return self.creado_por.username if self.creado_por else None

    @property
    def actualizado_por_username(self):
        return self.actualizado_por.username if self.actualizado_por else None


class Autorizador(db.Model):
    __tablename__ = 'autorizador'
    __table_args__ = (
        db.CheckConstraint("tipo IN ('Portal externo', 'Sistema interno')", name='chk_autorizador_tipo'),
        db.CheckConstraint("estado IN ('activo', 'inactivo')", name='chk_autorizador_estado'),
        {'schema': 'public'}
    )

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(255), nullable=False)
    tipo = db.Column(db.String(30), nullable=False, default='Portal externo')
    link = db.Column(db.Text, nullable=True)
    instructivo = db.Column(db.Text, nullable=True)
    observacion = db.Column(db.Text, nullable=True)
    estado = db.Column(db.String(20), nullable=False, default='activo')
    creado_por_id = db.Column(db.Integer, db.ForeignKey('public.usuario.id', ondelete='SET NULL'), nullable=True)
    actualizado_por_id = db.Column(db.Integer, db.ForeignKey('public.usuario.id', ondelete='SET NULL'), nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    creado_por = db.relationship('Usuario', foreign_keys=[creado_por_id])
    actualizado_por = db.relationship('Usuario', foreign_keys=[actualizado_por_id])

    @property
    def creado_por_username(self):
        return self.creado_por.username if self.creado_por else None

    @property
    def actualizado_por_username(self):
        return self.actualizado_por.username if self.actualizado_por else None


class ObraSocial(db.Model):
    __tablename__ = 'obra_social'
    __table_args__ = (
        db.CheckConstraint("estado IN ('activo', 'limitada', 'suspendida', 'sin_atencion')", name='chk_obra_social_estado'),
        db.CheckConstraint("estado_informacion IN ('borrador', 'validada')", name='chk_obra_social_estado_info'),
        {'schema': 'public'}
    )

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(255), nullable=False)
    estado = db.Column(db.String(20), nullable=False, default='activo')
    estado_informacion = db.Column(db.String(20), nullable=False, default='borrador')
    mostrar_web = db.Column(db.Boolean, nullable=False, default=False)
    habilitar_ia = db.Column(db.Boolean, nullable=False, default=False)
    modalidad_autorizacion = db.Column(db.String(50), nullable=True)
    observacion_general = db.Column(db.Text, nullable=True)
    informacion_publica = db.Column(db.Text, nullable=True)
    fecha_ultima_validacion = db.Column(db.DateTime, nullable=True)
    validado_por_id = db.Column(db.Integer, db.ForeignKey('public.usuario.id', ondelete='SET NULL'), nullable=True)
    creado_por_id = db.Column(db.Integer, db.ForeignKey('public.usuario.id', ondelete='SET NULL'), nullable=True)
    actualizado_por_id = db.Column(db.Integer, db.ForeignKey('public.usuario.id', ondelete='SET NULL'), nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    validado_por = db.relationship('Usuario', foreign_keys=[validado_por_id])
    creado_por = db.relationship('Usuario', foreign_keys=[creado_por_id])
    actualizado_por = db.relationship('Usuario', foreign_keys=[actualizado_por_id])
    alias = db.relationship('ObraSocialAlias', backref='obra_social', cascade='all, delete-orphan')
    planes = db.relationship('ObraSocialPlan', backref='obra_social', cascade='all, delete-orphan')
    contactos = db.relationship('ObraSocialContacto', backref='obra_social', cascade='all, delete-orphan')
    historial = db.relationship(
        'ObraSocialHistorialEstado', backref='obra_social', cascade='all, delete-orphan',
        order_by='ObraSocialHistorialEstado.created_at.desc()'
    )
    nomencladores_rel = db.relationship('ObraSocialNomenclador', backref='obra_social', cascade='all, delete-orphan')
    autorizadores_rel = db.relationship('ObraSocialAutorizador', backref='obra_social', cascade='all, delete-orphan')

    @property
    def creado_por_username(self):
        return self.creado_por.username if self.creado_por else None

    @property
    def actualizado_por_username(self):
        return self.actualizado_por.username if self.actualizado_por else None

    @property
    def validado_por_username(self):
        return self.validado_por.username if self.validado_por else None


class ObraSocialAlias(db.Model):
    __tablename__ = 'obra_social_alias'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    id_obra_social = db.Column(db.Integer, db.ForeignKey('public.obra_social.id', ondelete='CASCADE'), nullable=False)
    alias = db.Column(db.String(150), nullable=False)


class ObraSocialPlan(db.Model):
    __tablename__ = 'obra_social_plan'
    __table_args__ = (
        db.CheckConstraint("estado IN ('activo', 'limitada', 'suspendida', 'sin_atencion')", name='chk_obra_social_plan_estado'),
        {'schema': 'public'}
    )

    id = db.Column(db.Integer, primary_key=True)
    id_obra_social = db.Column(db.Integer, db.ForeignKey('public.obra_social.id', ondelete='CASCADE'), nullable=False)
    nombre = db.Column(db.String(150), nullable=False)
    codigo_datatech_gravado = db.Column(db.String(50), nullable=True)
    codigo_datatech_exento = db.Column(db.String(50), nullable=True)
    estado = db.Column(db.String(20), nullable=False, default='activo')
    observacion = db.Column(db.Text, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)


class ObraSocialHistorialEstado(db.Model):
    __tablename__ = 'obra_social_historial_estado'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    id_obra_social = db.Column(db.Integer, db.ForeignKey('public.obra_social.id', ondelete='CASCADE'), nullable=False)
    id_plan = db.Column(db.Integer, db.ForeignKey('public.obra_social_plan.id', ondelete='CASCADE'), nullable=True)
    estado_anterior = db.Column(db.String(20), nullable=True)
    estado_nuevo = db.Column(db.String(20), nullable=False)
    comunicado_por = db.Column(db.String(150), nullable=True)
    motivo = db.Column(db.Text, nullable=True)
    creado_por_id = db.Column(db.Integer, db.ForeignKey('public.usuario.id', ondelete='SET NULL'), nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    plan = db.relationship('ObraSocialPlan')
    creado_por = db.relationship('Usuario', foreign_keys=[creado_por_id])

    @property
    def creado_por_username(self):
        return self.creado_por.username if self.creado_por else None


class ObraSocialContacto(db.Model):
    __tablename__ = 'obra_social_contacto'
    __table_args__ = (
        db.CheckConstraint(
            "tipo IN ('General', 'Autorizaciones', 'Auditoría', 'Convenios', 'Facturación', 'Otro')",
            name='chk_obra_social_contacto_tipo'
        ),
        {'schema': 'public'}
    )

    id = db.Column(db.Integer, primary_key=True)
    id_obra_social = db.Column(db.Integer, db.ForeignKey('public.obra_social.id', ondelete='CASCADE'), nullable=False)
    tipo = db.Column(db.String(30), nullable=False, default='General')
    nombre = db.Column(db.String(150), nullable=True)
    telefono = db.Column(db.String(50), nullable=True)
    whatsapp = db.Column(db.String(50), nullable=True)
    email = db.Column(db.String(150), nullable=True)
    observacion = db.Column(db.Text, nullable=True)


class ObraSocialNomenclador(db.Model):
    __tablename__ = 'obra_social_nomenclador'
    __table_args__ = (
        db.UniqueConstraint('id_obra_social', 'id_nomenclador', name='uq_obra_social_nomenclador'),
        {'schema': 'public'}
    )

    id = db.Column(db.Integer, primary_key=True)
    id_obra_social = db.Column(db.Integer, db.ForeignKey('public.obra_social.id', ondelete='CASCADE'), nullable=False)
    id_nomenclador = db.Column(db.Integer, db.ForeignKey('public.nomenclador.id', ondelete='RESTRICT'), nullable=False)

    nomenclador = db.relationship('Nomenclador')


class ObraSocialAutorizador(db.Model):
    __tablename__ = 'obra_social_autorizador'
    __table_args__ = (
        db.CheckConstraint("prioridad IN ('principal', 'alternativo')", name='chk_obra_social_autorizador_prioridad'),
        db.UniqueConstraint('id_obra_social', 'id_autorizador', name='uq_obra_social_autorizador'),
        {'schema': 'public'}
    )

    id = db.Column(db.Integer, primary_key=True)
    id_obra_social = db.Column(db.Integer, db.ForeignKey('public.obra_social.id', ondelete='CASCADE'), nullable=False)
    id_autorizador = db.Column(db.Integer, db.ForeignKey('public.autorizador.id', ondelete='RESTRICT'), nullable=False)
    prioridad = db.Column(db.String(20), nullable=False, default='principal')
    usuario = db.Column(db.String(150), nullable=True)
    password = db.Column(db.String(255), nullable=True)
    observacion = db.Column(db.Text, nullable=True)

    autorizador = db.relationship('Autorizador')