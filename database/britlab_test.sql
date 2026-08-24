-- public.derivante definition

-- Drop table

-- DROP TABLE public.derivante;

CREATE TABLE public.derivante (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	descripcion varchar(255) NOT NULL,
	CONSTRAINT derivante_pkey PRIMARY KEY (id)
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


-- public.estudio_derivante definition

-- Drop table

-- DROP TABLE public.estudio_derivante;

CREATE TABLE public.estudio_derivante (
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
	derivante_id int4 NOT NULL,
	CONSTRAINT estudio_derivante_pkey PRIMARY KEY (id),
	CONSTRAINT estudio_derivante_id_estudio_fkey FOREIGN KEY (id_estudio) REFERENCES public.estudio(id) ON DELETE RESTRICT,
	CONSTRAINT estudio_derivante_id_metodo_fkey FOREIGN KEY (id_metodo) REFERENCES public.metodo(id) ON DELETE SET NULL,
	CONSTRAINT estudio_derivante_id_muestra_fkey FOREIGN KEY (id_muestra) REFERENCES public.muestra(id) ON DELETE SET NULL,
	CONSTRAINT estudio_derivante_id_preanalitico_fkey FOREIGN KEY (id_preanalitico) REFERENCES public.preanalitico(id) ON DELETE SET NULL,
	CONSTRAINT estudio_derivante_id_sector_laboratorio_fkey FOREIGN KEY (id_sector_laboratorio) REFERENCES public.valor_estudio_sector(id) ON DELETE SET NULL,
	CONSTRAINT fk_estudio_derivante_derivante FOREIGN KEY (derivante_id) REFERENCES public.derivante(id) ON DELETE RESTRICT ON UPDATE CASCADE
);