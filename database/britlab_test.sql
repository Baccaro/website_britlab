-- public.colega definition

-- Drop table

-- DROP TABLE public.colega;

CREATE TABLE public.colega (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	descripcion varchar(255) NOT NULL,
	es_propio bool NOT NULL DEFAULT false,
	CONSTRAINT colega_pkey PRIMARY KEY (id)
);


-- public.estudio definition

-- Drop table

-- DROP TABLE public.estudio;

CREATE TABLE public.estudio (
	id serial4 NOT NULL,
	codigo_hexalis varchar(50) NOT NULL,
	descripcion text NOT NULL,
	CONSTRAINT estudio_codigo_hexalis_key UNIQUE (codigo_hexalis),
	CONSTRAINT estudio_pkey PRIMARY KEY (id)
);


-- public.metodo definition

-- Drop table

-- DROP TABLE public.metodo;

CREATE TABLE public.metodo (
	id serial4 NOT NULL,
	nombre varchar(100) NOT NULL,
	descripcion text NULL,
	CONSTRAINT metodo_nombre_key UNIQUE (nombre),
	CONSTRAINT metodo_pkey PRIMARY KEY (id)
);


-- public.muestra definition

-- Drop table

-- DROP TABLE public.muestra;

CREATE TABLE public.muestra (
	id serial4 NOT NULL,
	nombre varchar(150) NOT NULL,
	observacion text NULL,
	CONSTRAINT muestra_nombre_key UNIQUE (nombre),
	CONSTRAINT muestra_pkey PRIMARY KEY (id)
);


-- public.preanalitico definition

-- Drop table

-- DROP TABLE public.preanalitico;

CREATE TABLE public.preanalitico (
	id serial4 NOT NULL,
	nombre varchar(150) NOT NULL,
	descripcion text NULL,
	CONSTRAINT preanalitico_nombre_key UNIQUE (nombre),
	CONSTRAINT preanalitico_pkey PRIMARY KEY (id)
);


-- public.sector definition

-- Drop table

-- DROP TABLE public.sector;

CREATE TABLE public.sector (
	id serial4 NOT NULL,
	nombre varchar(150) NOT NULL,
	CONSTRAINT sector_pkey PRIMARY KEY (id),
	CONSTRAINT sector_nombre_key UNIQUE (nombre)
);


-- public.valor_estudio_sector definition

-- Drop table

-- DROP TABLE public.valor_estudio_sector;

CREATE TABLE public.valor_estudio_sector (
	id serial4 NOT NULL,
	id_estudio int4 NOT NULL,
	id_sector int4 NOT NULL,
	posicion_informe int4 NOT NULL,
	rango varchar(100) NULL,
	CONSTRAINT valor_estudio_sector_pkey PRIMARY KEY (id),
	CONSTRAINT uq_estudio_sector_posicion UNIQUE (id_estudio, id_sector, posicion_informe),
	CONSTRAINT valor_estudio_sector_id_estudio_fkey FOREIGN KEY (id_estudio) REFERENCES public.estudio(id) ON DELETE CASCADE,
	CONSTRAINT valor_estudio_sector_id_sector_fkey FOREIGN KEY (id_sector) REFERENCES public.sector(id)
);


-- public.estudio_colega definition

-- Drop table

-- DROP TABLE public.estudio_colega;

CREATE TABLE public.estudio_colega (
	id serial4 NOT NULL,
	nemonico_datatech varchar(50) NOT NULL,
	paridad_datatech_hexalis public.estado_paridad_enum DEFAULT 'pendiente'::estado_paridad_enum NOT NULL,
	id_estudio int4 NOT NULL,
	id_metodo int4 NULL,
	id_preanalitico int4 NULL,
	id_muestra int4 NULL,
	id_sector_laboratorio int4 NULL,
	indicaciones text NULL,
	valor_referencia text NULL,
	dias_demora int4 DEFAULT 0 NULL,
	estado public.estado_registro_enum DEFAULT 'pendiente'::estado_registro_enum NOT NULL,
	codigo_laboratorio varchar(50) DEFAULT NULL::character varying NULL,
	"version" int4 DEFAULT 1 NOT NULL,
	revisor varchar(100) NOT NULL,
	observacion text NULL,
	created_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
	colega_id int4 NOT NULL,
	CONSTRAINT estudio_colega_pkey PRIMARY KEY (id),
	CONSTRAINT estudio_colega_id_estudio_fkey FOREIGN KEY (id_estudio) REFERENCES public.estudio(id) ON DELETE RESTRICT,
	CONSTRAINT estudio_colega_id_metodo_fkey FOREIGN KEY (id_metodo) REFERENCES public.metodo(id) ON DELETE SET NULL,
	CONSTRAINT estudio_colega_id_muestra_fkey FOREIGN KEY (id_muestra) REFERENCES public.muestra(id) ON DELETE SET NULL,
	CONSTRAINT estudio_colega_id_preanalitico_fkey FOREIGN KEY (id_preanalitico) REFERENCES public.preanalitico(id) ON DELETE SET NULL,
	CONSTRAINT estudio_colega_id_sector_laboratorio_fkey FOREIGN KEY (id_sector_laboratorio) REFERENCES public.valor_estudio_sector(id) ON DELETE SET NULL,
	CONSTRAINT fk_estudio_colega_colega FOREIGN KEY (colega_id) REFERENCES public.colega(id) ON DELETE RESTRICT ON UPDATE CASCADE
);


-- Muestras estructuradas (1..N por estudio_colega). Es aditivo: no
-- reemplaza a 'muestra' / 'estudio_colega.id_muestra', que se mantienen.

CREATE TABLE public.tipo_muestra (
	id serial4 NOT NULL,
	nombre varchar(150) NOT NULL,
	CONSTRAINT tipo_muestra_pkey PRIMARY KEY (id),
	CONSTRAINT tipo_muestra_nombre_key UNIQUE (nombre)
);

CREATE TABLE public.aditivo (
	id serial4 NOT NULL,
	nombre varchar(100) NOT NULL,
	CONSTRAINT aditivo_pkey PRIMARY KEY (id),
	CONSTRAINT aditivo_nombre_key UNIQUE (nombre)
);

CREATE TABLE public.unidad_medida (
	id serial4 NOT NULL,
	nombre varchar(50) NOT NULL,
	CONSTRAINT unidad_medida_pkey PRIMARY KEY (id),
	CONSTRAINT unidad_medida_nombre_key UNIQUE (nombre)
);

CREATE TABLE public.recipiente (
	id serial4 NOT NULL,
	nombre varchar(100) NOT NULL,
	CONSTRAINT recipiente_pkey PRIMARY KEY (id),
	CONSTRAINT recipiente_nombre_key UNIQUE (nombre)
);

CREATE TABLE public.modalidad_recoleccion (
	id serial4 NOT NULL,
	nombre varchar(150) NOT NULL,
	CONSTRAINT modalidad_recoleccion_pkey PRIMARY KEY (id),
	CONSTRAINT modalidad_recoleccion_nombre_key UNIQUE (nombre)
);

CREATE TABLE public.tecnica_recoleccion (
	id serial4 NOT NULL,
	nombre varchar(150) NOT NULL,
	CONSTRAINT tecnica_recoleccion_pkey PRIMARY KEY (id),
	CONSTRAINT tecnica_recoleccion_nombre_key UNIQUE (nombre)
);

CREATE TABLE public.conservacion (
	id serial4 NOT NULL,
	nombre varchar(100) NOT NULL,
	CONSTRAINT conservacion_pkey PRIMARY KEY (id),
	CONSTRAINT conservacion_nombre_key UNIQUE (nombre)
);

CREATE TABLE public.condicion_especial (
	id serial4 NOT NULL,
	nombre varchar(100) NOT NULL,
	CONSTRAINT condicion_especial_pkey PRIMARY KEY (id),
	CONSTRAINT condicion_especial_nombre_key UNIQUE (nombre)
);

CREATE TABLE public.prioridad_envio (
	id serial4 NOT NULL,
	nombre varchar(100) NOT NULL,
	CONSTRAINT prioridad_envio_pkey PRIMARY KEY (id),
	CONSTRAINT prioridad_envio_nombre_key UNIQUE (nombre)
);

CREATE TABLE public.estudio_colega_muestra (
	id serial4 NOT NULL,
	id_estudio_colega int4 NOT NULL,
	id_tipo_muestra int4 NOT NULL,
	id_aditivo int4 NULL,
	volumen numeric(10,2) NULL,
	id_unidad_medida int4 NULL,
	id_recipiente int4 NULL,
	id_modalidad_recoleccion int4 NULL,
	id_tecnica_recoleccion int4 NULL,
	id_conservacion int4 NULL,
	id_condicion_especial int4 NULL,
	id_prioridad_envio int4 NULL,
	orden int4 DEFAULT 1 NOT NULL,
	observacion text NULL,
	created_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT estudio_colega_muestra_pkey PRIMARY KEY (id),
	CONSTRAINT edm_id_estudio_colega_fkey FOREIGN KEY (id_estudio_colega) REFERENCES public.estudio_colega(id) ON DELETE CASCADE,
	CONSTRAINT edm_id_tipo_muestra_fkey FOREIGN KEY (id_tipo_muestra) REFERENCES public.tipo_muestra(id),
	CONSTRAINT edm_id_aditivo_fkey FOREIGN KEY (id_aditivo) REFERENCES public.aditivo(id) ON DELETE SET NULL,
	CONSTRAINT edm_id_unidad_medida_fkey FOREIGN KEY (id_unidad_medida) REFERENCES public.unidad_medida(id) ON DELETE SET NULL,
	CONSTRAINT edm_id_recipiente_fkey FOREIGN KEY (id_recipiente) REFERENCES public.recipiente(id) ON DELETE SET NULL,
	CONSTRAINT edm_id_modalidad_recoleccion_fkey FOREIGN KEY (id_modalidad_recoleccion) REFERENCES public.modalidad_recoleccion(id) ON DELETE SET NULL,
	CONSTRAINT edm_id_tecnica_recoleccion_fkey FOREIGN KEY (id_tecnica_recoleccion) REFERENCES public.tecnica_recoleccion(id) ON DELETE SET NULL,
	CONSTRAINT edm_id_conservacion_fkey FOREIGN KEY (id_conservacion) REFERENCES public.conservacion(id) ON DELETE SET NULL,
	CONSTRAINT edm_id_condicion_especial_fkey FOREIGN KEY (id_condicion_especial) REFERENCES public.condicion_especial(id) ON DELETE SET NULL,
	CONSTRAINT edm_id_prioridad_envio_fkey FOREIGN KEY (id_prioridad_envio) REFERENCES public.prioridad_envio(id) ON DELETE SET NULL
);

-- Alternativas de una muestra puntual (no del estudio_colega directamente):
-- un estudio tiene N muestras, y cada muestra puede tener N alternativas.

CREATE TABLE public.estudio_colega_muestra_alternativa (
	id serial4 NOT NULL,
	id_estudio_colega_muestra int4 NOT NULL,
	id_tipo_muestra int4 NOT NULL,
	id_aditivo int4 NULL,
	volumen numeric(10,2) NULL,
	id_unidad_medida int4 NULL,
	id_recipiente int4 NULL,
	id_modalidad_recoleccion int4 NULL,
	id_tecnica_recoleccion int4 NULL,
	id_conservacion int4 NULL,
	id_condicion_especial int4 NULL,
	id_prioridad_envio int4 NULL,
	orden int4 DEFAULT 1 NOT NULL,
	observacion text NULL,
	created_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT estudio_colega_muestra_alternativa_pkey PRIMARY KEY (id),
	CONSTRAINT ecma_id_estudio_colega_muestra_fkey FOREIGN KEY (id_estudio_colega_muestra) REFERENCES public.estudio_colega_muestra(id) ON DELETE CASCADE,
	CONSTRAINT ecma_id_tipo_muestra_fkey FOREIGN KEY (id_tipo_muestra) REFERENCES public.tipo_muestra(id),
	CONSTRAINT ecma_id_aditivo_fkey FOREIGN KEY (id_aditivo) REFERENCES public.aditivo(id) ON DELETE SET NULL,
	CONSTRAINT ecma_id_unidad_medida_fkey FOREIGN KEY (id_unidad_medida) REFERENCES public.unidad_medida(id) ON DELETE SET NULL,
	CONSTRAINT ecma_id_recipiente_fkey FOREIGN KEY (id_recipiente) REFERENCES public.recipiente(id) ON DELETE SET NULL,
	CONSTRAINT ecma_id_modalidad_recoleccion_fkey FOREIGN KEY (id_modalidad_recoleccion) REFERENCES public.modalidad_recoleccion(id) ON DELETE SET NULL,
	CONSTRAINT ecma_id_tecnica_recoleccion_fkey FOREIGN KEY (id_tecnica_recoleccion) REFERENCES public.tecnica_recoleccion(id) ON DELETE SET NULL,
	CONSTRAINT ecma_id_conservacion_fkey FOREIGN KEY (id_conservacion) REFERENCES public.conservacion(id) ON DELETE SET NULL,
	CONSTRAINT ecma_id_condicion_especial_fkey FOREIGN KEY (id_condicion_especial) REFERENCES public.condicion_especial(id) ON DELETE SET NULL,
	CONSTRAINT ecma_id_prioridad_envio_fkey FOREIGN KEY (id_prioridad_envio) REFERENCES public.prioridad_envio(id) ON DELETE SET NULL
);


-- public.estudio_colega_modelo definition
-- Modelos de informe (PDF) del colega para un Estudio x Colega: 1..N por
-- registro, guardados como bytea en la BD.

CREATE TABLE public.estudio_colega_modelo (
	id serial4 NOT NULL,
	id_estudio_colega int4 NOT NULL,
	nombre_archivo varchar(255) NOT NULL,
	contenido bytea NOT NULL,
	tamanio_bytes int4 NOT NULL,
	created_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT estudio_colega_modelo_pkey PRIMARY KEY (id),
	CONSTRAINT ecm_id_estudio_colega_fkey FOREIGN KEY (id_estudio_colega) REFERENCES public.estudio_colega(id) ON DELETE CASCADE
);
CREATE INDEX idx_ecm_id_estudio_colega ON public.estudio_colega_modelo (id_estudio_colega);