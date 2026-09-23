-- Módulo Obras Sociales (dropdown "Obras Sociales" del navbar, RBAC del
-- módulo 'obras_sociales'). Alcance de esta etapa: ABM de Obra Social (+
-- Planes, alias de búsqueda, contactos, historial de estados), ABM de
-- Nomencladores y ABM de Autorizadores (ambos reutilizables entre Obras
-- Sociales vía tablas puente). Reglas/excepciones por práctica quedan para
-- una etapa posterior (el propio documento de negocio las marca como algo a
-- resolver más adelante).
BEGIN;

-- --- Nomenclador (ABM independiente, reutilizable) --------------------------
CREATE TABLE public.nomenclador (
    id serial PRIMARY KEY,
    nombre varchar(255) NOT NULL,
    tipo varchar(30) NOT NULL DEFAULT 'NBU',
    version_o_fecha varchar(100),
    vigencia varchar(100),
    link text,
    observacion text,
    estado varchar(20) NOT NULL DEFAULT 'activo',
    creado_por_id integer REFERENCES public.usuario(id) ON DELETE SET NULL,
    actualizado_por_id integer REFERENCES public.usuario(id) ON DELETE SET NULL,
    created_at timestamp NOT NULL DEFAULT now(),
    updated_at timestamp NOT NULL DEFAULT now(),
    CONSTRAINT chk_nomenclador_tipo CHECK (tipo IN ('NBU', 'especial', 'convenio_particular', 'listado_anexo')),
    CONSTRAINT chk_nomenclador_estado CHECK (estado IN ('activo', 'inactivo'))
);

-- --- Autorizador (ABM independiente, reutilizable) --------------------------
CREATE TABLE public.autorizador (
    id serial PRIMARY KEY,
    nombre varchar(255) NOT NULL,
    tipo varchar(30) NOT NULL DEFAULT 'Portal externo',
    link text,
    instructivo text,
    observacion text,
    estado varchar(20) NOT NULL DEFAULT 'activo',
    creado_por_id integer REFERENCES public.usuario(id) ON DELETE SET NULL,
    actualizado_por_id integer REFERENCES public.usuario(id) ON DELETE SET NULL,
    created_at timestamp NOT NULL DEFAULT now(),
    updated_at timestamp NOT NULL DEFAULT now(),
    CONSTRAINT chk_autorizador_tipo CHECK (tipo IN ('Portal externo', 'Sistema interno')),
    CONSTRAINT chk_autorizador_estado CHECK (estado IN ('activo', 'inactivo'))
);

-- --- Obra Social -------------------------------------------------------------
CREATE TABLE public.obra_social (
    id serial PRIMARY KEY,
    nombre varchar(255) NOT NULL,
    estado varchar(20) NOT NULL DEFAULT 'activo',
    estado_informacion varchar(20) NOT NULL DEFAULT 'borrador',
    mostrar_web boolean NOT NULL DEFAULT false,
    habilitar_ia boolean NOT NULL DEFAULT false,
    modalidad_autorizacion varchar(50),
    observacion_general text,
    informacion_publica text,
    fecha_ultima_validacion timestamp,
    validado_por_id integer REFERENCES public.usuario(id) ON DELETE SET NULL,
    creado_por_id integer REFERENCES public.usuario(id) ON DELETE SET NULL,
    actualizado_por_id integer REFERENCES public.usuario(id) ON DELETE SET NULL,
    created_at timestamp NOT NULL DEFAULT now(),
    updated_at timestamp NOT NULL DEFAULT now(),
    CONSTRAINT chk_obra_social_estado CHECK (estado IN ('activo', 'limitada', 'suspendida', 'sin_atencion')),
    CONSTRAINT chk_obra_social_estado_info CHECK (estado_informacion IN ('borrador', 'validada'))
);

CREATE TABLE public.obra_social_alias (
    id serial PRIMARY KEY,
    id_obra_social integer NOT NULL REFERENCES public.obra_social(id) ON DELETE CASCADE,
    alias varchar(150) NOT NULL
);
CREATE INDEX idx_obra_social_alias_obra_social ON public.obra_social_alias (id_obra_social);

CREATE TABLE public.obra_social_plan (
    id serial PRIMARY KEY,
    id_obra_social integer NOT NULL REFERENCES public.obra_social(id) ON DELETE CASCADE,
    nombre varchar(150) NOT NULL,
    alcance varchar(20) NOT NULL DEFAULT 'especifico',
    codigo_datatech_gravado varchar(50),
    codigo_datatech_exento varchar(50),
    estado varchar(20) NOT NULL DEFAULT 'activo',
    observacion text,
    created_at timestamp NOT NULL DEFAULT now(),
    updated_at timestamp NOT NULL DEFAULT now(),
    CONSTRAINT chk_obra_social_plan_alcance CHECK (alcance IN ('todos', 'especifico', 'resto')),
    CONSTRAINT chk_obra_social_plan_estado CHECK (estado IN ('activo', 'limitada', 'suspendida', 'sin_atencion'))
);
CREATE INDEX idx_obra_social_plan_obra_social ON public.obra_social_plan (id_obra_social);

-- Historial de cambios de estado: id_plan NULL = cambio a nivel Obra Social;
-- con valor = cambio puntual de ese Plan. "comunicado_por" es quién avisó del
-- lado de la Obra Social (texto libre), no un usuario del sistema — eso ya
-- queda como creado_por_id (quién cargó el cambio acá).
CREATE TABLE public.obra_social_historial_estado (
    id serial PRIMARY KEY,
    id_obra_social integer NOT NULL REFERENCES public.obra_social(id) ON DELETE CASCADE,
    id_plan integer REFERENCES public.obra_social_plan(id) ON DELETE CASCADE,
    estado_anterior varchar(20),
    estado_nuevo varchar(20) NOT NULL,
    comunicado_por varchar(150),
    motivo text,
    creado_por_id integer REFERENCES public.usuario(id) ON DELETE SET NULL,
    created_at timestamp NOT NULL DEFAULT now()
);
CREATE INDEX idx_obra_social_historial_obra_social ON public.obra_social_historial_estado (id_obra_social, created_at);

CREATE TABLE public.obra_social_contacto (
    id serial PRIMARY KEY,
    id_obra_social integer NOT NULL REFERENCES public.obra_social(id) ON DELETE CASCADE,
    tipo varchar(30) NOT NULL DEFAULT 'General',
    nombre varchar(150),
    telefono varchar(50),
    whatsapp varchar(50),
    email varchar(150),
    observacion text,
    CONSTRAINT chk_obra_social_contacto_tipo CHECK (tipo IN ('General', 'Autorizaciones', 'Auditoría', 'Convenios', 'Facturación', 'Otro'))
);
CREATE INDEX idx_obra_social_contacto_obra_social ON public.obra_social_contacto (id_obra_social);

-- Obra Social <-> Nomenclador (M2M: un nomenclador se carga una vez y se
-- reutiliza en varias Obras Sociales).
CREATE TABLE public.obra_social_nomenclador (
    id serial PRIMARY KEY,
    id_obra_social integer NOT NULL REFERENCES public.obra_social(id) ON DELETE CASCADE,
    id_nomenclador integer NOT NULL REFERENCES public.nomenclador(id) ON DELETE RESTRICT,
    CONSTRAINT uq_obra_social_nomenclador UNIQUE (id_obra_social, id_nomenclador)
);

-- Obra Social <-> Autorizador (M2M con datos propios de la relación: usuario/
-- contraseña son sensibles, ver app/routes/obras_sociales.py — mismo patrón
-- que colega.portal_usuario/portal_password).
CREATE TABLE public.obra_social_autorizador (
    id serial PRIMARY KEY,
    id_obra_social integer NOT NULL REFERENCES public.obra_social(id) ON DELETE CASCADE,
    id_autorizador integer NOT NULL REFERENCES public.autorizador(id) ON DELETE RESTRICT,
    prioridad varchar(20) NOT NULL DEFAULT 'principal',
    usuario varchar(150),
    password varchar(255),
    observacion text,
    CONSTRAINT chk_obra_social_autorizador_prioridad CHECK (prioridad IN ('principal', 'alternativo')),
    CONSTRAINT uq_obra_social_autorizador UNIQUE (id_obra_social, id_autorizador)
);

COMMIT;
