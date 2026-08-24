from app.database import db
from datetime import datetime


class Derivante(db.Model):
    __tablename__ = 'derivante'
    __table_args__ = {'schema': 'public'}

    id = db.Column(db.Integer, primary_key=True)
    descripcion = db.Column(db.String(255), nullable=False)


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


class EstudioDerivante(db.Model):
    __tablename__ = 'estudio_derivante'
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
    indicaciones = db.Column(db.Text, nullable=True)
    valor_referencia = db.Column(db.Text, nullable=True)
    dias_demora = db.Column(db.Integer, default=0)
    estado = db.Column(db.String(20), nullable=False, default='pendiente')
    codigo_laboratorio = db.Column(db.String(50), nullable=True)
    version = db.Column(db.Integer, nullable=False, default=1)
    revisor = db.Column(db.String(100), nullable=False)
    observacion = db.Column(db.Text, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    derivante_id = db.Column(db.Integer, db.ForeignKey('public.derivante.id', ondelete='RESTRICT'), nullable=False)

    estudio = db.relationship('Estudio')
    metodo = db.relationship('Metodo')
    preanalitico = db.relationship('Preanalitico')
    muestra = db.relationship('Muestra')
    sector_laboratorio = db.relationship('ValorEstudioSector')
    derivante = db.relationship('Derivante')
