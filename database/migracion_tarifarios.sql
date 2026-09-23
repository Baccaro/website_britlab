-- Módulo Tarifarios (Obras Sociales): tarifarios/convenios, sus ítems
-- (un Estudio dentro de ese tarifario) y el historial de precios por
-- período de cada ítem. Actualizar un precio NO pisa el precio anterior:
-- se agrega una fila nueva en tarifario_item_periodo con un período
-- distinto (constraint UNIQUE (id_tarifario_item, periodo)), preservando
-- el historial completo. La auditoría de cada período (usuario y fecha de
-- creación/edición) sólo la puede ver SuperAdmin (ver app/routes/tarifarios.py).
BEGIN;

CREATE TABLE public.tarifario (
    id serial PRIMARY KEY,
    nombre varchar(255) NOT NULL,
    tipo varchar(20) NOT NULL DEFAULT 'TARIFARIO',
    tipo_relacionado varchar(50) NOT NULL DEFAULT 'Laboratorio / Procesador externo',
    entidad varchar(255),
    moneda varchar(10) NOT NULL DEFAULT 'ARS',
    estado varchar(20) NOT NULL DEFAULT 'activo',
    observaciones text,
    creado_por_id integer REFERENCES public.usuario(id) ON DELETE SET NULL,
    actualizado_por_id integer REFERENCES public.usuario(id) ON DELETE SET NULL,
    created_at timestamp NOT NULL DEFAULT now(),
    updated_at timestamp NOT NULL DEFAULT now(),
    CONSTRAINT chk_tarifario_tipo CHECK (tipo IN ('TARIFARIO', 'CONVENIO', 'DERIVACION', 'LISTA', 'ANEXO')),
    CONSTRAINT chk_tarifario_estado CHECK (estado IN ('activo', 'inactivo'))
);

CREATE TABLE public.tarifario_item (
    id serial PRIMARY KEY,
    id_tarifario integer NOT NULL REFERENCES public.tarifario(id) ON DELETE CASCADE,
    id_estudio integer NOT NULL REFERENCES public.estudio(id) ON DELETE RESTRICT,
    nemonico varchar(50),
    codigo varchar(50),
    estado varchar(20) NOT NULL DEFAULT 'Activo',
    nota text,
    created_at timestamp NOT NULL DEFAULT now(),
    CONSTRAINT chk_tarifario_item_estado CHECK (estado IN ('Activo', 'Inactivo'))
);
CREATE INDEX idx_tarifario_item_tarifario ON public.tarifario_item (id_tarifario);

CREATE TABLE public.tarifario_item_periodo (
    id serial PRIMARY KEY,
    id_tarifario_item integer NOT NULL REFERENCES public.tarifario_item(id) ON DELETE CASCADE,
    periodo varchar(100) NOT NULL,
    precio numeric(14, 2) NOT NULL,
    creado_por_id integer REFERENCES public.usuario(id) ON DELETE SET NULL,
    actualizado_por_id integer REFERENCES public.usuario(id) ON DELETE SET NULL,
    created_at timestamp NOT NULL DEFAULT now(),
    updated_at timestamp NOT NULL DEFAULT now(),
    CONSTRAINT uq_tarifario_item_periodo UNIQUE (id_tarifario_item, periodo)
);
CREATE INDEX idx_tarifario_item_periodo_item ON public.tarifario_item_periodo (id_tarifario_item, created_at);

COMMIT;
