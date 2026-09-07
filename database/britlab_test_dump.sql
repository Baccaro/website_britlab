--
-- PostgreSQL database dump
--

\restrict 4OletR0tGoYQc1lG1Y1g1oLVDHqoU03LuPP6fX1nwgB5dwX7z2YnAhflWeXN4zT

-- Dumped from database version 14.24 (Ubuntu 14.24-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.24 (Ubuntu 14.24-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.valor_estudio_sector DROP CONSTRAINT IF EXISTS valor_estudio_sector_id_sector_fkey;
ALTER TABLE IF EXISTS ONLY public.valor_estudio_sector DROP CONSTRAINT IF EXISTS valor_estudio_sector_id_estudio_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega DROP CONSTRAINT IF EXISTS fk_estudio_colega_colega;
ALTER TABLE IF EXISTS ONLY public.estudio_colega DROP CONSTRAINT IF EXISTS estudio_colega_id_sector_laboratorio_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega DROP CONSTRAINT IF EXISTS estudio_colega_id_preanalitico_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega DROP CONSTRAINT IF EXISTS estudio_colega_id_muestra_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega DROP CONSTRAINT IF EXISTS estudio_colega_id_metodo_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega DROP CONSTRAINT IF EXISTS estudio_colega_id_estudio_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra DROP CONSTRAINT IF EXISTS edm_id_unidad_medida_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra DROP CONSTRAINT IF EXISTS edm_id_tipo_muestra_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra DROP CONSTRAINT IF EXISTS edm_id_tecnica_recoleccion_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra DROP CONSTRAINT IF EXISTS edm_id_recipiente_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra DROP CONSTRAINT IF EXISTS edm_id_prioridad_envio_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra DROP CONSTRAINT IF EXISTS edm_id_modalidad_recoleccion_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra DROP CONSTRAINT IF EXISTS edm_id_estudio_colega_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra DROP CONSTRAINT IF EXISTS edm_id_conservacion_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra DROP CONSTRAINT IF EXISTS edm_id_condicion_especial_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra DROP CONSTRAINT IF EXISTS edm_id_aditivo_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra_alternativa DROP CONSTRAINT IF EXISTS ecma_id_unidad_medida_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra_alternativa DROP CONSTRAINT IF EXISTS ecma_id_tipo_muestra_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra_alternativa DROP CONSTRAINT IF EXISTS ecma_id_tecnica_recoleccion_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra_alternativa DROP CONSTRAINT IF EXISTS ecma_id_recipiente_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra_alternativa DROP CONSTRAINT IF EXISTS ecma_id_prioridad_envio_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra_alternativa DROP CONSTRAINT IF EXISTS ecma_id_modalidad_recoleccion_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra_alternativa DROP CONSTRAINT IF EXISTS ecma_id_estudio_colega_muestra_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra_alternativa DROP CONSTRAINT IF EXISTS ecma_id_conservacion_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra_alternativa DROP CONSTRAINT IF EXISTS ecma_id_condicion_especial_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra_alternativa DROP CONSTRAINT IF EXISTS ecma_id_aditivo_fkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_modelo DROP CONSTRAINT IF EXISTS ecm_id_estudio_colega_fkey;
DROP INDEX IF EXISTS public.idx_ecm_id_estudio_colega;
ALTER TABLE IF EXISTS ONLY public.valor_estudio_sector DROP CONSTRAINT IF EXISTS valor_estudio_sector_pkey;
ALTER TABLE IF EXISTS ONLY public.valor_estudio_sector DROP CONSTRAINT IF EXISTS uq_estudio_sector_posicion;
ALTER TABLE IF EXISTS ONLY public.unidad_medida DROP CONSTRAINT IF EXISTS unidad_medida_pkey;
ALTER TABLE IF EXISTS ONLY public.unidad_medida DROP CONSTRAINT IF EXISTS unidad_medida_nombre_key;
ALTER TABLE IF EXISTS ONLY public.tipo_muestra DROP CONSTRAINT IF EXISTS tipo_muestra_pkey;
ALTER TABLE IF EXISTS ONLY public.tipo_muestra DROP CONSTRAINT IF EXISTS tipo_muestra_nombre_key;
ALTER TABLE IF EXISTS ONLY public.tecnica_recoleccion DROP CONSTRAINT IF EXISTS tecnica_recoleccion_pkey;
ALTER TABLE IF EXISTS ONLY public.tecnica_recoleccion DROP CONSTRAINT IF EXISTS tecnica_recoleccion_nombre_key;
ALTER TABLE IF EXISTS ONLY public.sector DROP CONSTRAINT IF EXISTS sector_pkey;
ALTER TABLE IF EXISTS ONLY public.sector DROP CONSTRAINT IF EXISTS sector_nombre_key;
ALTER TABLE IF EXISTS ONLY public.recipiente DROP CONSTRAINT IF EXISTS recipiente_pkey;
ALTER TABLE IF EXISTS ONLY public.recipiente DROP CONSTRAINT IF EXISTS recipiente_nombre_key;
ALTER TABLE IF EXISTS ONLY public.prioridad_envio DROP CONSTRAINT IF EXISTS prioridad_envio_pkey;
ALTER TABLE IF EXISTS ONLY public.prioridad_envio DROP CONSTRAINT IF EXISTS prioridad_envio_nombre_key;
ALTER TABLE IF EXISTS ONLY public.preanalitico DROP CONSTRAINT IF EXISTS preanalitico_pkey;
ALTER TABLE IF EXISTS ONLY public.preanalitico DROP CONSTRAINT IF EXISTS preanalitico_nombre_key;
ALTER TABLE IF EXISTS ONLY public.muestra DROP CONSTRAINT IF EXISTS muestra_pkey;
ALTER TABLE IF EXISTS ONLY public.muestra DROP CONSTRAINT IF EXISTS muestra_nombre_key;
ALTER TABLE IF EXISTS ONLY public.modalidad_recoleccion DROP CONSTRAINT IF EXISTS modalidad_recoleccion_pkey;
ALTER TABLE IF EXISTS ONLY public.modalidad_recoleccion DROP CONSTRAINT IF EXISTS modalidad_recoleccion_nombre_key;
ALTER TABLE IF EXISTS ONLY public.metodo DROP CONSTRAINT IF EXISTS metodo_pkey;
ALTER TABLE IF EXISTS ONLY public.metodo DROP CONSTRAINT IF EXISTS metodo_nombre_key;
ALTER TABLE IF EXISTS ONLY public.estudio DROP CONSTRAINT IF EXISTS estudio_pkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega DROP CONSTRAINT IF EXISTS estudio_colega_pkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra DROP CONSTRAINT IF EXISTS estudio_colega_muestra_pkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_muestra_alternativa DROP CONSTRAINT IF EXISTS estudio_colega_muestra_alternativa_pkey;
ALTER TABLE IF EXISTS ONLY public.estudio_colega_modelo DROP CONSTRAINT IF EXISTS estudio_colega_modelo_pkey;
ALTER TABLE IF EXISTS ONLY public.estudio DROP CONSTRAINT IF EXISTS estudio_codigo_hexalis_key;
ALTER TABLE IF EXISTS ONLY public.conservacion DROP CONSTRAINT IF EXISTS conservacion_pkey;
ALTER TABLE IF EXISTS ONLY public.conservacion DROP CONSTRAINT IF EXISTS conservacion_nombre_key;
ALTER TABLE IF EXISTS ONLY public.condicion_especial DROP CONSTRAINT IF EXISTS condicion_especial_pkey;
ALTER TABLE IF EXISTS ONLY public.condicion_especial DROP CONSTRAINT IF EXISTS condicion_especial_nombre_key;
ALTER TABLE IF EXISTS ONLY public.colega DROP CONSTRAINT IF EXISTS colega_pkey;
ALTER TABLE IF EXISTS ONLY public.aditivo DROP CONSTRAINT IF EXISTS aditivo_pkey;
ALTER TABLE IF EXISTS ONLY public.aditivo DROP CONSTRAINT IF EXISTS aditivo_nombre_key;
ALTER TABLE IF EXISTS public.valor_estudio_sector ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.unidad_medida ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.tipo_muestra ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.tecnica_recoleccion ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sector ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.recipiente ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.prioridad_envio ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.preanalitico ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.muestra ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.modalidad_recoleccion ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.metodo ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.estudio_colega_muestra_alternativa ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.estudio_colega_muestra ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.estudio_colega_modelo ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.estudio_colega ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.estudio ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.conservacion ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.condicion_especial ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.aditivo ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.valor_estudio_sector_id_seq;
DROP VIEW IF EXISTS public.v_estudios_colegas;
DROP TABLE IF EXISTS public.valor_estudio_sector;
DROP SEQUENCE IF EXISTS public.unidad_medida_id_seq;
DROP TABLE IF EXISTS public.unidad_medida;
DROP SEQUENCE IF EXISTS public.tipo_muestra_id_seq;
DROP TABLE IF EXISTS public.tipo_muestra;
DROP SEQUENCE IF EXISTS public.tecnica_recoleccion_id_seq;
DROP TABLE IF EXISTS public.tecnica_recoleccion;
DROP SEQUENCE IF EXISTS public.sector_id_seq;
DROP TABLE IF EXISTS public.sector;
DROP SEQUENCE IF EXISTS public.recipiente_id_seq;
DROP TABLE IF EXISTS public.recipiente;
DROP SEQUENCE IF EXISTS public.prioridad_envio_id_seq;
DROP TABLE IF EXISTS public.prioridad_envio;
DROP SEQUENCE IF EXISTS public.preanalitico_id_seq;
DROP TABLE IF EXISTS public.preanalitico;
DROP SEQUENCE IF EXISTS public.muestra_id_seq;
DROP TABLE IF EXISTS public.muestra;
DROP SEQUENCE IF EXISTS public.modalidad_recoleccion_id_seq;
DROP TABLE IF EXISTS public.modalidad_recoleccion;
DROP SEQUENCE IF EXISTS public.metodo_id_seq;
DROP TABLE IF EXISTS public.metodo;
DROP SEQUENCE IF EXISTS public.estudio_id_seq;
DROP SEQUENCE IF EXISTS public.estudio_colega_muestra_id_seq;
DROP SEQUENCE IF EXISTS public.estudio_colega_muestra_alternativa_id_seq;
DROP TABLE IF EXISTS public.estudio_colega_muestra_alternativa;
DROP TABLE IF EXISTS public.estudio_colega_muestra;
DROP SEQUENCE IF EXISTS public.estudio_colega_modelo_id_seq;
DROP TABLE IF EXISTS public.estudio_colega_modelo;
DROP SEQUENCE IF EXISTS public.estudio_colega_id_seq;
DROP TABLE IF EXISTS public.estudio_colega;
DROP TABLE IF EXISTS public.estudio;
DROP SEQUENCE IF EXISTS public.conservacion_id_seq;
DROP TABLE IF EXISTS public.conservacion;
DROP SEQUENCE IF EXISTS public.condicion_especial_id_seq;
DROP TABLE IF EXISTS public.condicion_especial;
DROP TABLE IF EXISTS public.colega;
DROP SEQUENCE IF EXISTS public.aditivo_id_seq;
DROP TABLE IF EXISTS public.aditivo;
DROP TYPE IF EXISTS public.estado_registro_enum;
DROP TYPE IF EXISTS public.estado_paridad_enum;
--
-- Name: estado_paridad_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.estado_paridad_enum AS ENUM (
    'listo',
    'pendiente',
    'revisar',
    'inactivo',
    'discontinuado'
);


--
-- Name: estado_registro_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.estado_registro_enum AS ENUM (
    'listo',
    'pendiente',
    'revisar',
    'verificado',
    'borrador'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: aditivo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aditivo (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


--
-- Name: aditivo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.aditivo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: aditivo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.aditivo_id_seq OWNED BY public.aditivo.id;


--
-- Name: colega; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.colega (
    id integer NOT NULL,
    descripcion character varying(255) NOT NULL,
    es_propio boolean DEFAULT false NOT NULL
);


--
-- Name: colega_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.colega ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.colega_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: condicion_especial; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.condicion_especial (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


--
-- Name: condicion_especial_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.condicion_especial_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: condicion_especial_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.condicion_especial_id_seq OWNED BY public.condicion_especial.id;


--
-- Name: conservacion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.conservacion (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


--
-- Name: conservacion_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.conservacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: conservacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.conservacion_id_seq OWNED BY public.conservacion.id;


--
-- Name: estudio; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.estudio (
    id integer NOT NULL,
    codigo_hexalis character varying(50) NOT NULL,
    descripcion text NOT NULL
);


--
-- Name: estudio_colega; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.estudio_colega (
    id integer NOT NULL,
    nemonico_datatech character varying(50) NOT NULL,
    paridad_datatech_hexalis public.estado_paridad_enum DEFAULT 'pendiente'::public.estado_paridad_enum NOT NULL,
    id_estudio integer NOT NULL,
    id_metodo integer,
    id_preanalitico integer,
    id_muestra integer,
    id_sector_laboratorio integer,
    indicaciones_pacientes text,
    valor_referencia text,
    dias_demora integer DEFAULT 0,
    estado public.estado_registro_enum DEFAULT 'pendiente'::public.estado_registro_enum NOT NULL,
    codigo_laboratorio character varying(50) DEFAULT NULL::character varying,
    version integer DEFAULT 1 NOT NULL,
    revisor character varying(100) NOT NULL,
    observacion text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    colega_id integer NOT NULL,
    indicaciones_colega text
);


--
-- Name: estudio_colega_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.estudio_colega_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: estudio_colega_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.estudio_colega_id_seq OWNED BY public.estudio_colega.id;


--
-- Name: estudio_colega_modelo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.estudio_colega_modelo (
    id integer NOT NULL,
    id_estudio_colega integer NOT NULL,
    nombre_archivo character varying(255) NOT NULL,
    contenido bytea NOT NULL,
    tamanio_bytes integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: estudio_colega_modelo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.estudio_colega_modelo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: estudio_colega_modelo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.estudio_colega_modelo_id_seq OWNED BY public.estudio_colega_modelo.id;


--
-- Name: estudio_colega_muestra; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.estudio_colega_muestra (
    id integer NOT NULL,
    id_estudio_colega integer NOT NULL,
    id_tipo_muestra integer NOT NULL,
    id_aditivo integer,
    volumen numeric(10,2),
    id_unidad_medida integer,
    id_recipiente integer,
    id_modalidad_recoleccion integer,
    id_tecnica_recoleccion integer,
    id_conservacion integer,
    id_condicion_especial integer,
    id_prioridad_envio integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    orden integer DEFAULT 1 NOT NULL,
    observacion text
);


--
-- Name: estudio_colega_muestra_alternativa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.estudio_colega_muestra_alternativa (
    id integer NOT NULL,
    id_estudio_colega_muestra integer NOT NULL,
    id_tipo_muestra integer NOT NULL,
    id_aditivo integer,
    volumen numeric(10,2),
    id_unidad_medida integer,
    id_recipiente integer,
    id_modalidad_recoleccion integer,
    id_tecnica_recoleccion integer,
    id_conservacion integer,
    id_condicion_especial integer,
    id_prioridad_envio integer,
    orden integer DEFAULT 1 NOT NULL,
    observacion text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: estudio_colega_muestra_alternativa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.estudio_colega_muestra_alternativa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: estudio_colega_muestra_alternativa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.estudio_colega_muestra_alternativa_id_seq OWNED BY public.estudio_colega_muestra_alternativa.id;


--
-- Name: estudio_colega_muestra_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.estudio_colega_muestra_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: estudio_colega_muestra_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.estudio_colega_muestra_id_seq OWNED BY public.estudio_colega_muestra.id;


--
-- Name: estudio_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.estudio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: estudio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.estudio_id_seq OWNED BY public.estudio.id;


--
-- Name: metodo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metodo (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text
);


--
-- Name: metodo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.metodo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: metodo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.metodo_id_seq OWNED BY public.metodo.id;


--
-- Name: modalidad_recoleccion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.modalidad_recoleccion (
    id integer NOT NULL,
    nombre character varying(150) NOT NULL
);


--
-- Name: modalidad_recoleccion_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.modalidad_recoleccion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: modalidad_recoleccion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.modalidad_recoleccion_id_seq OWNED BY public.modalidad_recoleccion.id;


--
-- Name: muestra; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.muestra (
    id integer NOT NULL,
    nombre character varying(150) NOT NULL,
    observacion text
);


--
-- Name: muestra_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.muestra_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: muestra_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.muestra_id_seq OWNED BY public.muestra.id;


--
-- Name: preanalitico; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.preanalitico (
    id integer NOT NULL,
    nombre character varying(150) NOT NULL,
    descripcion text
);


--
-- Name: preanalitico_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.preanalitico_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: preanalitico_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.preanalitico_id_seq OWNED BY public.preanalitico.id;


--
-- Name: prioridad_envio; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.prioridad_envio (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


--
-- Name: prioridad_envio_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.prioridad_envio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prioridad_envio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.prioridad_envio_id_seq OWNED BY public.prioridad_envio.id;


--
-- Name: recipiente; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recipiente (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


--
-- Name: recipiente_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.recipiente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recipiente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.recipiente_id_seq OWNED BY public.recipiente.id;


--
-- Name: sector; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sector (
    id integer NOT NULL,
    nombre character varying(150) NOT NULL
);


--
-- Name: sector_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sector_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sector_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sector_id_seq OWNED BY public.sector.id;


--
-- Name: tecnica_recoleccion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tecnica_recoleccion (
    id integer NOT NULL,
    nombre character varying(150) NOT NULL
);


--
-- Name: tecnica_recoleccion_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tecnica_recoleccion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tecnica_recoleccion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tecnica_recoleccion_id_seq OWNED BY public.tecnica_recoleccion.id;


--
-- Name: tipo_muestra; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tipo_muestra (
    id integer NOT NULL,
    nombre character varying(150) NOT NULL
);


--
-- Name: tipo_muestra_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tipo_muestra_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tipo_muestra_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tipo_muestra_id_seq OWNED BY public.tipo_muestra.id;


--
-- Name: unidad_medida; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.unidad_medida (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);


--
-- Name: unidad_medida_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.unidad_medida_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: unidad_medida_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.unidad_medida_id_seq OWNED BY public.unidad_medida.id;


--
-- Name: valor_estudio_sector; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.valor_estudio_sector (
    id integer NOT NULL,
    id_estudio integer NOT NULL,
    posicion_informe integer NOT NULL,
    rango character varying(100),
    id_sector integer NOT NULL
);


--
-- Name: v_estudios_colegas; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.v_estudios_colegas AS
 SELECT ec.id,
    ec.nemonico_datatech,
    ec.paridad_datatech_hexalis,
    ec.colega_id,
    ec.id_estudio,
    e.codigo_hexalis,
    e.descripcion AS estudio_descripcion,
    ec.id_metodo,
    m.nombre AS metodo_nombre,
    ec.id_preanalitico,
    p.nombre AS preanalitico_nombre,
    ec.id_muestra,
    mu.nombre AS muestra_nombre,
    ec.id_sector_laboratorio,
    sec.nombre AS sector_nombre,
    ves.posicion_informe,
    ves.rango AS sector_rango,
    ec.indicaciones_pacientes,
    ec.indicaciones_colega,
    ec.valor_referencia,
    ec.dias_demora,
    ec.estado,
    ec.codigo_laboratorio,
    ec.version,
    ec.revisor,
    ec.observacion,
    ec.created_at,
    ec.updated_at
   FROM ((((((public.estudio_colega ec
     JOIN public.estudio e ON ((ec.id_estudio = e.id)))
     LEFT JOIN public.metodo m ON ((ec.id_metodo = m.id)))
     LEFT JOIN public.preanalitico p ON ((ec.id_preanalitico = p.id)))
     LEFT JOIN public.muestra mu ON ((ec.id_muestra = mu.id)))
     LEFT JOIN public.valor_estudio_sector ves ON ((ec.id_sector_laboratorio = ves.id)))
     LEFT JOIN public.sector sec ON ((ves.id_sector = sec.id)));


--
-- Name: valor_estudio_sector_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.valor_estudio_sector_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: valor_estudio_sector_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.valor_estudio_sector_id_seq OWNED BY public.valor_estudio_sector.id;


--
-- Name: aditivo id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aditivo ALTER COLUMN id SET DEFAULT nextval('public.aditivo_id_seq'::regclass);


--
-- Name: condicion_especial id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.condicion_especial ALTER COLUMN id SET DEFAULT nextval('public.condicion_especial_id_seq'::regclass);


--
-- Name: conservacion id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conservacion ALTER COLUMN id SET DEFAULT nextval('public.conservacion_id_seq'::regclass);


--
-- Name: estudio id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio ALTER COLUMN id SET DEFAULT nextval('public.estudio_id_seq'::regclass);


--
-- Name: estudio_colega id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega ALTER COLUMN id SET DEFAULT nextval('public.estudio_colega_id_seq'::regclass);


--
-- Name: estudio_colega_modelo id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_modelo ALTER COLUMN id SET DEFAULT nextval('public.estudio_colega_modelo_id_seq'::regclass);


--
-- Name: estudio_colega_muestra id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra ALTER COLUMN id SET DEFAULT nextval('public.estudio_colega_muestra_id_seq'::regclass);


--
-- Name: estudio_colega_muestra_alternativa id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra_alternativa ALTER COLUMN id SET DEFAULT nextval('public.estudio_colega_muestra_alternativa_id_seq'::regclass);


--
-- Name: metodo id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metodo ALTER COLUMN id SET DEFAULT nextval('public.metodo_id_seq'::regclass);


--
-- Name: modalidad_recoleccion id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modalidad_recoleccion ALTER COLUMN id SET DEFAULT nextval('public.modalidad_recoleccion_id_seq'::regclass);


--
-- Name: muestra id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.muestra ALTER COLUMN id SET DEFAULT nextval('public.muestra_id_seq'::regclass);


--
-- Name: preanalitico id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.preanalitico ALTER COLUMN id SET DEFAULT nextval('public.preanalitico_id_seq'::regclass);


--
-- Name: prioridad_envio id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prioridad_envio ALTER COLUMN id SET DEFAULT nextval('public.prioridad_envio_id_seq'::regclass);


--
-- Name: recipiente id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipiente ALTER COLUMN id SET DEFAULT nextval('public.recipiente_id_seq'::regclass);


--
-- Name: sector id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sector ALTER COLUMN id SET DEFAULT nextval('public.sector_id_seq'::regclass);


--
-- Name: tecnica_recoleccion id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tecnica_recoleccion ALTER COLUMN id SET DEFAULT nextval('public.tecnica_recoleccion_id_seq'::regclass);


--
-- Name: tipo_muestra id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipo_muestra ALTER COLUMN id SET DEFAULT nextval('public.tipo_muestra_id_seq'::regclass);


--
-- Name: unidad_medida id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unidad_medida ALTER COLUMN id SET DEFAULT nextval('public.unidad_medida_id_seq'::regclass);


--
-- Name: valor_estudio_sector id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.valor_estudio_sector ALTER COLUMN id SET DEFAULT nextval('public.valor_estudio_sector_id_seq'::regclass);


--
-- Data for Name: aditivo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.aditivo (id, nombre) FROM stdin;
1	Citrato de Sodio
2	Citrato de Sodio (Pobre en Plaquetas - PP)
3	EDTA
4	Heparina
5	Heparina Sódica
\.


--
-- Data for Name: colega; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.colega (id, descripcion, es_propio) FROM stdin;
50	IICT (A)	f
51	LABMED (B)	f
52	TURNER (C)	f
53	SEMIR (D)	f
54	CIBIC (E)	f
55	IBC (F)	f
56	IDYMIC (G)	f
57	HEMOTERAPIA SB (H)	f
58	CEREMIC (J)	f
59	CEMAR (I)	f
60	LAHT-K	f
61	LAHT-F	f
62	FBA	f
63	BMSB	f
64	MICROBIOLOGIA	f
49	BRITLAB	t
\.


--
-- Data for Name: condicion_especial; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.condicion_especial (id, nombre) FROM stdin;
1	Acidificada
2	Anaerobiosis
3	Doble Centrifugación
4	Estéril
\.


--
-- Data for Name: conservacion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.conservacion (id, nombre) FROM stdin;
1	A Temperatura Ambiente
2	Refrigerado / Refrigerada
3	Congelado
4	Fresca / En Seco
5	Sin Refrigerar
\.


--
-- Data for Name: estudio; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.estudio (id, codigo_hexalis, descripcion) FROM stdin;
2195	668580A	17 HIDROXIPROGESTERONA (EN NIÑOS MENORES DE 1 AÑO)
2196	668580	17-HIDROXIPROGESTERONA
2197	669050	21 HIDROXILASA, Ac. ANTI
2198	662085	ACIDO 5 HIDROX-INDOL ACETICO URINARIO
2199	662111	ACIDO BETA HIDROXIBUTIRICO
2200	662128	ACIDO FENIL ACETICO (AFA) URINARIO
2201	660352	ACIDO FOLICO
2202	662153	ACIDO FOLICO INTRAERITROCITARIO
2203	662183	ACIDO GLUTAMICO
2204	660492	ACIDO HOMOGENTISICO
2205	662205	ACIDO HOMOVANILICO - HVA
2206	660592	ACIDO LACTICO
2207	666222	HISTAMINA PLASMATICA
2208	662274	ACIDO METIL MALONICO URINARIO
2209	662277	ACIDO MUCONICO
2210	662281	ACIDO OROTICO URINARIO
2211	662299	ACIDO OXALICO URINARIO
2212	662316	ACIDO PIRUVICO
2213	660932	ACIDO VAINILLIN MANDELICO - AVM
2214	661135G	ACIDO VALPROICO, MONITOREO de FARMACOS para ENF. CRONICAS
2215	662367	ACIDOS BILIARES SERICOS
2216	662379	ACIDOS GRASOS NO ESTERIFICADOS (NEFA)
2217	662393	ACIDOS ORGANICOS URINARIOS
2218	662401	ACIL CARNITINAS
2219	660006	ACTH - HORMONA ADRENOCORTICOTROFINA
2220	660007	ADDIS, RECUENTO DE
2221	662417	ADENOSIN DEAMINASA - ADA
2222	662446	ADENOVIRUS - PCR
2223	662446A	ADENOVIRUS EN HECES, BIOPSIA, LIQ. PUNCION - PCR
2224	662427	ADENOVIRUS, Ac. IgG ANTI
2225	663435	ADENOVIRUS, Ac. IgM ANTI
2226	662444	ADENOVIRUS, ANTIGENO (Ag.)
2227	ARN16S	ADN RIBOSOMAL 16S, DETECCION POR PCR
2228	662452	ADRENAL, Ac. TOTALES ANTI
2229	660143A	ADRENALINA PLASMATICA (CATECOLAMINA PLASMATICA)
2230	660143B	ADRENALINA URINARIA
2231	660015	ALBUMINA SERICA
2232	660018	ALDOLASA
2233	660019	ALDOSTERONA SERICA
2234	662461	ALDOSTERONA URINARIA
2235	660057	ALFA 1 ANTITRIPSINA EN MATERIA FECAL
2236	1314	ALFA 1 ANTITRIPSINA SERICA
2237	662495	ALFA 1 ANTITRIPSINA, CLEARENCE DE
2238	660020	ALFA FETO PROTEINA
2239	662589	ALUMINIO SERICO
2240	660422A	AMILASA EN LIQUIDO BIOLOGICO
2241	660022	AMILASA SERICA
2242	662623	AMINOACIDOS SERICOS, CUANTITATIVOS
2243	662630	AMINOACIDOS URINARIOS, CUANTITATIVOS
2244	660031	AMONEMIA
2245	662666	ANDROSTENEDIOL GLUCURONIDO (ALFA DIOL GLUCURONIDO)
2246	662709	ANTICOAGULANTE LUPICO
2247	662712	ANTIDIURETICA, HORMONA (HAD) - VASOPRESINA
2248	660051	ANTIESTREPTOLISINAS "O"
2249	661000	ANTIGENO PROSTATICO ESPECIFICO TOTAL
2250	AEP	ANTIGENO PROSTATICO ESPECIFICO TOTAL - PSAt
2251	661000A	ANTIGENO PROSTATICO ESPECIFICO TOTAL Y LIBRE
2252	662734	ANTIGENO PROSTATICO ESPECIFICO TOTAL Y LIBRE
2253	664623	ANTIGENOS NUCLEARES EXTRAIDOS, Ac. ANTI (ENA)
2254	660055	ANTIMITOCONDRIALES, ANTICUERPOS (AMA)
2255	662790	ANTIMULLERIANA, HORMONA (HAM)
2256	662803	ANTITROMBINA III, ACTIVIDAD FUNCIONAL
2257	662811	APOLIPOPROTEINA A
2258	662811B	APOLIPOPROTEINA B
2259	662411	AQUAPORINA 4, Ac. IgG ANTI (NMO-Ac. IgG)
2260	661411	AQUAPORINA 4, Ac. IgG ANTI (NMO-Ac. IgG) EN LCR
2261	660059	ARSENICO (As) SERICO
2262	668315	ATPO - PEROXIDASA TIROIDEA, AC. ANTI
2263	660455	BANDAS OLIGOCLONALES EN LCR
2264	662912	BARTONELLA HENSELAE, Ac. IgG ANTI
2265	662914	BARTONELLA HENSELAE, Ac. IgM ANTI
2266	669633	BCR/ABL p210 CUANTITATIVO - TRANSLOCACION BCR/ABL
2267	660108	BENCE JONES, PROTEINAS DE
2268	662982A	BETA 2 GLICOPROTEINA, Ac. IgG ANTI
2269	662982	BETA 2 GLICOPROTEINA, Ac. IgM ANTI
2270	667503	BETA 2 MICROGLOBULINA
2271	783	BETA CAROTENO
2272	663025	BETA CROSS LAPS (CTX-C) - TELOPEPTIDO DE COLAGENO TIPO I
2273	660004	BICARBONATO
2274	663065	BICARBONATO EN ORINA
2275	660110	BILIRRUBINEMIA TOTAL, DIRECTA E INDIRECTA
2276	667759	BIOTINIDASA, ACTIVIDAD DE (NEONATAL)
2277	663120A	BORDETELLA - PCR MULTIPLEX
2278	663102	BORDETELLA PERTUSIS, Ac. IgG ANTI (EIA)
2280	663110	BORDETELLA PERTUSIS, Ac. IgM ANTI (EIA)
2282	663110A	BORDETELLA PERTUSIS, Ac. IgM ANTI (IFI)
2283	663128	BORRELIA BURGDORFERI, Ac. IgG ANTI
2284	663136	BORRELIA BURGDORFERI, Ac. IgM ANTI
2285	663158	BRUCELLAS, TEST DE WRIGHT
2286	663159	BRUCELLAS, TEST DE WRIGHT con 2-MERCAPTOETANOL
2287	663179	BRUCELOSIS, Ac. IgG ANTI
2288	663187	BRUCELOSIS, Ac. IgM ANTI
2289	660451	BUFOTENINA EN ORINA
2290	663230	C1 INHIBIDOR (C1 INHIBIDOR INMUNOLOGICO)
2291	661115	CA 125, MARCADOR TUMORAL de OVARIO
2292	CA15-3	CA 15-3, MARCADOR TUMORAL de MAMA
2293	661125B	CA 19-9, MARCADOR TUMORAL de COLON
2294	661125	CA 19-9, MARCADOR TUMORAL de COLON
2295	663239	CA 21-1, MARCADOR TUMORAL DE PULMON (CYFRA 21-1)
2296	663247	CA 72-4, MARCADOR TUMORAL GÁSTRICO
2297	660131C	CADENA LIVIANA KAPPA Y LAMBDA SERICA
2298	660131	CADENA LIVIANA KAPPA Y LAMBDA URINARIO
2299	660131A	CADENAS LIVIANAS LIBRES KAPPA Y LAMBDA SERICAS
2300	669635	CADENAS PESADAS DE INMUNOGLOBULINAS, REARREGLO DEL GEN
2301	660136B	CALCIO EN ORINA AISLADA
2302	660134	CALCIO IONICO
2303	660133	CALCIO TOTAL
2304	660136	CALCIO URINARIO
2305	660137	CALCITONINA
2750	661150	RUBEOLA, Ac. IgM ANTI
2306	660137B	CALCITONINA EN ASPIRADO DE NÓDULO
2307	660138	CALCULO URINARIO, ESTUDIO CRISTALOGRAFICO
2308	700001	CALPROTECTINA EN MATERIA FECAL
2309	661134B	CARBAMAZEPINA, MONITOREO de FARMACOS para ENF. CRONICAS
2310	663375	CARBOXIHEMOGLOBINA
2311	663392	CARDIOLIPINAS, Ac. IgG ANTI
2312	663401	CARDIOLIPINAS, Ac. IgM ANTI
2313	663435A	CARIOTIPO - LIQUIDO AMNIOTICO
2314	663440	CARIOTIPO - MATERIAL DE ABORTO
2315	663443	CARIOTIPO - MEDULA OSEA (CITOGENETICO DE MO)
2316	663430	CARIOTIPO - SANGRE PERIFERICA (CITOGENETICO)
2317	663427	CARIOTIPO CON BANDEO - ALTA RESOLUCION
2318	663463	CARNITINA, LIBRE Y TOTAL SERICA
2319	660143	CATECOLAMINAS URINARIAS
2320	663512E	CD16, SUBPOBLACION LINFOCITARIA
2321	663504	CD19, SUBPOBLACION LINFOCITARIA
2322	663538E	CD2, SUBPOBLACION LINFOCITARIA
2323	663512	CD25, SUBPOBLACION LINFOCITARIA
2325	663512B	CD3/CD16+56, CELULAS NK
2326	663495	CD34, SUBPOBLACION LINFOCITARIA
2327	661015	CD4/CD8/CD3, SUBPOBLACION LINFOCITARIA
2328	663529	CD56, SUBPOBLACION LINFOCITARIA
2329	661015B	CD8, SUBPOBLACION LINFOCITARIA
2330	660144	CEA - ANTIGENO CARCINOEMBRIOGENICO
2331	663555	CELULAS PARIETALES GASTRICAS, Ac. ANTI
2332	663563	CENTROMERO, Ac. ANTI
2333	660151	CERULOPLASMINA
2334	050	CETONEMIA
2335	051	CETONURIA
2336	660242	CHAGAS, DETECCION POR EIA
2337	660241	CHAGAS, DETECCION POR HAI
2338	660243	CHAGAS, DETECCION POR IFI
2339	663576	CHAGAS, DETECCION POR PCR (CUALITATIVO)
2340	663591	CHLAMYDIA PNEUMONIAE - ADN POR PCR
2341	661020	CHLAMYDIA PNEUMONIAE, Ac. IgG ANTI
2342	663589	CHLAMYDIA PNEUMONIAE, Ac. IgM ANTI
2343	663598	CHLAMYDIA PSITACCI, Ac. IgG ANTI
2344	663606	CHLAMYDIA PSITACCI, Ac. IgM ANTI
2345	663601	CHLAMYDIA TRACHOMATIS - PCR
2346	663623	CHLAMYDIA TRACHOMATIS, Ac. IgG ANTI
2347	663632	CHLAMYDIA TRACHOMATIS, Ac. IgM ANTI
2348	100002	CISTATINA C
2349	663683	CISTINA EN ORINA
2350	663722C	CITOMEGALOVIRUS EN LCR, ADN POR PCR (CUALITATIVO)
2351	663722B	CITOMEGALOVIRUS EN M. BIOLOGICA, ADN POR PCR (CUALITATIVO)
2352	663722A	CITOMEGALOVIRUS EN ORINA, ADN POR PCR (CUALITATIVO)
2353	663720B	CITOMEGALOVIRUS EN ORINA, CUANTITATIVO POR PCR
2354	663722	CITOMEGALOVIRUS EN PLASMA, ADN POR PCR (CUALITATIVO)
2355	661025	CITOMEGALOVIRUS, Ac. IgG ANTI
2356	661030	CITOMEGALOVIRUS, Ac. IgM ANTI
2357	663720	CITOMEGALOVIRUS, ADN CARGA VIRAL (CUANTITATIVO)
2358	661025A	CITOMEGALOVIRUS, TEST DE AVIDEZ
2359	663734	CITOPLASMA DE NEUTROFILO CITOPLASMATICO, Ac. ANTI (ANCA C)
2360	663734A	CITOPLASMA DE NEUTROFILO PERIFERICO, Ac. ANTI (ANCA P)
2361	662120	CITRATURIA (ACIDO CITRICO URINARIO)
2362	661136A	CLOBAZAN, MONITOREO de FARMACOS para ENF. CRONICAS
2363	661136B	CLOZAPINA, MONITOREO de FARMACOS para ENF. CRONICAS
2364	660170	COAGULO, RETRACCION DEL
2365	300	COAGULOGRAMA COMPLETO
2366	660172	COBRE SERICO
2367	661035	COLESTEROL HDL
2368	661040	COLESTEROL LDL
2369	660174	COLESTEROL TOTAL
2370	669918A	COLESTEROL VLDL
2371	669918	COLESTEROL VLDL
2372	661040B	COLESTEROL-LDL
2373	660772	COLINESTERASA SERICA
2374	663922	COMPLEMENTO C1Q (PROTEINA 11S)
2375	660180	COMPLEMENTO C3
2376	660180A	COMPLEMENTO C4
2377	660179	COMPLEMENTO, ACTIVIDAD TOTAL - 50% DE LISIS (CH50)
2378	662764	CORONAVIRUS COVID-19, DETECCION POR PCR
2379	660189	CORTISOL 8h
2380	660189P	CORTISOL BASAL (8h) Y VESPERTINO (18h)
2381	664008	CORTISOL LIBRE URINARIO
2382	664012	CORTISOL SALIVAL
2383	664012A	CORTISOL SALIVAL - 08:00h
2384	664012B	CORTISOL SALIVAL - 12:00h
2385	664012C	CORTISOL SALIVAL - 18:00h
2386	664012D	CORTISOL SALIVAL - 22:00h
2387	660189D	CORTISOL, POST-ESTIMULO CON DEXAMETASONA
2388	664102	COXSACKIE VIRUS B (1-2-3-4-5-6), Ac. IgM ANTI
2389	660190	CREATINAFOSFOQUINASA - CPK
2390	660190B	CREATINAFOSFOQUINASA, ISOENZIMA MB (CPKMB masa)
2391	660192D	CREATININA EN LIQUIDO BIOLOGICO
2392	660192B	CREATININA EN ORINA AISLADA
2393	660192	CREATININA SERICA
2394	660192A	CREATININA URINARIA
2395	193	CREATININA, CLEARENCE DE DEPURACION
2396	660195A	CRIOAGLUTININAS
2397	660195	CRIOGLOBULINAS
2398	661409	CROMOGRANINA A
2399	664147	CROMOSOMA 12, ALTERACIONES - TRISOMIA 12 - CENTROMERO 12
2400	660611	DELTA 4 ANDROSTENEDIONA
2401	664369	DENGUE-RNA CUALITATIVO (RT-PCR)
2402	664375	DEOXIPIRIDINOLINAS URINARIAS
2403	660262	DHEA-S DEHIDROEPIANDROSTERONA, SULFATO
2404	661135E	DIFENILHIDANTOINA, MONITOREO de FARMACOS para ENF. CRONICAS
2405	660268	DIGOXINA
2406	664419A	DIMERO-D
2407	664444	DIMETOXIFENILETILAMINA, 3, 4 (DMFA)
2408	660049	DNA NATIVO, Ac. ANTI
2409	664505	DOPAMINA TOTAL SERICA
2410	664512	DOPAMINA URINARIA
2411	661050A	DROGAS DE ABUSO, SCREENING
2412	664580	ECHOVIRUS, Ac. IgG (4,6,9,11,30, 34) ANTI
2413	664583	ECHOVIRUS, Ac. IgM (4,6,9,11,30,34) ANTI
2414	660373A	ELASTASA PANCREATICA EN MATERIA FECAL
2415	1213	ENCEFALITIS AUTOINMUNE, PANEL DE ANTICUERPOS
2416	1214	ENCEFALITIS AUTOINMUNE, PANEL DE ANTICUERPOS EN LCR
2417	664632	ENDOMISIO, Ac. IgA ANTI (EMA IgA)
2418	664640	ENDOMISIO, Ac. IgG ANTI (EMA IgG)
2419	667802	ENOLASA NEURONAL ESPECIFICA - NSE
2420	664691	ENTEROVIRUS - PCR
2421	664690	ENTEROVIRUS, Ac. IgG (ECHOVIRUS y COXSACKIE)
2422	664700	ENZIMA CONVERTIDORA DE ANGIOTENSINA (ECA)
2423	664700A	ENZIMA CONVERTIDORA DE ANGIOTENSINA EN LCR - ECA
2424	664728A	EPSTEIN BARR EN LCR, DETECCION POR PCR (CUALITATIVO)
2425	661055	EPSTEIN BARR, Ac. IgG ANTI-CAPSIDE VIRAL
2426	661060	EPSTEIN BARR, Ac. IgM ANTI-CAPSIDE VIRAL
2427	661061	EPSTEIN BARR, ADN CARGA VIRAL - PCR
2428	661061A	EPSTEIN BARR, DETECCION POR PCR
2429	664734	ERITROPOYETINA (EPO)
2430	660297	ERITROSEDIMENTACION
2431	664366A	ESCLERODERMIA/MIOSITIS, PANEL DE AUTOANTICUERPOS
2432	660005	ESTADO ACIDO BASE CON OXIMETRIA
2433	66005A	ESTADO ACIDO BASE CON OXIMETRIA E IONOGRAMA
2434	66499	ESTEATOCRITO (GRASAS - MATERIA FECAL)
2435	660300	ESTRADIOL SERICO - E2
2436	660302	ESTRIOL LIBRE SERICO
2437	660305	ESTRONA
2438	665050	EUGLOBULINAS, LISIS DE (POST-ISQUEMIA)
2439	665050A	EUGLOBULINAS, LISIS DE (PRE-ISQUEMIA)
2440	665053	EVEROLIMUS
2441	665085	FACTOR INTINSECO, Ac. ANTI
2442	660598	FACTOR REUMATOIDEO
2443	665102	FACTOR V LEIDEN, MUTACION - PCR
2444	660056	FAN - ANTICUERPOS ANTINUCLEARES
2445	660337	FENILALANINA CONFIRMATORIO (HPLC)
2446	665144	FENILETILAMINA - FEA
2447	661135C	FENOBARBITAL, MONITOREO de FARMACOS para ENF. CRONICAS
2448	660343	FERREMIA
2449	665230	FERRITINA
2450	660345	FIBRINOGENO
2451	669101F	FLT3 - ITD, MUTACIONES DEL GEN (LMA)
2452	660354A	FORMULA LEUCOCITARIA ABSOLUTA
2453	665349	FOSFATASA ALACALINA OSEA
2454	660357	FOSFATASA ALCALINA
2455	660362	FOSFATEMIA
2456	665392	FOSFATIDIL GLICEROL
2457	660363	FOSFATURIA
2458	660363A	FOSFATURIA EN ORINA AISLADA
2459	665452	FOSFOLIPIDOS, Ac. IgG ANTI
2460	665461	FOSFOLIPIDOS, Ac. IgM ANTI
2461	660367A	FOSFORO, REABSORCION TUBULAR
2462	661065	FRUCTOSAMINA
2463	660370	FSH - HORMONA FOLICULO ESTIMULANTE
2464	660371	FTA ABS (IFI) SIFILIS Y TPHA
2465	665503	GAD - ACIDO GLUTAMICO DESCARBOXILASA, Ac. ANTI
2466	665512	GALACTOSA 1-URIDIL FOSFOTRANSFERASA
2467	667768	GALACTOSEMIA, NEONATAL
2468	660420	GAMA GLUTAMIL TRANSPEPTIDASA
2469	1221	GANGLIOSIDOS PANEL, Ac. GM1 Asialo, GM2, GD1A, GD1b, GQ1b
2470	660405	GASTRINA SERICA
2471	665572	GLIADINA, Ac. IgA ANTI (AGA-IgA)
2472	665580	GLIADINA, Ac. IgG ANTI (AGA-IgG)
2473	661406	GLIADINA, PEPTIDO DEAMIDADO Ac. IgA ANTI (DGP-IgA)
2474	661405	GLIADINA, PEPTIDO DEAMIDADO Ac. IgG ANTI (DGP-IgG)
2475	665632	GLOBULINA LIGADORA DE ANDROGENOS Y ESTROGENOS - GLAE - SHBG
2476	660409	GLOBULOS BLANCOS, RECUENTO DE
2477	660410	GLOBULOS ROJOS, RECUENTO DE
2478	660412	GLUCEMIA
2479	660412A	GLUCEMIA INTRA CIRUGÍA
2480	660506	GLUCEMIA POST PRANDIAL 75 g
2481	660504	GLUCEMIA, 120 minutos post 75 g de glucosa
2482	660505	GLUCEMIA, 180 minutos post 75 g de glucosa
2483	660501	GLUCEMIA, 30 minutos post 75 g de glucosa
2484	660502	GLUCEMIA, 60 minutos post 75 g de glucosa
2485	660503	GLUCEMIA, 90 minutos post 75 g de glucosa
2486	660419	GLUCOSA-6-FOSFATO DESHIDROGENASA
2487	660412C	GLUCOSURIA EN ORINA AISLADA
2488	665666	GLUTATION PEROXIDASA (GPO)
2489	660432	GRASAS, CUANTITATIVO (VAN DE KAMER) - MATERIA FECAL
2490	660007A	HAMBURGER, RECUENTO DE
2491	665734	HAPTOGLOBINA
2492	668627	HE4 - PROTEINA DEL EPIDIDIMO HUMANO 4
2493	1453	HELICOBACTER PYLORI - PCR
2494	665751	HELICOBACTER PYLORI, Ac. IgG ANTI
2495	665770	HELICOBACTER PYLORI, Ac. IgM ANTI
2496	HU	HEMATIES URINARIOS, EVALUACION MORFOLOGICA
2497	660466	HEMATOCRITO
2498	665794	HEMOCROMATOSIS, MUTACION C282Y, H63D Y S65C
2499	661070	HEMOGLOBINA GLICOSILADA - HbA1c
2500	660470	HEMOGLOBINA, DOSAJE DE
2501	660475	HEMOGRAMA CON RECUENTO DE PLAQUETAS
2502	660475B	HEMOGRAMA SIN RECUENTO DE PLAQUETAS
2503	665871	HEPARINA DE BAJO PESO MOLECULAR, ACTIVIDAD ANTI Xa
2504	665888	HEPATITIS A, Ac. IgG ANTI (HVA IgG)
2505	661075	HEPATITIS A, Ac. IgM ANTI (HVA IgM)
2506	665905	HEPATITIS B, Ac. ANTI-CORE IgM (HBc-IgM)
2507	661080	HEPATITIS B, Ac. ANTI-CORE TOTALES (HBc-Ac. TOTALES)
2508	665896	HEPATITIS B, Ac. ANTI-e (HBeAc)
2509	661086	HEPATITIS B, Ac. DE SUPERFICIE ANTI - HBsAc
2510	661080A	HEPATITIS B, Ac. IgG  ANTI-CORE (HBc-IgG)
2511	665931	HEPATITIS B, ADN VIRAL (HBV-DNA) CUALITATIVO - PCR
2512	661090	HEPATITIS B, ANTIGENO DE SUPERFICIE - HBsAg
2513	661085	HEPATITIS B, ANTIGENO e (AgHBe)
2514	665914	HEPATITIS B, CARGA VIRAL
2515	661095	HEPATITIS C, Ac. IgG ANTI (HCV Ac IgG)
2516	665982	HEPATITIS C, ARN CUALITATIVO POR PCR
2517	665956	HEPATITIS C, CARGA VIRAL
2518	666011	HEPATITIS E - PCR
2519	666008B	HEPATITIS E, Ac. IgM ANTI
2521	660481	HEPATOGRAMA
2522	666037A	HERPES SIMPLEX - DNA (PCR) EN LCR
2523	666037	HERPES SIMPLEX 1 y 2 - DNA (PCR)
2524	666042	HERPES SIMPLEX 1, Ac. IgG ANTI
2525	666050	HERPES SIMPLEX 1, Ac. IgM ANTI
2526	666067	HERPES SIMPLEX 2, Ac. IgG ANTI
2527	666076	HERPES SIMPLEX 2, Ac. IgM ANTI
2528	666093	HERPES VIRUS 6 HUMAN, Ac. IgG (HHV6-IgG) ANTI
2529	666096	HERPES VIRUS 6 HUMAN, Ac. IgM (HHV6-IgM) ANTI
2530	660484	HIDATIDOSIS, Ac. IgG o TOTALES ANTI (IFI)
2531	666173	HIDATIDOSIS, Ac. IgM ANTI (IFI)
2532	666170	HIDATIDOSIS, Ac. TOTALES ANTI (EIA)
2533	666238	HISTONA, Ac. ANTI
2534	664390	HISTOPLASMA CAPSULATUM - ANTIGENO URINARIO
2535	664615	HISTOPLASMA CAPSULATUM - PCR
2536	666247	HISTOPLASMA CAPSULATUM, Ac. TOTALES ANTI
2537	661105	HIV-1 CARGA VIRAL - PCR CUANTITATIVA
2538	661108	HIV-1 RNA - PCR CUALITATIVA
2539	000004	HIV-1, DETECCION DEL DNA PROVIRAL
2540	661110	HIV, Ac. ANTI - WESTERN-BLOT
2541	660063	HIV, Ac. ANTI-HIV1 y 2 - p24 (Combo)
2542	660063A	HIV, TEST RAPIDO (Ac. ANTI-HIV-1 Y ANTI-HIV-2)
2543	664627B	HLA CLASE I - TIPIFICACION MOLECULAR LOCUS B
2544	666445	HLA DQ2-DQ8 (CELIAQUIA) PCR
2545	666332	HLA-B27, DETECCION DEL ALELO
2546	664627A	HLA-B51, DETECCION DEL ALELO
2547	666708	HOMA - HOMEOSTATIC MODEL ASSESSMENT
2548	666452	HOMOCISTEINA
2549	666533	HTLV I/II, ADN PROVIRAL (PCR)
2550	666537	HTLV-I/II, Ac. ANTI
2551	666554	HU (ANNA-1), Ac. ANTI
2552	660494	HUDLESSON, REACCION DE
2553	666560	IA 2, Ac. ANTI (Ac. ANTI-TIROSINFOSFATASA 2)
2554	664615B	IDH1 - IDH2, MUTACIONES EN ISOCITRATO DESHIDROGENASA
2555	380007	IgE RAST - ALMENDRA
2556	380009	IgE RAST - ALTERNARIA ALTERNATA (TENIUS)
2557	380012	IgE RAST - AMOXICILINA
2558	380019	IgE RAST - ASPERGILLUS FLAVUS
2559	380018	IgE RAST - ASPERGILLUS FUMIGATUS
2560	380020	IgE RAST - ASPERGILLUS NIGER
2561	380033	IgE RAST - CALAMAR
2562	380046	IgE RAST - CEFALOSPORINA
2563	380057	IgE RAST - CLARA DE HUEVO
2564	380058	IgE RAST - DERMATOPHAGOIDES FARINAE
2565	380059	IgE RAST - DERMATOPHAGOIDES PTERONYSSINUS
2566	380060	IgE RAST - DICLOFENAC
2567	380067	IgE RAST - EPITELIO DE GATO
2568	380076	IgE RAST - IBUPROFENO
2569	380	IgE RAST - INMUNOGLOBULINA E
2570	380089	IgE RAST - LANGOSTA
2571	380088	IgE RAST - MERLUZA
2572	380112	IgE RAST - PARACETAMOL
2573	380113	IgE RAST - PENICILINA G
2574	380114	IgE RAST - PENICILINA V
2575	380147	IgE RAST - YEMA DE HUEVO
2576	666734	INFLUENZA A, Ac. IgG ANTI
2577	666742	INFLUENZA A, Ac. IgM ANTI
2578	666730	INFLUENZA A, ANTIGENO (Ag.)
2579	666728	INFLUENZA A, DETECCION POR PCR
2580	666751	INFLUENZA B, Ac. IgG ANTI
2581	666760	INFLUENZA B, Ac. IgM ANTI
2582	666768A	INFLUENZA B, ANTIGENO (Ag.)
2583	666768	INFLUENZA B, DETECCIÓN POR PCR
2584	668387	INHIBIDOR DEL ACTIVADOR TISULAR DEL PLASMINOGENO (PAI) BIOLOGICO
2585	666788	INHIBINA B DIMERICA
2586	666819	INMUNOCOMPLEJOS CIRCULANTES (CIC)
2587	669101	INMUNOFENOTIPIFICACION - CITOMETRIA DE FLUJO
2588	666850	INMUNOFIJACION SERICA
2589	666852	INMUNOFIJACION URINARIA
2590	660537	INMUNOGLOBULINA A (IgA)
2591	666589	INMUNOGLOBULINA A SECRETORIA
2592	660538	INMUNOGLOBULINA D (IgD)
2593	660539	INMUNOGLOBULINA E (IgE)
2594	660540	INMUNOGLOBULINA G (IgG)
2595	666657	INMUNOGLOBULINA G (IgG), SUBCLASES
2596	666657D	INMUNOGLOBULINA G-4, SUBCLASE (IgG-4)
2597	660541	INMUNOGLOBULINA M (IgM)
2598	660543	INSULINA
2599	660543A	INSULINA POST PRANDIAL
2600	660543E	INSULINA, 120 min POST ESTIMULO
2601	660543H	INSULINA, 180 min POST ESTIMULO
2602	660543A2	INSULINA, 30 min POST ESTIMULO
2603	660543B	INSULINA, 60 min POST ESTIMULO
2604	660543C	INSULINA, 90 min POST ESTIMULO
2605	666862	INSULINA, Ac. ANTI (Ac. ANTI-IAA)
2606	666879	INTERLEUQUINA 6
2607	666879A	INTERLEUQUINA-1 BETA (IL-1B)
2608	666879C	INTERLEUQUINA-8 (IL-8)
2609	773000	IONOGRAMA EN MATERIA FECAL
2610	660547A	IONOGRAMA EN ORINA AISLADA
2611	660546	IONOGRAMA PLASMATICO
2612	660547	IONOGRAMA URINARIO
2613	666905	ISLOTE LANGERHANS PANCREATICOS, Ac. ANTI (ICA)
2614	661402	JAK-2, DETECCION DE LA MUTACION V617F
2615	661402A	JAK-2, SECUENCIACION DEL EXON 12
2616	667773	JARABE DE ARCE - LEUCINA, NEONATAL
2617	666922	JO-1, Ac. ANTI
2618	660887	KPTT
2619	663994	KPTT, CORRECCION CON PLASMA NORMAL
2620	666930	LA, Ac. ANTI (LA/SSB)
2621	660597	LACTICO DEHIDROGENASA - LDH
2622	661136	LAMOTRIGINA, MONITOREO de FARMACOS para ENF. CRONICAS
2623	660603	LAZO, PRUEBA DEL
2624	666982	LEPTINA
2625	5291	LEUCOCITOS EN MATERIA FECAL
2626	667070	LEVETIRACETAM, MONITOREO de FARMACOS para ENF. CRONICAS
2627	660612	LH - HORMONA LUTEINIZANTE
2628	660313	LIPASA
2629	667187	LIPOPROTEINA a - Lp(a)
2630	660619	LIQUIDO CEFALORRAQUIDEO, EXAMEN FISICOQUIMICO-CITOLOGICO
2631	660619A	LIQUIDO DE PUNCION, EXAMEN FISICOQUIMICO-CITOLOGICO
2632	660623	LITIO (Li)
2633	667272	LKM, Ac. ANTI (MICROSOMAL HIGADO Y RIÑON)
2634	667289	MACROPROLACTINEMIA
2635	667315	MAG-SGPG, Ac. IgM ANTI
2636	660653	MAGNESIO SERICO
2637	660654	MAGNESIO URINARIO
2638	660452	MANGANESO SERICO
2639	660656	MANTOUX, INTRADERMO-REACCION DE (PPD)
2640	660373	MATERIA FECAL, EXAMEN FISICO-QUIMICO Y MICROSCOPICO
2641	666711	MDRD-4, FILTRADO GLOMERULAR ESTIMADO
2642	660041	MEMBRANA BASAL GLOMERULAR, Ac. ANTI
2643	660660	MERCURIO (Hg) SERICO
2644	667409	METAHEMOGLOBINA
2645	667426	METANEFRINAS FRACCIONADAS URINARIAS
2646	667440	METAPNEUMOVIRUS HUMANO - PCR
2647	667439	METAPNEUMOVIRUS HUMANO, ANTIGENO (hMPV Ag.)
2648	667490	METILENTETRAHIDROFOLATO REDUCTASA (MTHRT) - PCR
2649	667486	METOTREXATO
2650	661130	MICROALBUMINURIA
2651	661130A	MICROALBUMINURIA/CREATININURIA, RELACION
2652	667529	MIELOPEROXIDASA, Ac. ANTI
2653	1030	MIOGLOBINA SERICA
2654	667550	MIOGLOBINA URINARIA
2655	660668	MOCO NASAL, pH Y CITOLOGICO
2656	MOGIGG	MOG, Ac. IgG ANTI (GLICOPROT. DE OLIGODENDROCITO DE MIELINA)
2657	660669	MONONUCLEOSIS (AGLUTINACION - MONOTEST)
2658	667597	MOPEG (3-METOXI, 4-HIDROXI-FENIL ETIL GLICOL)
2659	667631	MUSCULO ESTRIADO, Ac. ANTI
2660	667637	MUSCULO LISO, Ac. ANTI (ASMA)
2661	667636	MUSK, Ac. ANTI
2662	663618	MYCOPLASMA GENITALIUM - PCR
2663	662739A	MYCOPLASMA GENITALIUM, MYCOPLASMA HOMINIS Y UREAPLASMA - PCR
2664	667736	MYCOPLASMA PNEUMONIAE - ADN POR PCR
2665	667716	MYCOPLASMA PNEUMONIAE, Ac. IgG ANTI
2666	667717	MYCOPLASMA PNEUMONIAE, Ac. IgM ANTI
2667	667862	N TELOPEPTIDOS - COLAGENO TIPO I (NTX)
2668	663604	NEISSERIA GONORRHOEAE - DNA POR PCR
2669	667794	NEUMOCOCO, AC. POST-VACUNACION ANTI
2670	660143D	NORADRENALINA SERICA - CATECOLAMINA
2671	660143C	NORADRENALINA URINARIA (CATECOLAMINA)
2672	NOTA	NOTA
2673	664615A	NPM-1 (NUCLEOFOSMINA 1), MUTACIONES EN EL GEN
2674	660702	NUCLEOTIDASA, 5' N
2675	660711	ORINA COMPLETA
2676	667905	ORTO CRESOL (2-METILFENOL)
2677	667926	OSMOLALIDAD URINARIA
2678	667939	OSTEOCALCINA
2679	661134F	OXCARBAZEPINA, MONITOREO de FARMACOS para ENF. CRONICAS
2680	677990	PAI 1, POLIMORFISMO 4G/5G DEL GEN
2681	000002	PANEL Ac. ANTI-ANTIGENOS NEURONALES
2682	667999	PANEL HEPATICO INMUNOLOGICO
2683	662745A	PANEL RESPIRATORIO VIRAL POR IFD
2684	668011	PAPILOMA VIRUS HUMANO (HPV), DETECCION POR PCR
2685	668018	PAPP-A, PROT. A PLASMATICA ASOCIADA AL EMBARAZO
2686	668135	PARAINFLUENZA I, Ac. IgG ANTI
2687	668137	PARAINFLUENZA I, Ac. IgM ANTI
2688	668139	PARAINFLUENZA I, ANTIGENO (Ag.)
2689	668146	PARAINFLUENZA II, ANTIGENO (Ag.)
2690	668149	PARAINFLUENZA III, Ac. IgG ANTI
2691	668151	PARAINFLUENZA III, Ac. IgM ANTI
2692	668153	PARAINFLUENZA III, ANTIGENO (Ag.)
2693	660739	PARATHORMONA - PTH (MOLECULA BIOINTACTA)
2694	668178	PAROTIDITIS, Ac. IgG ANTI
2695	668187	PAROTIDITIS, Ac. IgM ANTI
2696	668241	PARVOVIRUS B19 - PCR
2697	668229	PARVOVIRUS B19, Ac. IgG ANTI
2698	668238	PARVOVIRUS B19, Ac. IgM ANTI
2699	668281	PEPTIDO C
2700	668281A	PEPTIDO C URINARIO
2701	668284	PEPTIDO CITRULINADO CICLICO, Ac. IgG ANTI
2702	668286	PEPTIDO INTESTINAL VASOACTIVO (VIP)
2703	663094	PEPTIDO NATRIURETICO TIPO B - BNP
2704	660005B	pH EN LIQUIDO BIOLOGICO
2705	660373B	pH EN MATERIA FECAL
2706	668375	PLAQUETAS, Ac. ANTI
2707	660746	PLAQUETAS, RECUENTO DE
2708	660749	PLOMO (Pb) SERICO
2709	660749A	PLOMO (Pb) URINARIO
2710	663630	PNEUMOCYSTIS JIROVECII, DNA POR PCR (CUALITATIVO)
2711	663630A	PNEUMOCYSTIS JIROVECII, DNA POR PCR (CUANTITATIVO)
2712	668463	POLIOMAVIRUS BK, CARGA VIRAL
2713	668464	POLIOMAVIRUS BK, PCR CUALITATIVA
2714	660275P	POSACONAZOL, DOSAJE DE
2715	668546	PREALBUMINA
2716	002331	PREECLAMPSIA, INDICE PREDICTOR sFlt-1/PlGF
2717	668563	PROCALCITONINA
2718	660758	PROGESTERONA
2719	660759	PROLACTINA
2720	660759D	PROLACTINA, POOL DE 3 MUESTRAS
2721	660761	PROTEINA C REACTIVA ULTRASENSIBLE - PCR
2722	668614	PROTEINA C, ACTIVIDAD FUNCIONAL
2723	669120	PROTEINA TRANSPORTADORA 3 DEL IGF - IGFBP-3
2724	660764A	PROTEINAS FRACCIONADAS
2725	660763	PROTEINAS TOTALES
2726	800014	PROTEINASA 3 (PR3), Ac. ANTI
2727	660923	PROTEINOGRAMA ELECTROFORETICO EN ORINA (UROPROTEINOGRAMA)
2728	660764	PROTEINOGRAMA ELECTROFORETICO EN SUERO
2729	660767	PROTEINURIA
2730	660767A	PROTEINURIA EN ORINA AISLADA
2731	668691	PROTROMBINA 20.2010, MUTACION EN EL GEN
2732	000003	PRUEBA DE EJERCICIO CON ISQUEMIA EN ANTEBRAZO
2733	660801	QUIMIOTRIPSINA EN MATERIA FECAL
2734	668802	RECEPTOR TSH, Ac. ANTI (TRAb)
2735	662025	RECEPTORES ACETILCOLINA, Ac. ANTI (ACRA)
2736	000001	RECOVERINA, Ac. ANTI
2737	66813	RENINA-ANGIOTENSINA PLASMATICA
2738	668819	RENINA, ACTIVIDAD
2739	668828	RESISTENCIA A LA PROTEINA C ACTIVADA
2740	668836	RETICULINA, Ac. IgA ANTI (ARA)
2741	660818	RETICULOCITOS, RECUENTO DE
2742	668845	RETINA, Ac. ANTI
2743	668853	RI (ANNA-2), Ac. ANTI (RIBONUCLEOPROTEINAS)
2744	668907	RIBOSOMAL, Ac. ANTI-PROTEINA P (Anti-Riv P)
2745	668896	RNP, Ac. ANTI (RIBONUCLEOPROTEINAS)
2746	668905	RO, Ac. ANTI (Ro/SSA)
2747	668918	ROSA DE BENGALA
2748	660820	ROSSE-RAGAN, PRUEBA DE
2749	661145	RUBEOLA, Ac. IgG ANTI
2751	668956	SACCHAROMYSES CEREVISIAE, Ac. IgG ANTI (ASCA)
2752	5290	SANGRE OCULTA EN MATERIA FECAL
2753	660169	SANGRIA Y HOWELL, TIEMPOS
2754	668982	SARAMPION, Ac. IgG ANTI
2755	668990	SARAMPION, Ac. IgM ANTI
2756	668999	SCLERODERMIA - SLC 70, Ac. ANTI
2757	901	SCREENING NEONATAL
2758	667775	SCREENING NEONATAL AMPLIADO - ESPECTROMETRIA MASA EN TANDEM
2759	661196A	SCREENING NEONATAL y JARABE DE ARCE
2760	669016	SELENIO SERICO
2761	669041	SEROTONINA PLAQUETARIA
2762	660835	SEROTONINA SERICA
2763	669076	SINCICIAL RESPIRATORIO, Ac. IgG ANTI
2764	669084	SINCICIAL RESPIRATORIO, Ac. IgM ANTI
2765	669093	SINCICIAL RESPIRATORIO, ANTIGENO (Ag.)
2766	669110	SM, Ac. ANTI
2767	669118D	SOMATOMEDINA C - IGF1, 120 min POST ESTIMULO
2768	669118A	SOMATOMEDINA C - IGF1, 30 min POST ESTIMULO
2769	669118B	SOMATOMEDINA C - IGF1, 60 min POST ESTIMULO
2770	669118C	SOMATOMEDINA C - IGF1, 90 min POST ESTIMULO
2771	669118	SOMATOMEDINA C - IGFB1
2772	660841	SOMATOTROFINA (STH)
2773	660841D	SOMATOTROFINA (STH), 120 min POST ESTIMULO
2774	660841E	SOMATOTROFINA (STH), 180 min POST ESTIMULO
2775	660841A	SOMATOTROFINA (STH), 30 min POST ESTIMULO
2776	660841B	SOMATOTROFINA (STH), 60 min POST ESTIMULO
2777	660841C	SOMATOTROFINA (STH), 90 min POST ESTIMULO
2778	661175	SUBUNIDAD BETA DE hCG
2779	661170	SUBUNIDAD BETA DE hCG, TEST RAPIDO
2780	661170A	SUBUNIDAD BETA DE hCG, TEST RAPIDO EN ORINA
2781	663056	SUBUNIDAD BETA LIBRE DE hCG
2782	665298	TACROLIMUS FK 506
2783	669637C	TCF3-HLF - DETECCIÓN MOLECULAR DEL TRANSCRIPTO DE FUSIÓN
2784	666614A	TEST DE TRANSFORMACION BLASTICA
2785	660863	TESTOSTERONA (To)
2786	661185	TESTOSTERONA BIODISPONIBLE
2787	669366	TESTOSTERONA DIHIDRO (DHT)
2788	669375	TESTOSTERONA LIBRE (To-L)
2789	660771	TIEMPO DE PROTROMBINA
2790	660880	TIEMPO DE TROMBINA
2791	669443	TIROGLOBULINA (TGs)
2792	669464	TIROGLOBULINA EN ASPIRADO DE NODULO
2793	669460	TIROGLOBULINA, Ac. ANTI (ATG)
2794	669477	TIROSINA
2795	660865	TIROTROFINA - TSH
2796	660865E	TIROTROFINA, 30 min POST TRH
2797	660865G	TIROTROFINA, 60 min POST TRH
2798	660867	TIROXINA LIBRE - T4L
2799	660866	TIROXINA TOTAL - T4
2800	TDM	TOMA DE MUESTRA
2801	669490	TOPIRAMATO, MONITOREO de FARMACOS para ENF. CRONICAS
2802	669511	TOXOCARA CANIS, Ac. IgG ANTI
2803	669514	TOXOCARA CANIS, Ac. IgM ANTI
2804	669538	TOXOIDE TETANICO, Ac. ANTI (POST-VACUNACION)
2805	669561	TOXOPLASMOSIS, Ac. IgA ANTI
2806	1057A	TOXOPLASMOSIS, Ac. IgG ANTI
2807	669575	TOXOPLASMOSIS, Ac. IgG ANTI- (TEST DE AVIDEZ)
2808	1056A	TOXOPLASMOSIS, Ac. IgM ANTI
2809	663996	TP, CORRECCION CON PLASMA NORMAL
2810	660873	TRANSAMINASA GLUTAMICO OXALACETICA (GOT/AST)
2811	660874	TRANSAMINASA GLUTAMICO PIRUVICA (GPT/AGT)
2812	660875	TRANSFERRINA
2813	660875A	TRANSFERRINA, CAPACIDAD DE SATURACION (SIDEROFILINA)
2814	669622	TRANSGLUTAMINASA, Ac. IgA ANTI
2815	669631	TRANSGLUTAMINASA, Ac. IgG ANTI
2816	669637D	TRANSLOCACION (12;21) TEL-AML1 (ETV6-RUNX1)
2817	669642A	TRANSLOCACION (15;17) - GEN DE FUSION PML-RAR alfa
2818	669637E	TRANSLOCACION (4;11) - MLL/AF4
2819	660933	TREPONEMA PALLIDUM, Ac. ANTI (SIFILIS)
2820	669644A	TREPONEMA PALLIDUM, FTA ABS, Ac. IgM ANTI
2821	669647	TRICHINELLA SPIRALIS, Ac. IgG ANTI
2822	669649	TRICHINELLA SPIRALIS, Ac. IgM ANTI
2823	669653A	TRICHOMONAS VAGINALIS - DNA POR PCR
2824	660876	TRIGLICERIDOS
2825	669661	TRIIODOTIRONINA LIBRE - T3L
2826	660878	TRIIODOTIRONINA TOTAL - T3
2827	667777	TRIPSINA INMUNOREACTIVA (TIR), NEONATAL
2828	669735	TROPONINA I - TnI
2829	69759	UREA EN LIQUIDO BIOLOGICO
2830	660902B	UREA EN ORINA AISLADA
2831	660902A	UREA EN ORINA DE 24h
2832	660902	UREA SERICA
2833	660902P	UREA SERICA PRE y POST DIALISIS
2834	660901	UREA, CLEARENCE DE
2835	660904	URICEMIA
2836	660905	URICOSURIA
2837	1229	V.D.R.L. CUANTITATIVA en LCR
2838	660934	V.D.R.L. CUANTITATIVA en SUERO
2839	669793	VANCOMICINA
2840	669834	VARICELA ZOSTER - DNA (PCR)
2841	669834A	VARICELA ZOSTER - DNA (PCR) EN LCR
2842	669819	VARICELA ZOSTER, Ac. IgG ANTI
2843	669810	VARICELA ZOSTER, Ac. IgM ANTI
2844	669093A	VIRUS SINCICIAL RESPIRATORIO - PCR
2845	660937	VITAMINA A - RETINOL
2846	669879	VITAMINA B1 - TIAMINA
2847	660938	VITAMINA B12
2848	669887	VITAMINA B6 - PIRIDOXINA
2849	660060	VITAMINA C - ACIDO ASCORBICO
2850	669905	VITAMINA D3 (25-HIDROXICALCIFEROL)
2851	660939	VITAMINA E - ALFA TOCOFEROL
2852	002387	VORICONAZOL
2853	660953	WIDAL, REACCION DE
2854	660982	ZINC SERICO
2855	661030A	CITOMEGALOVIRUS, Ac. IgM ANTI
2856	660739A	PARATHORMONA INTRAOPERATORIA (BASAL)
2857	660739B	PARATHORMONA INTRAOPERATORIA (MOVILIZACION)
2858	660739C	PARATHORMONA INTRAOPERATORIA (POST-EXCERESIS)
2859	669634	BCR/ABL p190 y p210 CUALITATIVA - TRANSLOCACION BCR/ABL
2860	663538D	CD20, SUBPOBLACION LINFOCITARIA
2861	669650A	CEBPA, MUTACIONES - DETECCION MOLECULAR
2862	667019	CORE BINDING FACTOR - INVERSION CROMOSOMA 16 - MYH11
2863	664144	DELECION 17 P53 (FISH) - ALTERACIONES del CROMOSOMA
2864	669637A	RUNX1 - RUNX1T1 (AML1/ETO) - DETECCION MOLECULAR
2865	669638A	TRANSLOCACION (8;21) AML1-ETO
2866	662815	APOLIPOPROTEINA E, GENOTIPO (Apo E)
2867	380001	IgE RAST - ABEJA (APIS MELLIFEN)
2868	380003	IgE RAST - ALFA LACTOALBUMINA
2869	380026	IgE RAST - AVISPA (VESPULA SPECIES)
2870	380025	IgE RAST - BETA LACTOGLOBULINA
2871	380027	IgE RAST - BLOMIA TROPICALIS
2872	380042	IgE RAST - CASEINA
2873	380073	IgE RAST - HORMIGA COLORADA (SOLENOPSIS INVICTA)
2874	380135	IgE RAST - POLVO DOMESTICO
2875	380145	IgE RAST - TRIGO
2876	380072	IgE RAST - HONGOS Y MOHO - PANEL
2877	660615	LIPIDOGRAMA ELECTOFORETICO
2878	669896B	VITAMINA C - ACIDO ASCORBICO
2879	669869	VITAMINA C - ACIDO ASCORBICO
2880	667751	17-HIDROXIPROGESTERONA NEONATAL
2881	663717	CITOMEGALOVIRUS, ANTIGENEMIA (CMV - PP65)
2882	664093	COXSACKIE VIRUS B (1-2-3-4-5-6), Ac. IgG ANTI
2883	667010	LEPTOSPIRA, Ac. ANTI
2884	667947	OVARIO, Ac. ANTI
2885	664623A	PANEL ENA POSITIVO
2886	662751A	PANEL RESPIRATORIO EXTENDIDO POR PCR
2887	662745B	PANEL RESPIRATORIO VIRAL POR PCR
2888	660186	COOMBS INDIRECTA - PANEL CELULAR
2889	000614	HEMOTIPIFICACION COMPLETA (GRUPO Y FACTOR SANGUINEO)
2890	660184	COOMBS DIRECTA POLIESPECÍFICA, PRUEBA DE
2891	665725A	HANTA VIRUS - PCR (CUALITATIVA)
2892	666999	LEPTOSPIROSIS, Ac. ANTI (TR)
2893	667007	LEPTOSPIROSIS, Ac. IgM ANTI (ELISA)
2894	001686	FIEBRE HEMORRAGICA ARGENTINA - PCR
2895	009625	LEPTOSPIRA - PCR (CUALITATIVA)
2896	665725	HANTA VIRUS, Ac. IgG-IgM ANTI
2897	664370	DENGUE - SEROTIPIFICACION (PCR)
2898	665077	FACTOR DE COAGULACION XIII
2899	665059	FACTOR DE COAGULACIÓN II
2900	660334	FACTOR DE COAGULACION IX
2901	660331	FACTOR DE COAGULACION V
2902	660332	FACTOR DE COAGULACION VII
2903	665119	FACTOR VON WILLEBRAND- INMUNOLOGICO
2904	665067	FACTOR DE COAGULACION XI
2905	660335	FACTOR DE COAGULACION X
2906	660333	FACTOR DE COAGULACION VIII
2907	669486	INHIBIDOR DEL FACTOR VIII
2908	668640	PROTEINA S TOTAL
2909	668631	PROTEINA S LIBRE
2910	663905	COFACTOR DE RISTOCETINA
2911	663722D	CITOMEGALOVIRUS - SCREENING NEONATAL
2912	666725B	INFLUENZA A + B, DETECCIÓN POR PCR
2913	662749A	PANEL RESPIRATORIO VIRAL - PCR
2914	662749	PANEL RESPIRATORIO VIRAL AMPLIADO - PCR
2915	662749B	PARAINFLUENZA VIRUS 1-4 - PCR
2916	664264	CRYPTOCOCCUS NEOFORMANS, ANTIGENO
2917	665508A	GALACTOMANANO de ASPERGILLUS, Ag. - LATERAL FLOW
2918	665508B	GALACTOMANANO de ASPERGILLUS, Ag. - ELISA
\.


--
-- Data for Name: estudio_colega; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.estudio_colega (id, nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, id_preanalitico, id_muestra, id_sector_laboratorio, indicaciones_pacientes, valor_referencia, dias_demora, estado, codigo_laboratorio, version, revisor, observacion, created_at, updated_at, colega_id, indicaciones_colega) FROM stdin;
2235	ACLAC	listo	2206	533	\N	506	1787	\N	5.0 a 13.0 mg/dl	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2236	AC.BILIA	listo	2215	534	\N	507	1773	https://drive.google.com/file/d/1_fgh3wB_sUlK5aSYSdsQqZMjH6EhKY6u/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2237	ADD	listo	2220	535	76	508	1677	https://drive.google.com/file/d/1Y9at0TssujE3q5aoBi4-RCBvnPp44SK4/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2238	ALB	listo	2231	536	\N	507	1728	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2239	AFP	listo	2238	532	\N	507	1874	\N	0.89 a 8.78 ng/ml	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2240	AMLB	listo	2240	534	77	509	1706	https://drive.google.com/file/d/1CIlWvMYcwxaOHsr9qB5dInn5fMkODVH1/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2241	AM	listo	2241	534	\N	507	1705	\N	📋	1	listo	\N	1	Laboratorio SBLab	Se modifico el nombre desde AMILASEMIA	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2242	AMONIO	listo	2244	537	\N	510	1788	\N	18.00 a 72.00 μmol/l	1	listo	\N	1	Laboratorio SBLab	Se modifico el nombre desde AMONIO	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2243	LUPICO	listo	2246	538	\N	511	1634	https://drive.google.com/file/d/1s3JWP4brFW_na98PqGgNTvkodNt0EtqW/view?usp=sharing	Ver MODELO DE INFORME	2	listo	\N	1	Laboratorio SBLab	17/07/2026 Se modifican valores de referencia de KPTT.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2244	ASO	listo	2248	539	\N	512	1743	\N	0 a 200 UI/ml	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2245	AEP-NBU	listo	2249	532	\N	512	1881	ANTIGENO PROSTATICO ESPECÍFICO - PSA\nNo mantener relaciones sexuales 48 horas antes del análisis.\nNo realizar ejercicios físicos ni andar en bicicleta 48 horas antes del análisis.\nCenar de manera habitual y contar las horas de ayuno a partir de finalizada la cena.\nConcurrir al laboratorio con un período de ayuno de 8 horas y no más de 14 horas.\nNo fumar, ni beber café, té o mate . Puede beber agua durante el ayuno.\nInformar el nombre de los medicamentos que recibe.\nNOTA : \n1) si se ha realizado un tacto rectal, esperar 1 semana para realizar el análisis.\n2) se se ha realizado una biopsia rectal, cirugía de próstata o\ninfección urinaria, espere de 3 a 6 semanas para realizar el análisis.	0.00 a 4.00 ng/ml	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2246	AEP	listo	2250	532	\N	512	1882	ANTIGENO PROSTATICO ESPECÍFICO - PSA\nNo mantener relaciones sexuales 48 horas antes del análisis.\nNo realizar ejercicios físicos ni andar en bicicleta 48 horas antes del análisis.\nCenar de manera habitual y contar las horas de ayuno a partir de finalizada la cena.\nConcurrir al laboratorio con un período de ayuno de 8 horas y no más de 14 horas.\nNo fumar, ni beber café, té o mate . Puede beber agua durante el ayuno.\nInformar el nombre de los medicamentos que recibe.\nNOTA : \n1) si se ha realizado un tacto rectal, esperar 1 semana para realizar el análisis.\n2) se se ha realizado una biopsia rectal, cirugía de próstata o\ninfección urinaria, espere de 3 a 6 semanas para realizar el análisis.	0.00 a 4.00 ng/ml	1	listo	\N	1	Laboratorio SBLab	No figura para los derivantes (duplicado en Datatech).	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2247	AEP-LNBU	listo	2251	532	\N	512	1884	https://drive.google.com/file/d/1wbP3sXx5PQk4Dcrrdj8GFXFq3Cq4kd3f/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	No figura para los derivantes (duplicado en Datatech). Evaluar el informe de la relacion Libre/Total. En otros sitiso se informa como porcentaje.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2248	AEPL	listo	2252	532	\N	512	1883	https://drive.google.com/file/d/1wbP3sXx5PQk4Dcrrdj8GFXFq3Cq4kd3f/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	Evaluar el informe de la relacion Libre/Total. En otros sitios se informa como porcentaje.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2249	ATIII	listo	2256	540	\N	513	1637	\N	79.4 a 112.0 %	2	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2250	APOA	listo	2257	541	\N	507	1722	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2251	APOB	listo	2258	541	\N	507	1723	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2252	ATPO	listo	2262	532	\N	507	1805	\N	0.00 a 5.61 UI/ml	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2253	BETA-2	listo	2270	541	\N	507	1746	\N	0.97 a 2.64 mg/l	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2254	BICAR/SU	listo	2273	542	\N	506	1784	\N	21 a 24 mmol/l	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2255	BT	listo	2275	543	\N	507	1699	https://drive.google.com/file/d/1NJ5LBgTBvcKueuoC9jF6dYuzzSTMLIKl/view?usp=sharing	📋	1	listo	\N	1	Laboratorio SBLab	Se modifico el nombre desde BILIRRUBINA TOTAL Y FRACCIONADA	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2256	CA-125	listo	2291	532	\N	507	1879	\N	0 a 35 U/ml	1	listo	\N	1	Laboratorio SBLab	Se modifico el nombre desde CA-125	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2257	CA15-3NB	listo	2292	532	\N	507	1875	\N	0.0 a 31.3 U/ml	1	listo	\N	1	Laboratorio SBLab	Se modifico el nombre desde CA 15-3	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2258	CA19-9	listo	2294	532	\N	507	1876	\N	0 a 37 U/ml	1	listo	\N	1	Laboratorio SBLab	Se modifico el nombre desde CA 19-9	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2259	CA19-9NB	listo	2293	532	\N	507	1877	\N	0 a 37 U/ml	1	listo	\N	1	Laboratorio SBLab	No figura para los derivantes (duplicado en Datatech). Se modifico el nombre desde CA 19-9	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2260	CAO1	listo	2301	544	\N	514	1682	\N	-	1	listo	\N	1	Laboratorio SBLab	Establecer valores de referencia en base a la bibliografia	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2261	CAI	listo	2302	545	\N	506	1681	\N	4.52 a 5.20 mg/dl	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2262	CA	listo	2303	544	\N	507	1680	\N	📋	1	listo	\N	1	Laboratorio SBLab	Se modifico el nombre desde CALCEMIA	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2263	CAO	listo	2304	544	78	515	1683	https://drive.google.com/file/d/1E7RcRxnHkK34XDTA-S-NOTlpZ_38yj5z/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	Se modifico el nombre desde CALCIURIA	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2264	CAUR	listo	2307	546	\N	516	1766	https://drive.google.com/file/d/1KtQQDApGy2yvlhyiBvhI3HQ58AVVVPCI/view?usp=sharing	-	8	listo	\N	1	Laboratorio SBLab	Se modifico el nombre desde CALCULO URINARIO	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2265	CARBO	listo	2310	547	\N	506	1785	\N	0 a 3 %	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2266	CEA	listo	2330	532	\N	507	1873	\N	0 a 5 ng/ml	1	listo	\N	1	Laboratorio SBLab	Se modifico el nombre desde CEA - ANTIGENO CARCINO EMBRIONARIO	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2267	CERU	listo	2333	548	\N	512	1774	\N	19 a 57 mg/dl	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2268	CETONE	listo	2334	549	\N	506	\N	\N	NEGATIVO	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2269	CETONU	listo	2335	549	\N	517	\N	\N	NO CONTIENE	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2270	CHAEIA	listo	2336	532	\N	507	1910	https://drive.google.com/file/d/1Anv0c1aA0e9sDVKhkj8EuNuohckvmWek/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	Se modifico el nombre desde CHAGAS-TRYPANOSOMA CRUZI (EIA)	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2271	CHAHAI	listo	2337	550	\N	512	1909	https://drive.google.com/file/d/16PvoRRhcd4w3nX1AN09RUxkFhXHuYN0a/view?usp=sharing	Ver MODELO DE INFORME	2	listo	\N	1	Laboratorio SBLab	Se modifico el nombre desde CHAGAS-TRYPANOSOMA CRUZI (EIA)	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2272	ACITOG	listo	2355	532	\N	507	1929	https://drive.google.com/file/d/1P5AeTe0g9RS0U3s8w6ZBpKT1pdQBphCA/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	En Hexalis se informa Interpretacion y Concentración. En Datatech solo Concentración.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2273	ACITOM-N	listo	2356	532	\N	507	1928	https://drive.google.com/file/d/12-IFjKmCB65oKUHNiQi1Q6Ot-xz7p098/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2274	ACITOM	listo	2855	532	\N	507	\N	https://drive.google.com/file/d/12-IFjKmCB65oKUHNiQi1Q6Ot-xz7p098/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	No figura para los derivantes (duplicado en Datatech).	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2275	RCO	listo	2364	\N	\N	518	1632	\N	NORMORRETRACTIL	2	listo	\N	1	Laboratorio SBLab	No figura para los derivantes (requiere procesamiento inmediato).	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2276	COAGU	listo	2365	538	79	519	1630	https://drive.google.com/file/d/15sE1OBVpUJ06b6KpehEYHaMl9214saEJ/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2277	HDL	listo	2367	551	\N	507	1716	https://drive.google.com/file/d/1RcywhFFAo5h0agQwWhHvEgdjj7NhkBHm/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2278	LDL	listo	2368	552	\N	507	1717	\N	0 a 100 mg/dl	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2279	C	listo	2369	553	\N	507	1715	\N	📋	1	listo	\N	1	Laboratorio SBLab	Se modifico el nombre desde COLESTEROLEMIA TOTAL	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2280	VLDL	listo	2371	554	\N	507	1719	\N	0 a 30 mg/dl	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2281	VLDL-NBU	listo	2370	554	\N	507	1720	\N	0 a 30 mg/dl	1	listo	\N	1	Laboratorio SBLab	No figura para los derivantes (duplicado en Datatech).	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2282	LDL-NBU	listo	2372	552	\N	507	1718	\N	0 a 100 mg/dl	1	listo	\N	1	Laboratorio SBLab	No figura para los derivantes (duplicado en Datatech).	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2283	CHE	listo	2373	555	\N	507	1704	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2284	C3	listo	2375	541	\N	507	1740	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2285	C4	listo	2376	541	\N	507	1741	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2286	TH50	listo	2377	556	\N	507	1742	\N	128 a 158 seg	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2287	COR	listo	2379	532	\N	507	1822	\N	3.7 a 19.4 µg/dl	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2288	COR-18	listo	2380	532	\N	507	\N	https://drive.google.com/file/d/1C9Mdn_3B1okuO8KtuDyARjrlAcBnbdEJ/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2289	COR-ES	listo	2387	532	\N	520	\N	\N	-	1	listo	\N	1	Hematologia SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2290	CPK	listo	2389	557	\N	507	1708	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2291	CKMBMASA	listo	2390	532	\N	507	1709	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2292	CRLB	listo	2391	558	77	521	1672	https://drive.google.com/file/d/10l4hwsn6cBMRcUv1iiWamiDauKb8iocX/view?usp=sharing	-	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2293	CRO1	listo	2392	558	\N	517	1673	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2294	CR	listo	2393	558	\N	507	1671	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2295	CRO	listo	2394	558	78	522	1674	https://drive.google.com/file/d/1kBfSsE1FL_tMffhZ7w8L_KaeazPq9E2Q/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2296	DCE	listo	2395	558	80	523	1675	https://drive.google.com/file/d/133MWK_W40_oxz70RYPvSoOg1a9dRvKib/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2297	CRIO	listo	2396	\N	\N	524	1622	\N	NO PRESENTA	2	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2298	CRIOGLO	listo	2397	\N	\N	512	1621	\N	NEGATIVO	2	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2299	DHEA	listo	2403	532	\N	507	1844	\N	📋	1	listo	\N	1	Laboratorio SBLab	Se modifico el nombre desde DHEA-S	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2300	TD-DIF	listo	2404	532	\N	507	2094	\N	10.00 a 20.00  µg/ml	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2301	DIMERO D	listo	2406	559	\N	513	1714	\N	0 a 198 ng/ml	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2302	DROGAS	listo	2411	560	\N	525	2105	https://drive.google.com/file/d/1HIFLcqA7ZS2AwIygOePTRhB2JBMjDSi3/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2303	AE-B	listo	2425	532	\N	507	1947	https://drive.google.com/file/d/12gQ2J6RWc4AHQowbxyRQ27wldHEH4qOH/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2304	AEBCM	listo	2426	532	\N	507	1946	https://drive.google.com/file/d/1IKmwTJoWbPgOTiOpJpPAFh-ArpZ_80K5/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	En Hexalis se informa Interpretacion y Relacion S/CO. En Datatech solo Resultado	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2305	E	listo	2430	561	\N	526	1623	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2306	EAB	listo	2432	562	\N	506	1781	https://drive.google.com/file/d/1I3cs6WMMnXiTmW5EG_6zwB4k8pcny9Wn/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2307	EABI	listo	2433	562	\N	506	1782	https://drive.google.com/file/d/1j5Vy-2v5Sh1Gwj7V7_qD6VIxWraXw-xL/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2308	E2	listo	2435	532	\N	507	1834	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2309	TLE2	listo	2438	\N	\N	527	1646	https://drive.google.com/file/d/11yzPKC1UmiYWe3fkamasfS4RuB-G2801/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	Eliminar parte del texto en Datatech al cabo de 6 meses.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2310	TLE1	listo	2439	\N	\N	513	1647	https://drive.google.com/file/d/1Lj78uJcFtz8G8mCBFB1ooVPWcAEbkCpB/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	Eliminar parte del texto en Datatech al cabo de 6 meses.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2311	FR	listo	2442	541	\N	512	1744	\N	0 a 30 UI/ml	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2312	FE	listo	2448	563	\N	507	1756	https://drive.google.com/file/d/1TxS3CEfcOQKu34F0s0wllMYCow3HQoSN/view?usp=sharing	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2313	FERR	listo	2449	532	\N	507	1759	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2314	FIB	listo	2450	564	\N	513	1628	\N	180 a 350 mg/dl	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2315	FLA	listo	2452	565	\N	528	1618	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2316	FOH	listo	2454	566	\N	507	1698	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2317	P	listo	2455	567	\N	507	1684	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2318	PO	listo	2457	567	78	522	1686	https://drive.google.com/file/d/1snXSxwexxyHwpRjtD8iuAcn9SRIeAIMu/view?usp=sharing	400 a 1300 mg/24h	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2319	PO1	listo	2458	567	\N	529	1687	\N	-	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2320	RTP	listo	2461	568	78	530	1685	https://drive.google.com/file/d/1YP-R9lXPxtnksW2HdpWPdpv4cSjDO2hq/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2321	FRUCTO	listo	2462	569	\N	507	1661	\N	205 a 285 ng/ml	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2322	FSH	listo	2463	532	\N	507	1832	https://drive.google.com/file/d/1i7xsbAK__EBb6O9DNsBCKqftBpNs_-Jq/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2323	GGT	listo	2468	570	\N	507	1701	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2324	GLOBTRAN	listo	2475	532	\N	507	1849	\N	📋	1	listo	\N	1	Laboratorio SBLab	Se modifico el nombre desde GLOBULINA TRANSPORTADORA DE HORMONAS SEXUALES	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2325	GB	listo	2476	565	\N	528	1617	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2326	GR	listo	2477	565	\N	528	1615	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2327	G	listo	2478	571	\N	507	1652	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2328	GCIR	listo	2479	572	\N	531	1653	\N	-	1	listo	\N	1	Laboratorio SBLab	No figura para los derivantes (requiere procesamiento inmediato).	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2329	GPP	listo	2480	571	\N	532	1657	\N	0 a 140 mg/dl	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2330	GP120MIN	listo	2481	571	\N	532	1658	\N	0 a 140 mg/dl	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2331	GP180MIN	listo	2482	571	\N	533	1659	\N	-	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2332	GP 30MIN	listo	2483	571	\N	534	1654	\N	-	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2333	GP 60MIN	listo	2484	571	\N	535	1655	\N	-	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2334	GP 90MIN	listo	2485	571	\N	536	1656	\N	-	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2335	GLU	listo	2487	571	\N	529	1660	\N	1 a 15 mg/dl	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2336	HAM	listo	2490	535	\N	537	\N	https://drive.google.com/file/d/1efXWRupcji4zGH65b27PRBeqFA28fZ8C/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	Revisar las unidades en Datatech y copiarlas en Hexalis	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2337	HAP	listo	2491	541	\N	507	1703	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2338	HE4	listo	2492	532	\N	512	1886	https://drive.google.com/file/d/1m-m1dREcdk96qMoioNp4GME9_Z-mOmOE/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2339	HU	listo	2496	573	\N	538	2179	https://drive.google.com/file/d/1rANbZ7_u-GAF0Bi1PEqjAenMtK5nT5Cx/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2340	HTO	listo	2497	565	\N	528	1614	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2341	HGL1	listo	2499	554	\N	526	1662	\N	4.0 a 5.7 %	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2342	HB	listo	2500	565	\N	528	1616	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2343	HC	listo	2501	565	\N	528	1613	https://drive.google.com/file/d/1VMpjj-wL2VHNlZnIqtlZMGCNOOnzAwKs/view?usp=sharing	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2344	HS	listo	2502	565	\N	528	1612	https://drive.google.com/file/d/1gtL0udDrx2b7RwUMM59fkn3UtqP_wiBq/view?usp=sharing	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2345	HEP	listo	2503	574	\N	539	1638	https://drive.google.com/file/d/12vuyipyf9oCk0ziTxGPmPtAn7igeRujz/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2346	HEPAG	listo	2504	532	\N	507	1918	https://drive.google.com/file/d/1pVj6H1sIMweJvlLPKtpzeNpH1wDpWbcr/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	El analisis solo tiene una determinacion RESULTADO CUALITATIVO, no se informa el INDEX	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2347	HEPAM	listo	2505	532	\N	507	1917	https://drive.google.com/file/d/1ov5UWKpqQ6u3SkLzPbNSaz7WKsW8WwLI/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	Se informa el RESULTADO CUALITATIVO y el INDEX	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2348	HEPBCM	listo	2506	532	\N	512	1921	https://drive.google.com/file/d/1uw6stTy--duuNoz_zWB6hjjK5ypq3qIm/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	Se incorpora la determinacion localmente.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2349	HEPBCTO	listo	2507	532	\N	507	1920	https://drive.google.com/file/d/1D3adyTg_VKGTjr6au_PWdHfjCL1metMm/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2350	HEPBSAC	listo	2509	532	\N	507	1923	https://drive.google.com/file/d/1QEygc_AnZknvDrRseqonSmIwJzQEZneS/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2351	HEPBSAG	listo	2512	532	\N	507	1919	https://drive.google.com/file/d/1SsBGibnTBBmbkprNbMvhl-tXe4los_jD/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2352	HEPCAC	listo	2515	532	\N	507	1927	https://drive.google.com/file/d/1eRoUvhO8JEsXMs7cNCG69JN_ZYl7Gxts/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2353	HEC1	listo	2521	575	\N	507	1700	https://drive.google.com/file/d/1UxZ_Hm154sUZt-hepXw9mmUu2-Qbj6gG/view?usp=sharing	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2354	HERP1G	listo	2524	532	\N	507	1934	https://drive.google.com/file/d/1eBwCpR6V8naWlof0pKzk1qoZXYc4u3ex/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2355	HERP2G	listo	2526	532	\N	507	1936	https://drive.google.com/file/d/13QpqR-LssNJLYfMFoDz0tYRsNa9cNU5a/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2356	HIVEIA	listo	2541	532	\N	507	1915	https://drive.google.com/file/d/1k4uDLoJD6R8FfpVYHBa1_kJXQ9JaXD9l/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2357	TEST-HIV	listo	2542	576	\N	512	1916	https://drive.google.com/file/d/1nvDXnCSvNsq1Wtulr2RlKEgBV2rduY0Y/view?usp=sharing	NO REACTIVO	1	listo	\N	1	Laboratorio SBLab	Deberia incluir un comentario con las limitaciones del test.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2358	HOMA	listo	2547	\N	\N	507	1814	https://drive.google.com/file/d/1Ob47ohqbGYgbbRT1iddj1SJagTp906X_/view?usp=sharing	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2359	HOMOC	listo	2548	532	\N	540	1726	https://drive.google.com/file/d/1WpvI6HK9IjMZl5EKXsUXERpIldhGv_Gs/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2360	HTLV I	listo	2550	532	\N	507	2007	https://drive.google.com/file/d/19z4ORDDhR2hZkZ6wvbcVsBVNO24K9YSC/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	En Datatech solo tiene la relacion S/CO, habria que incorporar la determinacion de interpretacion.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2361	HUD	listo	2552	577	\N	512	1896	https://drive.google.com/file/d/1wXsS4_Gpad3au4wfNXYBY5lqaX7FUx62/view?usp=sharing	Ver MODELO DE INFORME	2	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2362	IGA	listo	2590	541	\N	507	1730	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2363	IGAS	listo	2591	578	\N	541	1731	\N	📋	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2364	IGE	listo	2593	579	\N	507	1736	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2365	IGG	listo	2594	541	\N	507	1733	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2366	IGM	listo	2597	541	\N	507	1732	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2367	INS	listo	2598	532	\N	507	1807	\N	2.6 a 24.9 µmol/l	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2368	INSPP	listo	2599	532	\N	532	1811	\N	\N	1	listo	\N	1	Laboratorio SBLab	No tiene valores de referencia en Datatech	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2369	INSPP120	listo	2600	532	\N	532	1812	\N	\N	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2370	INSPP180	listo	2601	532	\N	533	1813	\N	-	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2371	INS PP30	listo	2602	532	\N	534	1808	\N	-	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2372	INS PP60	listo	2603	532	\N	535	1809	\N	-	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2373	INS PP90	listo	2604	532	\N	536	1810	\N	-	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2374	I/OA	listo	2610	580	\N	529	1692	https://drive.google.com/file/d/1C7spFtUzRHOKwWeB9FWh8x44zSM7-89Y/view?usp=sharing	-	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2375	I	listo	2611	580	\N	507	1690	https://drive.google.com/file/d/1Q8nfzOWCFdSOCKKDJ1zNhoATb_n74-kX/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2376	IOO	listo	2612	580	\N	542	1691	https://drive.google.com/file/d/1T6q-r2LD2QhEAwz2cBIWh6pyiOeJwct8/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2377	KPTT	listo	2618	538	\N	513	1626	\N	20.2 a 29.5 seg	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2378	CORRKPTT	listo	2619	538	\N	543	1627	https://drive.google.com/file/d/1Vs22PSGPgtAjTqlfmCa03t0llxLaYrrS/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2379	LDH	listo	2621	581	\N	507	1702	\N	125 a 220 U/l	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2380	LAZO	listo	2623	582	\N	\N	1633	\N	Hasta 5 petequias	1	listo	\N	1	Laboratorio SBLab	No figura para los derivantes (requiere procesamiento local).	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2381	LEUCMF	listo	2625	573	\N	544	2169	\N	NO CONTIENE	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2382	LH	listo	2627	532	\N	507	1833	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2383	LIP	listo	2628	534	\N	507	1707	\N	0 a 64 U/l	1	listo	\N	1	Laboratorio SBLab	05/05/2025 Cambio en valores de referencia de 8 a 78 U/l a 0 a 64 U/l	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2384	LIPO	listo	2629	583	\N	507	1724	\N	0 a 30 µmol/l	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2385	L.C.R.	listo	2630	\N	\N	545	1791	https://drive.google.com/file/d/1nmnp5U1m4LC9Q-XVZ-txYz98olwKTmkb/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2386	PUNCION	listo	2631	\N	81	546	1790	https://drive.google.com/file/d/14XVx1fdTlfZW_bFGtcHMUppvI6LtXo2-/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2387	MGS	listo	2636	554	\N	507	1688	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2388	MGO	listo	2637	554	82	542	1689	https://drive.google.com/file/d/18pdNrcxxVmjgg67MpPpeI25h6swkE0ZK/view?usp=sharing	72.9 a 121.5 mg/24h	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2389	PPD	listo	2639	584	\N	\N	1898	https://drive.google.com/file/d/1dUIGvAX7ZwL3rAQo2a4cNhRKNBCZ5rgF/view?usp=sharing	Ver MODELO DE INFORME	4	listo	\N	1	Laboratorio SBLab	No figura para los derivantes (requiere procesamiento local). No tiene valores de referencia en Datatech. Poner nota del estilo El test de tuberculina tiene diferente valor, de acuerdo al paciente en el cual sea aplicado, y los valores decorte deben ser tenidos en mente antes de solicitar el mismo (test de tuberculina dirigido)	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2390	MDRD-4	listo	2641	585	\N	507	\N	https://drive.google.com/file/d/1YVQvYKqMiNtSdELfFZ6U_IdD_Ubn2-ef/view?usp=sharing	MAYOR A 60 ml/min/1.73m2	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2391	META	listo	2644	562	\N	506	1786	\N	0.0 a 1.5 %	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2392	METO	listo	2649	532	83	547	2103	https://drive.google.com/file/d/1Vn3GBNGB1ipFpKjNPS7C8FANKGh3z9Iu/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	Se modifica el codigo de 669044  a 667486 para hacerlo coincidir con el NBU	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2393	MICRO	listo	2650	541	\N	522	1664	https://drive.google.com/file/d/1bVQRly5CCKUbxmsWfJFuQ3d56QI1qtkj/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2394	A/C	listo	2651	586	\N	548	1665	https://drive.google.com/file/d/1FpRzIq1IB2L3t7Rky11ku-2Gd23p40kV/view?usp=sharing	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2395	MOC	listo	2655	573	84	549	1793	https://drive.google.com/file/d/1yx4oqxLm5yBsJ3AOUTlkae1RKso_vriA/view?usp=sharing	Ver MODELO DE INFORME	4	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2396	MON	listo	2657	577	\N	512	1899	\N	NEGATIVO	2	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2397	NOTA	listo	2672	\N	\N	\N	\N	\N	\N	1	listo	\N	1	Laboratorio SBLab	No figura para los derivantes.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2398	O	listo	2675	587	\N	550	2178	https://drive.google.com/file/d/1glSzmzj-XG7rCoQwktytYLbI64uhRcMg/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2399	OSMO/O	listo	2677	588	\N	522	1789	RECOLECCION ORINA DE 24 HORAS\n\nUtilizar recipiente limpio y seco.\n\nVaciar completamente su vejiga (orinar en el inodoro y desechar esa primera muestra) a\nlas 8 horas o la hora que elija.\n\nAnotar la hora de descarte para tomarla como hora de inicio.\n\nRecolectar todas las micciones de orina del día hasta la primera del siguiente día inclusive, que coincida con la hora de inicio dentro de un recipiente limpio de boca ancha.\n\nConservar en heladera. Y llevar al laboratorio lo antes posible. No perder ninguna muestra de orina.\n\nSi además se solicita en la misma orden médica ORINA COMPLETA, se debe recolectar la primera orina de la mañana del segundo día en un recipiente separado\ny notificar al técnico o administrativo.	50 a 1300 mOsm/kg	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2400	PTH	listo	2693	532	\N	551	1829	\N	15.0 a 68.3 pg/ml	1	listo	\N	1	Laboratorio SBLab	Etiqueta DATA: E2 EDTA(P)-PTH 20 / Etiqueta HEXA: 20- PLASMA CON EDTA	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2401	PTH-B	listo	2856	532	\N	551	\N	\N	-	1	listo	\N	1	Laboratorio SBLab	Etiqueta DATA: E56 EDTA(P)-BASAL 20 / Etiqueta HEXA: 20- PLASMA CON EDTA	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2402	PTH-M	listo	2857	532	\N	551	\N	\N	-	1	listo	\N	1	Laboratorio SBLab	Etiqueta DATA: E57 EDTA(P)-MOVIL 37 / Etiqueta HEXA: 37- PLASMA CON EDTA	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2403	PTH-PE	listo	2858	532	\N	551	\N	\N	-	1	listo	\N	1	Laboratorio SBLab	Etiqueta DATA: E58 EDTA(P)-POSTEX 38 / Etiqueta HEXA: 38- PLASMA CON EDTA	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2404	ANTI-CCP	listo	2701	532	\N	507	2041	\N	0 a 5  µmol/l	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2405	BNP	listo	2703	532	\N	552	1713	https://drive.google.com/file/d/13TlXGfuG6-iK7GwvO4MheFtL4hHJH8X0/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2406	PH LIQ	listo	2704	562	81	521	1783	https://drive.google.com/file/d/1LlxaWQQWu81qSpg4c3D4qfzqaBpt-KDJ/view?usp=sharing	-	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2407	PQ	listo	2707	565	\N	528	1619	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2408	PROCALCI	listo	2717	532	\N	507	1695	\N	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2409	PRG	listo	2718	532	\N	507	1837	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2410	PRL	listo	2719	532	\N	507	1838	PROLACTINA\nConcurrir al laboratorio entre las 8 y las 9:30 horas de la mañana, con un período de ayuno de 8 a 12 horas y con 2 horas de vigilia (despierto).\nCenar de manera habitual y contar las horas de ayuno a partir de finalizada la cena.\nNo superar las 14 horas de ayuno.\nNo realizar ejercicios físicos 24 horas antes del análisis.\nNo fumar, ni beber café, té o mate . Puede beber agua durante el ayuno.\nNo mantener relaciones sexuales 48 horas antes del análisis.\nInformar el nombre de los medicamentos que recibe.\nAntes de la extracción de sangre, deberá permanecer en el laboratorio, entre 20 y 30 minutos en reposo.\nMujeres, se aconseja realizar extracción de sangre entre el 3er y 5to día del ciclo.	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2411	POOL PRL	listo	2720	532	\N	553	1839	PROLACTINA\nConcurrir al laboratorio entre las 8 y las 9:30 horas de la mañana, con un período de ayuno de 8 a 12 horas y con 2 horas de vigilia (despierto).\nCenar de manera habitual y contar las horas de ayuno a partir de finalizada la cena.\nNo superar las 14 horas de ayuno.\nNo realizar ejercicios físicos 24 horas antes del análisis.\nNo fumar, ni beber café, té o mate . Puede beber agua durante el ayuno.\nNo mantener relaciones sexuales 48 horas antes del análisis.\nInformar el nombre de los medicamentos que recibe.\nAntes de la extracción de sangre, deberá permanecer en el laboratorio, entre 20 y 30 minutos en reposo.\nMujeres, se aconseja realizar extracción de sangre entre el 3er y 5to día del ciclo.\nSe tomarán tres muestras de sangre separadas 20 minutos entre sí.	📋	1	listo	\N	1	Laboratorio SBLab	Eliminar el texto en Datatech al cabo de 6 meses.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2412	PCR	listo	2721	541	\N	507	1694	\N	Hasta 0.5 mg/l	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2413	PC	listo	2722	589	\N	513	1635	\N	70 a 140 %	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2414	A/G	listo	2724	590	\N	507	1727	https://drive.google.com/file/d/1CI8ECRAPpxkB2IuMqvR84iPjnRpl8VR8/view?usp=sharing	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2415	PT	listo	2725	591	\N	507	1729	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2416	PTO	listo	2729	579	82	522	1752	https://drive.google.com/file/d/12-N0Mc2BHe3ZMHVbFeJmZbUXpOrHXx3Y/view?usp=sharing	0.0 a 0.3 g/24h	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2417	PRO	listo	2730	579	\N	548	1753	\N	0.00 a 0.15 g/l	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2418	FIET	listo	2732	\N	\N	\N	\N	\N	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	No figura para los derivantes (requiere procesamiento inmediato).	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2419	REC TSH	listo	2734	532	\N	512	1801	\N	0 a  1.99 µmol/l	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2420	RPCA	listo	2739	592	\N	513	\N	https://drive.google.com/file/d/1X7UJuIp8E-lf742P4fOCjysC-FQ43x-o/view?usp=sharing	Ver MODELO DE INFORME	2	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2421	RET	listo	2741	565	\N	528	1620	https://drive.google.com/file/d/1A1Rb7mhbXndUbabrRO-s90PEdD80nyDt/view?usp=sharing	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2422	RR	listo	2748	593	\N	512	1745	\N	NO REACTIVO - Título menor a 8	2	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2423	AARIGG	listo	2749	532	\N	507	1941	https://drive.google.com/file/d/1nuQ5Q5xM065QkyV369-yQl2QRM0LlvYp/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2424	AARIGM	listo	2750	532	\N	507	1940	https://drive.google.com/file/d/1mStuMTHMxpocjYK1rwkrsiOEMbnJFARH/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2425	SOMF	listo	2752	560	\N	544	2168	SANGRE OCULTA EN MATERIA FECAL\nPor Método Inmunocromatográfico\n\nMuestra :\nMateria fecal espontánea recolectada en recipiente suministrado por el\nlaboratorio. No se requiere la totalidad de la deposición, solo una porción.\nMantener en heladera hasta su  envío al laboratorio, el mismo día de la toma de muestra.	NEGATIVO	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2426	TC	listo	2753	594	85	554	1631	https://drive.google.com/file/d/1142WCrOmF-tL1IPsNEquY6wpCuFeoZsw/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2427	SUB	listo	2778	532	86	507	1853	https://drive.google.com/file/d/1JZ7qgrEhz2MtzIxOV1C4kzxnI-iCK_MY/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2428	DAP	listo	2779	595	86	507	1851	\N	NEGATIVO	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2429	GRAVI	listo	2780	595	86	529	1852	\N	NEGATIVO	1	listo	\N	1	Laboratorio SBLab	Se modifico nombre desde GRAVINDEX	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2430	TACRO	listo	2782	532	\N	528	2102	\N	\N	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2431	TES	listo	2785	532	\N	507	1845	\N	\N	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2432	TES-BIO	listo	2786	596	\N	507	1846	\N	\N	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2433	TESL	listo	2788	596	\N	507	1847	\N	\N	1	revisar	\N	1	Laboratorio SBLab	no sale valores de referencia ni modelo informe con el icono	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2434	TP	listo	2789	538	\N	513	1624	https://drive.google.com/file/d/1pkH2zjdp87rje0FORMSyhahrHGMO_qx5/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2435	TT	listo	2790	538	\N	513	1629	\N	17.4 a 26.0 s	2	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2436	TIROGLO	listo	2791	532	\N	507	1802	\N	3.68 a 64.15 µmol/l	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2437	ANTI-TG	listo	2793	532	\N	507	1804	\N	0 a 4.11 µmol/l	1	listo	\N	1	Laboratorio SBLab	Se modifico el nombre desde ANTITIROGLOBULINA	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2438	TSH	listo	2795	532	\N	507	1798	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2439	TSH30	listo	2796	532	\N	555	1799	\N	-	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2440	TSH60	listo	2797	532	\N	556	1800	\N	-	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2441	T4L	listo	2798	532	\N	507	1796	\N	\N	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2442	T4	listo	2799	532	\N	507	1797	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2443	TDM	listo	2800	\N	\N	\N	\N	\N	\N	0	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2444	TOXIGG	listo	2806	532	\N	507	1944	https://drive.google.com/file/d/1eGTcEt7YZcIfaPibCrflqmmAKl5SjZxB/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	El analisis solo tiene una determinacion en Datatech: RESULTADO CUANTITATIVO, no se informa la INTERPRETACION, deberia cambiarse agregando una determinacion	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2445	TOXIGM	listo	2808	532	\N	507	1943	https://drive.google.com/file/d/1Yaysn9mhIf8T3rhc0ixPkL7a0lXb9UTs/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	Se informa el RESULTADO CUALITATIVO y el INDEX	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2446	CORRTP	listo	2809	538	\N	543	1625	\N	\N	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2447	TGO	listo	2810	597	\N	507	1696	\N	11 a 34 U/l	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2448	TGP	listo	2811	597	\N	507	1697	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2449	TRA	listo	2812	598	\N	507	1757	https://drive.google.com/file/d/1UCVpgwIjDcfgzPglyvD2s3EcKH4US8YO/view?usp=sharing	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2450	SAT	listo	2813	599	\N	507	1758	https://drive.google.com/file/d/1v1CAjz1nf7XLSTIISNcqnxqPf5wukSl2/view?usp=sharing	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2451	SYPHILIS	listo	2819	532	\N	507	\N	https://drive.google.com/file/d/1pt3Hv0rmhwlyvqTCPUAVdhbZ9UV_XpnL/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Hematologia SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2452	TGL	listo	2824	600	\N	507	1721	\N	60 a 150 mg/dl	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2453	T3LIBRE	listo	2825	532	\N	507	1794	\N	\N	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2454	T3	listo	2826	532	\N	507	1795	\N	📋	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2455	TPA	listo	2828	532	\N	507	1712	\N	\N	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2456	UREA	listo	2829	601	77	521	1668	\N	\N	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2457	U/OA	listo	2830	601	\N	529	1669	\N	\N	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2458	UO	listo	2831	601	78	542	1670	https://drive.google.com/file/d/1BTa2xbup9_zKAjw_A-AKUqlZ5Ic4_aP0/view?usp=sharing	25.6 a 42.8 g/24h	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2459	U	listo	2832	601	\N	507	1666	\N	16.6 a 48.5 mg/dl	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2460	UES	listo	2833	601	\N	557	1667	https://drive.google.com/file/d/1sSjGQdiQooW6lftf5WL-TofbMpWYdZsY/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2461	CLU	listo	2834	601	78	523	\N	https://drive.google.com/file/d/17dno8Acpuquf29lM0_AF6Iq0p2_1TOCf/view?usp=sharing	64 a 300 ml/min	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2462	AU	listo	2835	602	\N	507	1678	\N	📋	1	listo	\N	1	Laboratorio SBLab	En NBU es URICO, ACIDO	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2463	AUO	listo	2836	602	78	542	1679	https://drive.google.com/file/d/1J-fOjb-qvr7OmJ4ueUV-Mfp28Ope00gl/view?usp=sharing	250 a 750 mg/24h	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2464	VD/LCR	listo	2837	603	\N	545	1901	\N	NO REACTIVO	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2465	VD	listo	2838	603	\N	512	1900	\N	NO REACTIVO	2	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2466	VANCO	listo	2839	532	\N	507	2088	https://drive.google.com/file/d/1T9Ij2cul_eSFTwWAVh-JppDIfwWklkXH/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	16/07/2026 Se cambia el valor de referencia teraputico por pedido del Dr. Nannini	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2467	VIT B12	listo	2847	532	\N	507	1762	\N	187 a 883 µmol/l	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2468	VIT-D3	listo	2850	532	\N	507	1770	https://drive.google.com/file/d/12vH-wU8HiZQ-ifxZTr_dNeDvmrhW0RTQ/view?usp=sharing	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2469	WID	listo	2853	577	\N	512	1897	https://drive.google.com/file/d/1hmDPFl3_McUy5vXGi5fXA8k6nbsZZdI8/view?usp=sharing	Ver MODELO DE INFORME	2	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	49	\N
2470	BCR/ABL	listo	2859	\N	\N	\N	\N	\N	\N	0	pendiente	\N	1	SIN ASIGNAR	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2471	BCR-CUAN	listo	2266	604	81	558	2157	https://drive.google.com/file/d/1rUAUFHvvE6B1h7lhyOqcqOcVG2kDnWcO/view?usp=sharing	Ver MODELO DE INFORME	16	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2472	B2GLIG	listo	2268	605	\N	559	1641	https://drive.google.com/file/d/19e2yB7gk8ZNlEsW__OeNQ-swx7AzuKzT/view?usp=sharing	Ver MODELO DE INFORME	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2473	B2GLIM	listo	2269	605	\N	559	1640	https://drive.google.com/file/d/11Fjz_EzefOG-ZihSPelYzM4o0inBKbmB/view?usp=sharing	Ver MODELO DE INFORME	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2474	BICAR/OR	listo	2274	606	\N	560	\N	\N	Menor a 30.0 nmol/l	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2475	C L SUE	listo	2297	541	\N	559	1750	https://drive.google.com/file/d/11mS9jDOUXyZlm8njK7OdjlxOsbnEAYj0/view?usp=sharing	Ver MODELO DE INFORME	3	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2476	C L OR	listo	2298	548	82	561	\N	https://drive.google.com/file/d/1k9guDnVE7bEi9-n_CSaJJmjYQ9rfwJ4z/view?usp=sharing	Ver MODELO DE INFORME	7	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2477	IGVH	listo	2300	607	\N	562	2036	https://drive.google.com/file/d/1MP5xq8W8BKQI6JTEfy3DKrAE40iV2SqL/view?usp=sharing	-	16	listo	\N	1	Laboratorio SBLab	03/08/2026 Se termina de configurar el informe con resultados de paciente.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2478	CALPRO	listo	2308	605	\N	544	2177	\N	\N	4	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2479	ACARDIGG	listo	2311	605	\N	559	1643	https://drive.google.com/file/d/1albzAEkIb8Cmmge9ODOYaFr_pLpfa241/view?usp=sharing	Ver MODELO DE INFORME	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2480	ACARDIGM	listo	2312	605	\N	559	1642	https://drive.google.com/file/d/1ZFZIUtYe9l6i53ORfRw3AB55Z93uRlKw/view?usp=sharing	Ver MODELO DE INFORME	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2481	CD3/CD16	listo	2320	608	\N	526	2155	\N	\N	6	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2482	CD19	listo	2321	608	\N	563	2152	https://drive.google.com/file/d/1Aat-xeMhXnL7tmf9H_JAMR59q4rIvqaX/view?usp=sharing	Ver MODELO DE INFORME	6	listo	\N	1	Laboratorio SBLab	Se actualiza el modelo de informe segun lo que remite IICT.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2483	CD2	listo	2322	608	\N	563	2156	\N	\N	6	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2484	CD20	listo	2860	608	\N	564	\N	\N	\N	4	listo	\N	1	Laboratorio SBLab	Se transfiere derivacion de TURNER a IICT.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2485	CD25	listo	2323	608	\N	526	\N	https://drive.google.com/file/d/18LNgDkm8yojcj1OaBlAGBbU1WBrPDV4-/view?usp=sharing	Ver MODELO DE INFORME	6	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2486	LINFO NK	listo	2325	608	\N	563	2154	\N	\N	6	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2487	CD34	listo	2326	608	\N	563	2151	\N	\N	3	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2488	CD4	listo	2327	608	\N	563	2150	https://drive.google.com/file/d/10tO8tb5w4595dKMDni8nOur5kgnQ210Y/view?usp=sharing	Ver MODELO DE INFORME	11	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2489	CD56	listo	2328	608	\N	563	2153	https://drive.google.com/file/d/1F_uJ7evtGxjf__-E85b9ec9yj5XUJh61/view?usp=sharing	Ver MODELO DE INFORME	6	listo	\N	1	Laboratorio SBLab	Se actualiza el modelo de informe segun lo que remite IICT.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2490	CD8	listo	2329	608	\N	563	2149	\N	\N	11	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2491	CEPBA	pendiente	2861	607	\N	565	\N	\N	\N	21	listo	\N	1	Laboratorio SBLab	Revisar informe de 22I 330805 PISTONE, SANDRA para ver formato de estudio. Agregar al area general.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2492	CLAPG	listo	2341	605	\N	559	1960	\N	\N	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2493	CLAPM	listo	2342	605	\N	559	1958	\N	\N	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2494	CLATG	listo	2346	605	\N	559	1998	\N	\N	4	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2495	CLATM	listo	2347	605	\N	559	1997	\N	\N	4	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2496	CBF	listo	2862	609	\N	566	\N	\N	-	22	revisar	\N	1	Laboratorio SBLab	Modelo de informe hecho, no adjunto. No se agrego aun al area general	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2497	FISH 17P	listo	2863	610	\N	567	\N	\N	\N	30	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2498	FLT3	listo	2451	611	81	565	\N	https://drive.google.com/file/d/17yqtmj993twVJ9v99UhTNSX7w_Pxn0Ev/view?usp=sharing	NEGATIVO	15	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2499	GLIA-A	listo	2471	605	\N	559	2082	https://drive.google.com/file/d/1NxKc98DXNWomFRGdA6uujSgJvm9EfU5p/view?usp=sharing	Ver MODELO DE INFORME	4	listo	\N	1	Laboratorio SBLab	Se incluye interpretacion solo en Hexalis	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2500	GLIA-G	listo	2472	605	\N	559	2083	https://drive.google.com/file/d/1iBV4GIj2I72HaFg8CZVvhxAmZwHKWrNL/view?usp=sharing	Ver MODELO DE INFORME	4	listo	\N	1	Laboratorio SBLab	Se incluye interpretacion solo en Hexalis	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2501	GLIDE-A2	listo	2473	605	\N	559	2081	https://drive.google.com/file/d/1W462YiDK0FSakbp3uqw_7xfC1OfgLH64/view?usp=sharing	Ver MODELO DE INFORME	5	listo	\N	1	Laboratorio SBLab	Eliminar el texto en Datatech al cabo de 6 meses	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2502	GLIDE-G2	listo	2474	605	\N	559	2080	https://drive.google.com/file/d/1xc1qDG6ATFMvJcXaMsoY16lSttJWgz3N/view?usp=sharing	Ver MODELO DE INFORME	5	listo	\N	1	Laboratorio SBLab	Eliminar el texto en Datatech al cabo de 6 meses	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2503	HERP1M	listo	2525	605	\N	559	1933	https://drive.google.com/file/d/1_8-C4XXIiTLp5w-kR6qQvbREDWD8k8Ar/view?usp=sharing	Ver MODELO DE INFORME	5	verificado	\N	1	Laboratorio SBLab	Se incluye interpretacion solo en Hexalis	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2504	HERP2M	listo	2527	605	\N	559	1935	https://drive.google.com/file/d/1N3ewvq7oGxuMHxRDuMe-BqDEyKf3FAYj/view?usp=sharing	Ver MODELO DE INFORME	5	verificado	\N	1	Laboratorio SBLab	Se incluye interpretacion solo en Hexalis	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2505	PCR-HIV	listo	2539	612	\N	568	\N	\N	\N	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2506	IDH	listo	2554	609	81	569	2034	https://drive.google.com/file/d/1FWTod3i7jpEQfUtfoOhj902OT5jBkD-X/view?usp=sharing	-	45	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2507	CITOFLU	listo	2587	608	81	570	\N	\N	\N	16	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2508	IGD	listo	2592	541	\N	559	1735	\N	\N	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2509	JAK2- 12	listo	2615	613	\N	563	2158	\N	\N	31	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2510	AC-JO1	listo	2617	605	\N	559	2055	\N	\N	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2511	ANTI-LA	listo	2620	605	\N	559	2053	\N	\N	8	listo	\N	1	Laboratorio SBLab	Se agrega en Hexalis, la determinacion INTERPRETACION separada del RESULTADO.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2512	MICOG 1	listo	2665	605	\N	559	1964	\N	\N	5	listo	\N	1	Laboratorio SBLab	En la web dice IFI en vez de ELISA	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2513	MICOM 1	listo	2666	605	\N	559	1963	\N	\N	5	listo	\N	1	Laboratorio SBLab	En la web dice IFI en vez de ELISA	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2514	NPM-1	listo	2673	614	81	565	\N	https://drive.google.com/file/d/1Kcg1b1gpEqAMy_KhD4fy5Q2QryfiwFBT/view?usp=sharing	NO SE OBSERVAN INSERCIONES NI DELECIONES	20	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2515	PAPP-A	listo	2685	615	87	559	1855	https://drive.google.com/file/d/125g6wGAc4Oh3jEWUS-fXfmcLmN4JOYO0/view?usp=sharing	\N	16	verificado	\N	1	Laboratorio SBLab	Se cambia el tiempo de demora de 2 a 16 dias.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2516	PARVO G1	listo	2697	605	\N	559	1991	\N	\N	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2517	PARVO M1	listo	2698	605	\N	559	1990	\N	\N	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2518	PXEORI	listo	2727	616	82	571	\N	https://drive.google.com/file/d/10b3-_x7XJ8-hGM4e09vAuft1_4iM-_4f/view?usp=sharing	-	8	verificado	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2519	PXE1	listo	2728	617	\N	559	1747	https://drive.google.com/file/d/1bu2ni50N9RNljBYHSbNDYfrkt6UEe1uq/view?usp=sharing	\N	4	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2520	QUIMO	listo	2733	590	\N	572	2174	\N	\N	20	listo	\N	1	Laboratorio SBLab	Previamente se derivaba a TURNER, pero no lo procesa mas.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2521	ANTI-RNP	listo	2745	605	\N	559	2051	\N	\N	8	listo	\N	1	Laboratorio SBLab	Se corrigio valor de referencia. Eliminar texto en Datatech al cabo de 6 meses.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2522	ANTI-RO	listo	2746	605	\N	559	2052	\N	\N	8	listo	\N	1	Laboratorio SBLab	Se agrega en Hexalis, la determinacion INTERPRETACION separada del RESULTADO.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2523	RUNX1	listo	2864	609	81	565	\N	\N	\N	30	listo	\N	1	Laboratorio SBLab	Revisar informe de 22I 330805 PISTONE, SANDRA para ver formato de estudio. Agregar al area general.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2524	AESC70PM	listo	2756	605	\N	559	2054	\N	\N	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2525	ANTI-SM	listo	2766	605	\N	559	2049	\N	\N	8	listo	\N	1	Laboratorio SBLab	Se agrega en Hexalis, la determinacion INTERPRETACION separada del RESULTADO.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2526	FREE-SUB	listo	2781	615	87	559	1854	\N	\N	16	verificado	\N	1	Laboratorio SBLab	Se cambia el tiempo de demora de 2 a 16 dias.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2527	TCF3-HLF	listo	2783	609	81	565	2035	https://drive.google.com/file/d/18EF2iK_L54HgjRTQm-QZPXWFO2w5p0yE/view?usp=sharing	-	30	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2528	TRANS A2	listo	2814	605	\N	559	2086	https://drive.google.com/file/d/1aCriyQKL_1x1Mw6uxczLaXFiXBqI4HtG/view?usp=sharing	Ver MODELO DE INFORME	4	verificado	\N	1	Laboratorio SBLab	Eliminar el texto en Datatech al cabo de 6 meses	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2529	TRANS G2	listo	2815	605	\N	559	2087	https://drive.google.com/file/d/19rpYZKC905jxx6kouw-u8eMPLgmuI410/view?usp=sharing	Ver MODELO DE INFORME	4	verificado	\N	1	Laboratorio SBLab	Se incluye interpretacion	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2530	TEL-AML1	listo	2816	609	81	565	2037	https://drive.google.com/file/d/1eG4EPCpbfetFCwSgX87haQF2cxPdbfob/view?usp=sharing	-	21	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2531	PML-RAR	listo	2817	609	81	567	2039	https://drive.google.com/file/d/1yHrmOIyzN5rA93gB2i7NvX1XifsEU8de/view?usp=sharing	-	17	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2532	MLL/AF4	listo	2818	609	81	565	2038	https://drive.google.com/file/d/1tZwu1Di30j_G9Ikrlw-m2iee8zgMTij4/view?usp=sharing	-	10	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2533	AML1-ETO	listo	2865	609	\N	573	\N	\N	\N	0	pendiente	\N	1	SIN ASIGNAR	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2534	VARIC G1	listo	2842	605	\N	559	1974	https://drive.google.com/file/d/1ffyykBvia-0A5TG-JorDGc0EAIw6QTBy/view?usp=sharing	Ver MODELO DE INFORME	8	verificado	\N	1	Laboratorio SBLab	Se incluye interpretacion solo en Hexalis	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2535	VARIC M1	listo	2843	605	\N	559	1973	https://drive.google.com/file/d/1MR3cx0RK2aojsx1HDusOtmIayl7HPkEo/view?usp=sharing	Ver MODELO DE INFORME	8	verificado	\N	1	Laboratorio SBLab	Se incluye interpretacion solo en Hexalis	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	50	\N
2536	OHPGM1A	listo	2195	618	88	559	2167	https://drive.google.com/file/d/1JgJAw-tOma5zWZDMSXr6zfIFn3O5Wowl/view?usp=drive_link	Ver MODELO DE INFORME	5	listo	OHPGM1A	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2537	OHPG	listo	2196	619	86	559	1843	\N	📋	5	verificado	OHPG	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2538	BUTIRICO	listo	2199	620	\N	559	1663	\N	0.03 - 0.30 mmol/l	7	listo	B OHB	1	Laboratorio SBLab	Previamente se derivaba a TURNER.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2539	662277	pendiente	2209	621	\N	574	2125	INDICACIONES AL PACIENTE\n\nDeterminación: ACIDO MUCONICO\nMuestra: ORINA AISLADA\nPreparación previa: -\nToma de muestra: Recolectar la muestra al finalizar la última jornada laboral de la semana fuera del ámbito laboral. Recolectar en frasco plástico estéril.\nDatos adicionales: -\nVersión: 01 (07/08/2026)\n\nINDICACIONES AL LABORATORIO\nRemitir alícuota de 15 mL de orina post jornada laboral + alícuota de 5 mL de orina post jornada laboral en tubo de 13x75mm sin aditivo\nConservar a 2-8°C	IBE menor a 500 µg/g Cr	20	listo	AMU	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2540	OXALURIA	listo	2211	534	82	575	1763	ACIDO OXALICO URINARIO\n\nPACIENTE\nDesde 48hs antes de iniciar la recolección de orina de 24h:\n\nEvite la toma de ácido ascórbico (vitamina C), té, mate, café y chocolate o la ingestión de alimentos que contengan oxalato como las espinacas, frutillas, tomates.\n\nSe requiere un recipiente limpio de al menos 2L (brocal, bidón o botella de agua mineral).\n\nDescarte la primera orina de la mañana y registre el horario.\n\nDurante las próximas 24h, recolecte todas las fracciones de orina en dicho recipiente, manteniéndolo refrigerado en heladera durante todo el proceso.\n\nUna vez alcance el horario registrado en el punto 2, orine la última fracción y coloque la misma en el recipiente.	17.5 a 35.1 mg/24h	16	verificado	AOX O	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2541	VALPRO	listo	2214	619	89	576	2095	https://drive.google.com/file/d/1OndcVQfhnYMlAdo-RNIz7_XmiNKQfupL/view?usp=sharing	50.0 a 100.0 µg/ml	4	verificado	AV	1	Laboratorio SBLab	Previamente se derivaba a TURNER	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2542	ADENO-M	listo	2225	622	\N	559	1948	\N	\N	11	listo	ADV M I	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2543	ADRE P	listo	2229	623	90	577	2137	https://drive.google.com/file/d/1GF8XQQVasy-e5J0ChPBM3UJ_jQBanXdI/view?usp=sharing	Ver MODELO DE INFORME	26	listo	AD P	1	Laboratorio SBLab	Se corrigen los valores de referencia.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2544	ALD S	listo	2233	619	90	578	1870	https://drive.google.com/file/d/1TwjhWxAYykEBZrcB43a-sGyyasV_oRnT/view?usp=sharing	Ver MODELO DE INFORME	10	listo	ALD S	1	Laboratorio SBLab	Cambio en el metodo en Labmedicina.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2545	ANTRIPMF	listo	2235	548	\N	579	2171	\N	\N	21	listo	A1A MF	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2546	ANTRIP	listo	2236	541	\N	576	2170	\N	90.00 a 200.00 mg/dl	11	listo	A1A	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2611	RAST DP	listo	2565	634	\N	559	\N	https://drive.google.com/file/d/1qr0J09gLHvI8dJUnsPjogzyknCRlFRwi/view?usp=sharing	Ver MODELO DE INFORME	11	listo	IGE DP	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2547	CL A1ANT	listo	2237	625	\N	580	2172	ALFA 1 ANTITRIPSINA, CLEARENCE DE\n\nPACIENTE\n- MATERIA FECAL, TOTALIDAD DE DEPOSICIONES DE 2 DÍAS.\n- SANGRE.\nAyuno de 8 horas previas a la toma de muestra de SANGRE.\nRecolectar la totalidad de las deposiciones de dos días recipiente estéril. Mantener a temperatura ambiente hasta su envío al laboratorio.	Hasta 12.5 ml/24h	21	listo	A1ACL	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2548	ALUMINIO	listo	2239	626	\N	559	\N	ZINC SERICO\nNo deben realizar el estudio en pacientes que hayan recibido gadolinio, iodo, bario en las últimas 96 horas. Estos agentes de contraste basados ​​en metal son interferentes conocidos para las técnicas de análisis de trazas de metales.\nConsulte con su medico previo a la realización del estudio.	Menor a 0.6 µg/dl	21	listo	AL	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2549	H.A.D.	listo	2247	618	\N	581	1872	\N	Menor a 13 pmol/l	37	listo	HAD	1	Laboratorio SBLab	Se cambia el envio desde CONGELADO a REFRIGERADO.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2550	HMU	listo	2255	615	\N	576	1850	\N	📋	8	verificado	HMU	1	Laboratorio SBLab	Se cambia el envio desde REFRIGERADO a CONGELADO.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2551	APO E	listo	2866	609	\N	582	\N	\N	-	16	listo	APOE	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2552	AQ4	listo	2259	622	\N	559	2077	\N	\N	31	listo	AQ4	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2553	AQ4 LCR	listo	2260	622	\N	583	2078	\N	\N	31	listo	AQ4 LCR	1	Laboratorio SBLab	Labmedicina no informa valores de referencia.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2554	BANDAS	listo	2263	627	\N	584	1749	\N	\N	31	listo	BO	1	Laboratorio SBLab	Labmedicina no informa valores de referencia.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2555	BARTO-G	listo	2264	628	\N	576	2003	\N	NEGATIVO	11	listo	BN G I	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2556	BARTO-M	listo	2265	628	\N	576	2002	\N	NEGATIVO	11	listo	BN M I	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2557	LAPS S	listo	2272	615	\N	551	1767	https://drive.google.com/file/d/17JTMC47AixAALLcJrT6ipvySVhfyuW87/view?usp=sharing	📋	11	listo	LAPS B	1	Laboratorio SBLab	20/08/2026 Se cambia el envio desde REFRIGERADO a CONGELADO.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2558	BORDE	listo	2278	605	\N	559	1956	\N	\N	16	listo	BP G I	1	Laboratorio SBLab	Se inactiva debido a la falta de reactivo. Se procesa en IDYMIC. 02/07/2026: Se vuelve a activar porque se vuelve a procesar en LABMEDICINA.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2559	BORD-IGM	listo	2280	605	\N	559	1954	\N	\N	16	listo	BP M I	1	Laboratorio SBLab	Se inactiva debido a la falta de reactivo. Se procesa en IDYMIC.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2560	BIFIGG	listo	2287	622	\N	559	1908	\N	\N	16	listo	BL G I	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2561	BIFIGM	listo	2288	622	\N	559	1907	\N	\N	16	listo	BL M I	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2562	CA 72-4	listo	2296	629	\N	559	1880	\N	Hasta 4.0 UI/ml	8	listo	CA724	1	Laboratorio SBLab	Previamente se derivaba a CIBIC	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2563	CARBA	listo	2309	621	89	559	2092	CARBAMAZEPINA\n\nPACIENTE\nObtener la muestra antes de la administración de la siguiente dosis.	\N	3	listo	CBZ	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2564	ACCELUPA	listo	2331	622	\N	576	2064	\N	NEGATIVO	16	listo	ACPG	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2565	CIS C	listo	2348	541	\N	559	1676	https://drive.google.com/file/d/15Zymi2sSFY5Q2Hnc-0kjITWvXMWvenrD/view?usp=sharing	0.56 a 1.02 mg/l	7	listo	CIS C	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2566	CISTI	listo	2349	590	82	585	1765	CISTINA EN ORINA\n\nORINA DE 24 HORAS\n\nUtilizar recipiente limpio y seco.\n\nVaciar completamente su vejiga (orinar en el inodoro y desechar esa primera muestra) a\nlas 8 horas o la hora que elija.\n\nAnotar la hora de descarte para tomarla como hora de inicio.\n\nRecolectar todas las micciones de orina del día hasta la primera del siguiente día inclusive, que coincida con la hora de inicio dentro de un recipiente limpio de boca ancha.\n\nConservar en heladera. Y llevar al laboratorio lo antes posible. No perder ninguna muestra de orina.\n\nSi además se solicita en la misma orden médica ORINA COMPLETA, se debe recolectar la primera orina de la mañana del segundo día en un recipiente separado\ny notificar al técnico o administrativo.	10 a 100 mg/24h	10	listo	CIS O	1	Laboratorio SBLab	04/06/2026 El tiempo de demora se reduce de 20 a 10 días.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2567	CMV-AVI	listo	2358	630	\N	559	1930	https://drive.google.com/file/d/1nTvOXS9Z9xvy-f82DoY3OZqIl-4xr-EN/view?usp=sharing	Ver MODELO DE INFORME	16	listo	CMV TA	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2568	CITRATU	listo	2361	631	82	575	1764	CITRATURIA\n\nDesde 48hs antes de iniciar la recolección de orina de 24h:\n\nEvite la toma de ácido ascórbico (vitamina C), té, mate, café y chocolate o la ingestión de alimentos que contengan oxalato como las espinacas, frutillas, tomates.\n\nSe requiere un recipiente limpio de al menos 2L (brocal, bidón o botella de agua mineral).\n\nDescarte la primera orina de la mañana y registre el horario.\n \nDurante las próximas 24h, recolecte todas las fracciones de orina en dicho recipiente, manteniéndolo refrigerado en heladera durante todo el proceso.\n\nUna vez alcance el horario registrado en el punto 2, orine la última fracción y coloque la misma en el recipiente.	📋	16	verificado	AC O	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2569	CLOBAZAN	listo	2362	621	89	576	2097	https://drive.google.com/file/d/1t2F-8aPGtmMTmNDiyrfxtO_XiTU31s1t/view?usp=sharing	0.12 a 0.97 µg/ml	0	listo	CLB	1	Laboratorio SBLab	Se usan valores de referencia desde Datatech.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2570	CLOZA	listo	2363	621	89	578	\N	https://drive.google.com/file/d/1815IBZ_sJHtXaOWcJzueDJ-7kbkJ6r9J/view?usp=sharing	Ver MODELO DE INFORME	16	listo	CLZP	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2571	COBRE/S	listo	2366	590	\N	559	1775	\N	📋	11	verificado	CU S	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2572	CROMOGRA	listo	2398	632	\N	559	1887	\N	Menor a 102.0 ng/ml	12	listo	CGA	1	Laboratorio SBLab	04/06/2026 El tiempo de demora se reduce de 26 a 20 días. 03/07/2026: Se cambia metodo de ELISA a TRACE, valor de referencia de <100 a <102 y la demora de 20 a 12 dias	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2573	D4	listo	2400	615	86	559	1841	DELTA 4 ANDROSTENEDIONA\n\nPACIENTE\nConcurrir entre el 3º al 5º día del ciclo femenino, siendo el día 1º, el día en el que inició el sangrado menstrual. Si se encuentra en amenorrea y no existe otra indicación médica, obtener la muestra en un día al azar. \nConsignar FUM (Fecha de última menstruación)	📋	5	verificado	D4	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2574	DEOXIPIR	listo	2402	619	\N	586	1769	\N	📋	16	verificado	DPYR	1	Laboratorio SBLab	Se elimina requerimiento de DIURESIS	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2612	RAST EPG	listo	2567	634	\N	559	\N	https://drive.google.com/file/d/1qr0J09gLHvI8dJUnsPjogzyknCRlFRwi/view?usp=sharing	Ver MODELO DE INFORME	9	listo	IGE EPG	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2613	RAST SI	listo	2873	634	\N	559	\N	\N	Ver MODELO DE INFORME	9	listo	IGE SI	1	Laboratorio SBLab	Hacer modelo de informe y pasar al area general	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2575	DGX	listo	2405	532	91	559	2091	INDICACIONES AL PACIENTE\nDeterminación: DIGOXINA\nMuestra: SANGRE VENOSA\nPreparación previa: Concurrir al laboratorio luego de que hayan transcurrido 6 horas de la última dosis, o bien, justo antes de la próxima dosis.\nToma de muestra: Punción venosa.\nDatos adicionales: Indicar dosis y horario de la última toma. Indicar otras medicaciones.\nVersión: 01 (20/ENE/2026)	0.8 a 2.0 ng/ml	6	listo	DGX	1	mariangel. rinaudo@sanbritanico.com.ar	Previamente se derivaba a IBC.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2576	DOPAMINA	listo	2409	623	\N	577	2145	https://drive.google.com/file/d/1Mq52OvCeyCy_wMYWsPAdxbjC3lQkVldX/view?usp=sharing	MENOR A 50 pg/ml	26	listo	DA P	1	Laboratorio SBLab	Se agrega el limite de cuantificacion.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2577	PANEL EN	listo	2415	622	\N	559	2071	\N	NEGATIVO	21	listo	ECF S	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2578	ECF LCR	listo	2416	622	\N	583	2076	\N	NEGATIVO	21	listo	ECF LCR	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2579	ENOLASA	listo	2419	629	\N	559	1885	\N	Menor a 16.3 ng/ml	11	listo	NSE	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2580	ECA	listo	2422	631	\N	559	1868	ENZIMA CONVERTIDORA DE ANGIOTENSINA (ECA)\n\nLas drogas inhibidoras de la ECA (captopril, enalapril) deben ser discontinuados 4 semanas antes de la realización del test. No discontinuar la medicación sin antes consultar con su médico.	20 a 70 U/l	16	listo	ECA	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2581	ERITRO	listo	2429	619	\N	576	2104	\N	4.3 a 29.0 mUI/ml	5	listo	EP	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2582	ESTRONA	listo	2437	624	86	559	1835	\N	📋	21	verificado	E1	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2583	EVEROL	listo	2440	633	89	587	2101	EVEROLIMUS\n\nPACIENTE:\nMuestras: SANGRE\nPreparación previa: Ayuno de 8 horas.\nToma de muestra: Concurra al laboratorio previo a la administración de la siguiente dosis de medicación (valle), cuando la concentración es mínima.\nDatos adicionales: Dosis y horario de la última toma.\nVersión: 1.0 (09-sep-2025)	3.0 a 8.0 ng/ml	6	listo	EVL	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2584	FACTINTR	listo	2441	605	\N	559	2065	\N	\N	14	listo	FI	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2585	FENOBAR	listo	2447	621	\N	559	2100	https://drive.google.com/file/d/1JD9qDr-3bpBwOBNObMXRZYgRTBQAYG7n/view?usp=sharing	10.00 a 40.00 mg/l	5	listo	FBT	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2586	FOSFO G	listo	2459	605	\N	559	1645	\N	\N	11	listo	FFL	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2587	FOSFO M	listo	2460	605	\N	559	1644	\N	\N	11	listo	FFL M	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2588	ANTI-GAD	listo	2465	619	\N	576	1819	\N	\N	27	verificado	GADA	1	Laboratorio SBLab	Se configuro envio CONGELADO solo miercoles (se agregan 6 dias a la demora estándar)	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2589	GASTRINA	listo	2470	634	\N	576	1888	GASTRINA SERICA\n\nPACIENTE\n24 horas previas a la extracción suspender la toma de antiácidos, drogas anticolinérgicas y antagonistas de receptor H2, inhibidores de la bomba de protones. Consultar con el médico antes de suspender cualquier medicación.	13 - 115 pg/ml	15	listo	GA	1	Laboratorio SBLab	Se configuro envio CONGELADO solo miercoles (se agregan 6 dias a la demora estándar) Anteriormente se derivaba a TURNER	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2590	GLU 6PDH	listo	2486	635	\N	587	1760	\N	7.0 - 20.5 U/gHb	10	verificado	G6	1	Laboratorio SBLab	04/06/2026 Se cambia demora de 20 a 10 dias.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2591	HELI	listo	2494	634	\N	559	1993	\N	\N	11	listo	AHP G I	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2592	HELI-M	listo	2495	622	\N	559	1992	\N	\N	11	listo	AHP M E	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2593	HEV IGM	listo	2519	605	\N	559	1926	\N	\N	15	listo	HEV M	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2594	ANTI-HU	listo	2551	622	\N	559	2073	\N	NEGATIVO	23	listo	HU IFI	1	Laboratorio SBLab	Se configuro envio CONGELADO	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2595	IA-2	listo	2553	605	\N	576	\N	https://drive.google.com/file/d/1OktxsQ186dCTbs9prb_BrEsCy3eRB4QK/view?usp=sharing	Ver MODELO DE INFORME	17	listo	IA-2	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2596	RAST AM	listo	2867	634	\N	559	\N	\N	Ver MODELO DE INFORME	9	listo	IGE AM	1	Laboratorio SBLab	Hacer modelo de informe y pasar al area general	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2597	RAST AL	listo	2868	634	\N	559	\N	\N	Ver MODELO DE INFORME	11	listo	IGE AL	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2598	RAST ALM	listo	2555	634	\N	559	\N	https://drive.google.com/file/d/1qr0J09gLHvI8dJUnsPjogzyknCRlFRwi/view?usp=sharing	Ver MODELO DE INFORME	11	listo	IGE ALME	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2599	RAST ALT	listo	2556	634	\N	559	\N	https://drive.google.com/file/d/1qr0J09gLHvI8dJUnsPjogzyknCRlFRwi/view?usp=sharing	Ver MODELO DE INFORME	11	listo	IGE ALT	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2600	RAST A	listo	2557	634	\N	559	\N	https://drive.google.com/file/d/1qr0J09gLHvI8dJUnsPjogzyknCRlFRwi/view?usp=sharing	Ver MODELO DE INFORME	11	listo	RA	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2601	RAST AFL	listo	2558	636	\N	559	\N	https://drive.google.com/file/d/1yoLklqgjfI6jlNOFM8IXMWjo-4st2XqB/view?usp=sharing	Ver MODELO DE INFORME	21	listo	IGE AFL	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2602	RAST AF	listo	2559	634	\N	559	\N	https://drive.google.com/file/d/1qr0J09gLHvI8dJUnsPjogzyknCRlFRwi/view?usp=sharing	Ver MODELO DE INFORME	11	listo	IGE AF	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2603	RAST ANI	listo	2560	634	\N	559	\N	https://drive.google.com/file/d/1qr0J09gLHvI8dJUnsPjogzyknCRlFRwi/view?usp=sharing	Ver MODELO DE INFORME	11	listo	IGE ANI	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2604	RAST VS	listo	2869	634	\N	559	\N	\N	Ver MODELO DE INFORME	9	listo	IGE VS	1	Laboratorio SBLab	Hacer modelo de informe y pasar al area general	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2605	RAST BL	listo	2870	634	\N	559	\N	\N	Ver MODELO DE INFORME	11	listo	IGE BL	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2606	RAST BT	listo	2871	634	\N	559	\N	\N	Ver MODELO DE INFORME	11	listo	IGE BT	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2607	RAST CAS	listo	2872	634	\N	559	\N	\N	Ver MODELO DE INFORME	11	listo	IGE CAS	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2608	RAST CF	listo	2562	634	\N	559	\N	https://drive.google.com/file/d/1qr0J09gLHvI8dJUnsPjogzyknCRlFRwi/view?usp=sharing	Ver MODELO DE INFORME	9	listo	RCF	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2609	RAST CH	listo	2563	634	\N	559	\N	https://drive.google.com/file/d/1qr0J09gLHvI8dJUnsPjogzyknCRlFRwi/view?usp=sharing	Ver MODELO DE INFORME	11	listo	IGE CH	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2610	RAST DF	listo	2564	634	\N	559	\N	https://drive.google.com/file/d/1qr0J09gLHvI8dJUnsPjogzyknCRlFRwi/view?usp=sharing	Ver MODELO DE INFORME	11	listo	IGE DF	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2650	PBS	listo	2708	626	\N	589	1778	\N	Menor a 26.0 µg/dl	16	listo	PB S	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2614	RAST	listo	2569	634	92	559	1737	https://drive.google.com/file/d/1qr0J09gLHvI8dJUnsPjogzyknCRlFRwi/view?usp=sharing	Ver MODELO DE INFORME	11	listo	\N	1	Laboratorio SBLab	No tiene valores de referencia en Datatech.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2615	RAST PG	listo	2573	634	\N	559	\N	https://drive.google.com/file/d/1qr0J09gLHvI8dJUnsPjogzyknCRlFRwi/view?usp=sharing	Ver MODELO DE INFORME	8	listo	RPG	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2616	RAST PV	listo	2574	634	\N	559	\N	https://drive.google.com/file/d/1qr0J09gLHvI8dJUnsPjogzyknCRlFRwi/view?usp=sharing	Ver MODELO DE INFORME	8	listo	RPV	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2617	RAST GL	listo	2874	634	\N	559	\N	\N	Ver MODELO DE INFORME	11	listo	IGE GL	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2618	RAST T	listo	2875	634	\N	559	\N	\N	Ver MODELO DE INFORME	9	listo	IGE T	1	Laboratorio SBLab	Hacer modelo de informe y pasar al area general	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2619	RAST YH	listo	2575	634	\N	559	\N	https://drive.google.com/file/d/1qr0J09gLHvI8dJUnsPjogzyknCRlFRwi/view?usp=sharing	Ver MODELO DE INFORME	9	listo	IGE YH	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2620	RAST HM	pendiente	2876	634	\N	559	\N	\N	Ver MODELO DE INFORME	10	listo	IGE HM	1	Laboratorio SBLab	Hacer modelo de informe y pasar al area general	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2621	INFA IGG	listo	2576	622	\N	559	1979	\N	NEGATIVO MENOR A 1/10	11	listo	IFZA G I	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2622	INFA IGM	listo	2577	622	\N	559	1978	\N	NEGATIVO MENOR A 1/16	11	listo	IFZA M I	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2623	INFB IGG	listo	2580	622	\N	559	1982	\N	NEGATIVO MENOR A 1/10	11	listo	IFZB G I	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2624	INFB IGM	listo	2581	622	\N	559	1981	\N	NEGATIVO MENOR A 1/16	11	listo	INFB M I	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2625	INMUNOC	listo	2586	605	\N	559	2042	https://drive.google.com/file/d/1T02jNRMvlUwzi9KXheBwGFFn-7tyBL5w/view?usp=sharing	Ver MODELO DE INFORME	14	listo	CIC	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2626	IGG SUB	listo	2595	579	\N	559	1734	\N	\N	20	listo	IGGSC1/2/3/4	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2627	IGGSC4	listo	2596	579	\N	559	1738	\N	39.5 a 864.0 mg/l	21	listo	IGGSC4	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2628	IAA -1	listo	2605	637	\N	576	1817	ANTICUERPOS ANTI INSULINA\nObtener antes de la aplicación de insulina.	Hasta 0.4 U/ml	21	listo	IAA	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2629	ICA-1	listo	2613	622	\N	559	1818	\N	Ver MODELO DE INFORME	11	listo	ICA	1	Laboratorio SBLab	Se corrige el numero de estudio de Hexalis, ingresado erroneo previamente.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2630	LAMOTRIG	listo	2622	621	89	559	2096	https://drive.google.com/file/d/1LTa4Yn9-h9kKDVrQ3Z7CzR4fj4CavKEf/view?usp=sharing	2.5 a 15.0 µg/ml	10	listo	LAMO	1	Laboratorio SBLab	Los valores de referencia cambiaron a 2,5 a 15,0 (antes eran 3.0 a 14.0 µg/ml)	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2631	LEVETIRA	listo	2626	621	89	588	2099	https://drive.google.com/file/d/1z7CxW0A1D01cgRDPIKBHkqkmhB3VI_v6/view?usp=sharing	12.0 a 46.0 µg/ml	10	listo	LEVET	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2632	LPG	listo	2877	616	\N	559	\N	\N	Ver MODELO DE INFORME	6	listo	LPG	1	Laboratorio SBLab	HACER MODELO Y AGRERGAR AL AREA PRINCIPAL	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2633	LI S	listo	2632	638	\N	559	2090	LITIO\n\nNo se requiere ayuno y/o preparación previa. Tomar la muestra 8 a 10 horas luego de la última dosis.\nPunción venosa, 8 a 10 horas luego de la última dosis.\nIndicar dosis y horario de la última toma. Indicar otras medicaciones.	📋	5	listo	LI S	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2634	ANTI-LKM	listo	2633	622	\N	559	2046	\N	NEGATIVO	8	listo	ALKM	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2635	MN-S	listo	2638	626	\N	559	1776	MANGANESO SERICO\n\nNo deben realizarse el estudio en pacientes que hayan recibido gadolinio, iodo, bario en las últimas 96 horas.\nConsultar con su medico previo a la realización del estudio.	Menor a 0.23 µg/dl	21	listo	MN S	1	Laboratorio SBLab	Se actualiza tipo de muestra desde SANGRE HEPARINIZADA a SUERO. Se actualiza unidades y valores de referencia de 4,7 a 18,3 ug/l a menor a 0,24 ug/dl	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2636	AMB1	listo	2642	622	\N	559	2059	\N	\N	8	listo	AMB	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2637	MERCURIO	listo	2643	639	\N	559	\N	https://drive.google.com/file/d/1kgYgJjNYzqUjjK9dxkA21mpGVTROAI4A/view?usp=sharing	Menor a 0.9 µg/dl	21	listo	HG S	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2638	MTHFR	listo	2648	609	\N	582	1651	https://drive.google.com/file/d/11AOTdI9PyTh_3_eA6EANR5_sm8-HkyDJ/view?usp=sharing	Ver MODELO DE INFORME	21	verificado	BMD100	1	Laboratorio SBLab	Se actualiza el modelo de informe en base a los resultados del protocolo 22N 264276	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2639	MPO	listo	2652	619	\N	559	2060	https://drive.google.com/file/d/1bo6BJ8tumJtzCV-r3N7Sbuh15FoW9Vnl/view?usp=sharing	Ver MODELO DE INFORME	6	listo	MPO	1	Laboratorio SBLab	Se modifico envio de CONGELADO a REFRIGERADO. Cambia metodo de ELISA a CLIA. La demora se reduce de 26 a 6 dias.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2640	MIOGL/S	listo	2653	541	\N	559	1711	\N	\N	7	verificado	MGL S	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2641	MOG IGG	listo	2656	622	\N	559	2068	\N	\N	41	listo	MOG AC IGG	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2642	AML	listo	2660	628	\N	559	2058	\N	NEGATIVO	11	listo	AML	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2643	NOR P	listo	2670	623	\N	577	2139	https://drive.google.com/file/d/1og-eu2gMjtCz_l7qcbX-ytPawdtZDDRn/view?usp=sharing	Ver MODELO DE INFORME	26	listo	NAD P	1	Laboratorio SBLab	Se agrega limite de cuantificacion	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2644	5ND	listo	2674	640	\N	559	\N	\N	📋	8	listo	NT	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2645	OSTEO	listo	2678	615	\N	559	1771	https://drive.google.com/file/d/1uqmryOe7IpR3o0wk9vb6TvPf0w-Pk742/view?usp=sharing	📋	17	listo	OC	1	Laboratorio SBLab	Se configuro envio CONGELADO solo miercoles (se agregan 6 dias a la demora estándar)	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2646	OXCARBA	listo	2679	621	89	559	2093	https://drive.google.com/file/d/1FPuPycxMmFjBcuCfyGb57dH3enHORhz4/view?usp=sharing	10.0 a 35.0 µg/ml	10	listo	OXC	1	Laboratorio SBLab	Se cambia el rango terapeútico de 3 a 35 a 10 a 35	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2647	PANELNEU	listo	2681	641	\N	576	2070	https://drive.google.com/file/d/1rGDRqMOC_OJfi5ih7GE7oKmnOKg1YOJy/view?usp=sharing	Ver MODELO DE INFORME	22	listo	ONCO	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2648	PEPTI C	listo	2699	619	\N	559	1815	\N	1.1 a 5.0 ng/ml	14	verificado	PPC	1	Laboratorio SBLab	Se configuro envio CONGELADO solo miercoles (se agregan 6 dias a la demora estándar)	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2649	VIP	listo	2702	605	\N	551	2106	\N	Menor a 75 pg/ml	28	listo	VIP	1	Laboratorio SBLab	No se procesa mas en TURNER. Se envia a LABMEDICINA.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2651	PBOR	listo	2709	626	\N	590	\N	PACIENTE\n\nDeterminación: PLOMO (Pb) URINARIO\nMuestra: ORINA AISLADA POST JORNADA LABORAL (50 ml)\nPreparación previa: -\nToma de muestra: Recolectar la muestra al finalizar la última jornada laboral de la semana fuera del ámbito laboral. Recolectar una orina con por lo menos tres horas de retención en recipiente estéril. Se requieren al menos 40 ml de orina.\nNo refrigerar.\nDatos adicionales: -\nVersión: 01 (06/NOV/2025)\n\nLABORATORIO\nRemitir 2 alícuotas de 15 ml de orina post-jornada laboral + 5 ml de orina en tubo 13×75 mm sin aditivo.	Menor a 150 µg/gCr	18	listo	PB O	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2652	IGFBP.3	listo	2723	619	\N	559	1856	\N	📋	21	listo	IGFBP3	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2653	PR3	listo	2726	619	\N	559	2061	https://drive.google.com/file/d/1m02kJe5gdBkz6aBs5I8-V1FElJJCuZ1a/view?usp=sharing	Ver MODELO DE INFORME	6	listo	PR3	1	Laboratorio SBLab	Se configuro envio CONGELADO. Cambia metodo de ELISA a CLIA. La demora se reduce de 26 a 6 dias.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2654	ACRA	listo	2735	624	\N	559	2066	\N	Ver MODELO DE INFORME	21	listo	ACRA	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2655	SE S	listo	2760	626	\N	559	1777	\N	7.0 a 15.0 µg/dl	21	verificado	SE S	1	Laboratorio SBLab	Actualizacion en valor de referencia: de (menor a 15) a (7-15)	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2656	SEROP	listo	2761	642	\N	582	2135	https://drive.google.com/file/d/1YdawIZGjp-a9Y78O0oyhj55UYwaPTlEG/view?usp=sharing	Menor a 950 ng/ml/10˄9 plaq	8	listo	SEROP	1	Laboratorio SBLab	Alta: 22/07/2025. Baja: 16/10/2025. Alta: 11/11/2025.  Se cambia la demora de 14 a 8 días.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2657	SERO-S	listo	2762	642	\N	559	2134	https://drive.google.com/file/d/19Y1CfhhHTJHD5pEmflzvfAZrh5En0pUn/view?usp=sharing	Menor a 230.0 ng/ml	8	verificado	STN S	1	Laboratorio SBLab	Se configuro envio CONGELADO. Se cambia la demora de 14 a 8 días debido a que se aumenta la frecuencia de envios congelados.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2658	IGF1 120	listo	2767	619	\N	559	\N	\N	NO APLICA	17	listo	SMC	1	Laboratorio SBLab	Previamente se derivaba a TURNER.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2659	IGF1 30	listo	2768	619	\N	559	1864	\N	NO APLICA	17	listo	SMC	1	Laboratorio SBLab	Previamente se derivaba a TURNER.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2660	IGF1 60	listo	2769	619	\N	559	1865	\N	NO APLICA	17	listo	SMC	1	Laboratorio SBLab	Previamente se derivaba a TURNER.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2661	IGF1 90	listo	2770	619	\N	559	1866	\N	NO APLICA	17	listo	SMC	1	Laboratorio SBLab	Previamente se derivaba a TURNER.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2662	SMC	listo	2771	619	\N	559	1863	https://drive.google.com/file/d/1B6J8PFnF17qGf1jTMVvVDh_Fi65h2fB3/view?usp=sharing	📋	11	verificado	SMC	1	Laboratorio SBLab	Se configuro envio CONGELADO. Se cambia la demora de 17 a 11 días debido a que se aumenta la frecuencia de envios congelados.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2663	HGH	listo	2772	619	\N	559	1857	\N	📋	11	listo	HGH	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2664	STH 120	listo	2773	619	\N	559	1861	\N	NO APLICA	11	listo	HGH	1	Laboratorio SBLab	Previamente se derivaba a TURNER.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2665	STH 180	listo	2774	619	\N	559	1862	\N	NO APLICA	11	listo	HGH	1	Laboratorio SBLab	Previamente se derivaba a TURNER.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2666	STH 30	listo	2775	619	\N	559	1858	\N	NO APLICA	11	listo	HGH	1	Laboratorio SBLab	Previamente se derivaba a TURNER.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2667	STH 60	listo	2776	619	\N	559	1859	\N	NO APLICA	11	listo	HGH	1	Laboratorio SBLab	Previamente se derivaba a TURNER.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2668	STH 90	listo	2777	619	\N	559	1860	\N	NO APLICA	11	listo	HGH	1	Laboratorio SBLab	Previamente se derivaba a TURNER.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2669	TOPIRAMA	listo	2801	643	\N	581	2098	https://drive.google.com/file/d/1REhX1cNVAa7mthf3GFMMoMM_po63molw/view?usp=sharing	2.0 - 20.0 µg/ml	23	listo	TOPI	1	Laboratorio SBLab	Se completa el valor de referencia.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2670	VIT A	listo	2845	621	\N	591	2114	LABORATORIO\nSeparar muestra en tubo opaco (proteger de la luz).	0.24 a 0.95 mg/l	27	listo	VA	1	Laboratorio SBLab	Se configuro envio CONGELADO solo miercoles (se agregan 6 dias a la demora estándar)	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2671	VITA B1	listo	2846	644	\N	591	2116	LABORATORIO\nSeparar muestra en tubo opaco (proteger de la luz).	4.00 a 20.0 µg/l	37	listo	VB1	1	Laboratorio SBLab	Se configuro envio CONGELADO solo miercoles (se agregan 6 dias a la demora estándar)	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2672	VITA B6	listo	2848	644	\N	591	2117	https://drive.google.com/file/d/1zw7g4vyPoQL48T7YaPHxbDMAMMaV6-M5/view?usp=sharing	📋	27	verificado	VB6	1	Laboratorio SBLab	Se configuro envio CONGELADO solo miercoles (se agregan 6 dias a la demora estándar). Se corrigen los valores de referencia (estaba mal configurado en la web de Labmedicina). Se elimina texto con valores de referencia.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2673	VIT C	discontinuado	2878	621	\N	592	\N	LABORATORIO\nSeparar muestra en tubo opaco con conservante, congelar (proteger de la luz en tubo especial).	0.40 a 2.00 mg/dl	16	verificado	VC	1	mariangel. rinaudo@sanbritanico.com.ar	Se configuro envio CONGELADO. Cambio de metodología de electroforesis capilar a HPLC-UV, y cambio de muestra de plasma con heparina refrigerada en tubo opaco a plasma con EDTA con conservante congelada en tubo opaco. Etiqueta DATA: 59 EDTA(POC) 19 / Etiqueta HEXA: 19- PLASMA CON EDTA TUBO OPACO. 26/06/2026 Se inactiva debido a problemas con los envios.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2674	VITA C	inactivo	2879	645	\N	593	\N	LABORATORIO\nSeparar muestra en tubo opaco con conservante, congelar (proteger de la luz en tubo especial).	0.40 a 2.00 mg/dl	28	listo	VC	1	Laboratorio SBLab	Se inactiva por cambio de tecnologia. Se implemente VITA C	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2675	VIT.E	listo	2851	621	\N	591	2115	PACIENTE\nEvitar consumir alcohol durante las  24 horas previas a la extracción.\n\nLABORATORIO\nSeparar muestra en tubo opaco (proteger de la luz).	5.0 a 20.0 mg/l	28	listo	VE	1	Laboratorio SBLab	Se configuro envio CONGELADO solo miercoles (se agregan 6 dias a la demora estándar)	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2676	ZINC	listo	2854	590	\N	559	1779	ZINC SERICO\nNo deben realizar el estudio en pacientes que hayan recibido gadolinio, iodo, bario en las últimas 96 horas. Estos agentes de contraste basados ​​en metal son interferentes conocidos para las técnicas de análisis de trazas de metales.\nConsulte con su medico previo a la realización del estudio.	📋	8	verificado	ZN	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	51	\N
2677	17PROG	inactivo	2196	646	\N	588	1843	\N	-	4	pendiente	17HPRG	1	Laboratorio SBLab	Se inactiva. Se deriva a LABMEDICINA.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2693	AMINO/S	listo	2242	651	\N	588	2128	AMINOACIDOS SERICOS, CUANTITATIVOS\n\nLABORATORIO\nAdjuntar completa la planilla de Estudios de errores congénitos del metabolismo-Neo pesquisa ampliada.	\N	16	listo	AMINOS	1	Laboratorio SBLab	La paridad esta hecha con una sola determinacion. En Datatech se pone una nota de VER INFORME ADJUNTO.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2747	PH	listo	2705	\N	\N	579	\N	\N	-	2	listo	PH	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2678	17PRONEO	inactivo	2880	605	93	594	\N	PACIENTE\n1. Muestras: Sangre\n2. Recomendaciones: Extraer dentro del primer mes de vida, preferentemente entre los días 2° y 6° de vida.\n3. Modo de recoleccion: Puncion en talon del pie.\n\nLABORATORIO\nRemitir el papel impregnado con sangre y datos del paciente. Conservar a temperatura ambiente.\nObtener la muestra dentro del primer mes de vida. Se recomienda la toma de muestra entre el 2° y 6° dia de vida, 24hs despues de iniciada la alimentacion lactea.\nUtilizar el papel de filtro adecuado: S&S 903.\nNo superponer gotas de sangre sobre el mismo punto del papel.	-	12	pendiente	17HPGN	1	Laboratorio SBLab	Revisar metodo y valores de referencia	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2679	BUTIRICO	discontinuado	2199	647	\N	595	1663	\N	-	12	pendiente	BETAH	1	Laboratorio SBLab	Se procesa en LABMEDICINA.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2680	FENILA	listo	2200	644	\N	571	2121	ACIDO FENIL ACETICO (AFA) URINARIO\n\nPACIENTE\nMuestra de orina de 24h con dieta previa.\nDurante dos días hacer la dieta indicada. Al tercer día y continuando con la dieta, recolectar la orina de 24h: a las 7h orinar y descartar esa orina. A partir de ese momento deben recolectarse TODAS las orinas en su totalidad durante todo el día y hasta las 7h del día siguiente inclusive en un brocal. Mantener refrigerada hasta el momento de llevarla al laboratorio.\nDIETA: durante dos días previos a la recolección de la muestra no ingerir bananas, tomates, paltas, berenjenas, ananá chocolate, ciruelas, maníes, nueces, vainilla ni ningún alimento que la contenga (tortas, postres, cremas, golosinas, etc.), te ni café.\n\nLABORATORIO\nRemitir 100 ml de orina de 24h recolectada con dieta previa. Indicar diuresis y datos del paciente.	200 a 700 µg/24h	15	listo	AFA	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2681	ACIDOGLU	listo	2203	644	\N	559	2122	\N	12.0 a 98.0 µmol/l	16	listo	GLUTA	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2682	AHO	listo	2204	590	82	596	2120	ACIDO HOMOGENTISICO\n\nRECOLECCION ORINA DE 24 HORAS\n\nUtilizar recipiente limpio y seco.\n\nVaciar completamente su vejiga (orinar en el inodoro y desechar esa primera muestra) a\nlas 8 horas o la hora que elija.\n\nAnotar la hora de descarte para tomarla como hora de inicio.\n\nRecolectar todas las micciones de orina del día hasta la primera del siguiente día inclusive, que coincida con la hora de inicio dentro de un recipiente limpio de boca ancha.\n\nConservar en heladera. Y llevar al laboratorio lo antes posible. No perder ninguna muestra de orina.\n\nSi además se solicita en la misma orden médica ORINA COMPLETA, se debe recolectar la primera orina de la mañana del segundo día en un recipiente separado\ny notificar al técnico o administrativo.	-	15	listo	AHO	1	Laboratorio SBLab	No tiene valores de referencia en Turner.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2683	HOMO PL	listo	2205	644	\N	581	2147	\N	7.20 a 18.00 ng/ml	19	listo	HVAP	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2684	OROTICO	listo	2210	648	\N	597	2123	ACIDO OROTICO URINARIO\n\nPACIENTE\nRecolectar de 4 a 6 orinas durante todo un dia, previa higiene y en condiciones de asepsia. Refrigerar.\n\nLABORATORIO\nRecolectar de 4 a 6 orinas durante todo un día, previa higiene y en condiciones de asepsia. Refrigerar.\nMezclar las muestras, tomar una alícuota de 50 ml y congelarla a -20°C no menos de 12 h.\nEnviar bien refrigerada.\nEl desarrollo bacteriano invalida el estudio debido a los productos metabólicos de los microorganismos.\nAdjuntar planilla de errores congénitos del metabolismo.	Menor a 7.0 mol/mol Cr	22	listo	ORO	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2685	ACPIRU	listo	2212	601	\N	598	2126	\N	0.40 a 2.00 mg/dl	5	listo	ACPIRU	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2686	AVMHPLC	listo	2213	644	82	599	2144	ACIDO VANILLIN MANDELICO\n\nPACIENTE\nDurante dos días hacer la dieta indicada. Al tercer día y continuando con la dieta, recolectar la orina de 24h: a las 7h orinar y descartar esa orina. A partir de ese momento deben recolectarse TODAS las orinas en su totalidad durante todo el dia y hasta las 7h del día siguiente inclusive en un brocal. Mantener refrigerada hasta el momento de llevarla al laboratorio.\nDIETA: durante dos días previos a la recolección de la muestra no ingerir bananas, tomates, paltas, berenjenas, ananá, chocolate, ciruelas, maní, nueces, vainilla ni ningún alimento que la contenga (tortas, postres, cremas, golosinas, etc.), té ni café.\n\nLABORATORIO\nRemitir 100 ml de orina de 24h con pH<3, recolectada con dieta previa. Indicar diuresis y datos del paciente.	0.0 a 7.2 mg/24h	19	listo	AVMHPLC	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2687	TD-VAL	inactivo	2214	634	\N	559	2095	Extracción de la muestra 1 hora antes de tomar la medicación. Ayuno de 4h.	Rango Terapeutico: 50 a 100 µg/ml	7	pendiente	VAL	1	Laboratorio SBLab	Se pasa a derivar a LABMEDICINA	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2688	AC GRASO	listo	2216	590	\N	559	1725	\N	0.1 a 0.9 mEq/l	7	listo	NEFA	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2689	ACID.ORG	listo	2217	648	\N	600	2127	ACIDOS ORGANICOS URINARIOS\n\nPACIENTES\n1. Muestras: Orina\n2. Recomendaciones: Recolectar las muestras en condiciones de asepsia. Refrigerar hasta el momento de remitirlas al laboratorio.\n3. Modo de recolección: Recolectar de 4 a 6 orinas durante todo un día, previa higiene y en condiciones de asepsia. Refrigerar.\n\nLABORATORIO\nMezclar las muestras, tomar una alícuota de 100 ml y congelarla a -20°C no menos de 12 h.\nEnviar bien refrigerada.\nEl desarrollo bacteriano invalida el estudio debido a los productos metabólicos de los microorganismos.\nAdjuntar completa la planilla de Estudios de errores congénitos del metabolismo-Neo pesquisa ampliada.	-	22	listo	ACOR	1	Laboratorio SBLab	Crear indicaciones para entregar al paciente	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2690	ACILCARN	listo	2218	649	93	594	2108	ACIL CARNITINAS\n\nLABORATORIO\nRemitir el papel impregnado con sangre y datos del paciente. Conservar a temperatura ambiente.\nUtilizar el papel de filtro adecuado: S&S 903.\nNo superponer gotas de sangre sobre el mismo punto del papel.\nAdjuntar completa la planilla de Estudios de errores congénitos del metabolismo-Neo pesquisa ampliada.	\N	22	listo	ACAR	1	Laboratorio SBLab	La paridad esta hecha con una sola determinacion. En Datatech se pone una nota de VER INFORME ADJUNTO.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2691	ADREURI	listo	2230	644	82	601	2138	ADRENALINA URINARIA\n\nPACIENTE\n1. Muestras: Orina de 24 h.\n2. Recomendaciones: Debe recolectarse con dieta previa.\n3. Modo de recolección: Durante dos días hacer la dieta indicada. Al tercer día y continuando con la dieta, recolectar la orina de 24 h: a las 7 h orinar y descartar esa orina. A partir de ese momento deben recolectarse TODAS las orinas en su totalidad durante todo el día y hasta las 7hs del día siguiente inclusive en un brocal. Mantener refrigerada hasta el momento de llevarla al laboratorio.\nDIETA: durante dos días previos a la recolección de la muestra no ingerir bananas, tomates, paltas, berenjenas, ananá, chocolate, ciruelas, maníes, nueces, vainilla ni ningún alimento que la contenga (tortas, postres, cremas, golosinas, etc.), te ni café.\n\nLABORATORIO\nRemitir 30 ml de orina de 24 h con pH<3, recolectada con dieta previa. Indicar diuresis y datos del paciente.	\N	22	listo	ADRED	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2692	ALD	listo	2232	650	\N	588	1710	\N	Menor a 7.6 UI/l	2	listo	ALD	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2718	ELASTASA	listo	2414	541	\N	579	2173	\N	\N	22	listo	ELAS	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2694	AMINOO	listo	2243	652	\N	597	2129	AMINOACIDOS URINARIOS, CUANTITATIVOS\n\nPACIENTES\n1. Muestras: Orina\n2. Recomendaciones: Mantener refrigerada hasta remitirla al laboratorio.\n3. Modo de recolección: Recolectar de 5 orinas durante todo un día, previa higiene y en condiciones de asepsia. Mantener las muestras en heladera hasta remitirlas al laboratorio.\n\nLABORATORIO\nRecolectar de 5 orinas durante todo un día, previa higiene y en condiciones de asepsia.\nMezclar las muestras, tomar una alícuota de 50 ml. Enviar bien refrigerado.\nEl desarrollo bacteriano invalida el estudio debido a los productos metabólicos de los microorganismos.\nAdjuntar completa la planilla de Estudios de errores congénitos del metabolismo-Neo pesquisa ampliada.	\N	8	listo	AMINOO	1	Laboratorio SBLab	La paridad esta hecha con una sola determinacion. En Datatech se pone una nota de ver informe adjunto.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2695	ANDROGLU	listo	2245	624	\N	588	1842	\N	📋	11	listo	ANDROS	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2696	CARO	listo	2271	647	\N	602	2113	BETA CAROTENO\n\nLABORATORIO\nRemitir 2,5ml de suero refrigerado. Ayuno de 4h.\nProteger de la luz.	50 a 250 µg/ml	11	listo	CAROTE	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2697	BIOTINID	listo	2276	605	93	594	2163	BIOTINIDASA, ACTIVIDAD DE (NEONATAL)\n\nPACIENTE\nExtraer dentro del primer mes de vida. Se recomienda la toma de muestra entre el 2° y 6° día de vida, 24h después de iniciada la alimentación láctea.\n\nLABORATORIO\nRemitir el papel impregnado con sangre y datos del paciente. Conservar a temperatura ambiente.\nUtilizar el papel de filtro adecuado: S&S 903.\nNo superponer gotas de sangre sobre el mismo punto del papel.	-	12	listo	BION	1	Laboratorio SBLab	No tiene valores de referencia	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2698	WRIS	listo	2285	653	\N	588	1905	\N	-	4	listo	WRIS	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2699	WRIC	listo	2286	653	\N	588	1906	\N	-	4	listo	WRIC	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2700	CAL/ASPI	listo	2306	634	\N	603	1831	CALCITONINA EN ASPIRADO DE NODULO\n\nLABORATORIO\nRemitir el lavado de aguja con el material de punción en un vial con 1.0 ml de Sol. Fisiológica. Refrigerar.	-	5	listo	CLN	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2701	CAR LAM	listo	2313	654	\N	604	1892	https://drive.google.com/file/d/1ccZ0fbrjBFdRTob6zP_8eYYbdZKJCgc2/view?usp=sharing	-	35	listo	\N	1	Laboratorio SBLab	Los derivantes no deberian remitir las muestras los dias viernes.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2702	CAR ABOR	listo	2314	654	\N	605	1891	LABORATORIO\n\nTOMA DE MUESTRA DE MATERIAL DE ABORTO\na) Extracción: \n- Cuando hacen legrado el médico debe tomar una porción de la zona de vellosidades de la placenta o de lo que va a dar origen a la placenta y enviarlo a las condiciones más estériles posibles, por lo general en un recipiente estéril de urocultivo.\n\nb) Conservación y envío:\n- La muestra deber ser enviada en el mismo recipiente en que se realizó la extracción, sin trasvasar y a temperatura ambiente (o con refrigerante). No debe transportarse con hielo seco.\nMantener en la heladera hasta el momento del envío.\n\nLa muestra debe enviarse en el menor tiempo posible luego de su extracción para asegurar la viabilidad de las células.\nNo remitir muestras los días viernes.	-	63	listo	\N	1	Laboratorio SBLab	Los derivantes no deberian remitir las muestras los dias viernes. Se aumenta el tiempo de demora de 21 a 63 dias.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2703	CITOGEN	listo	2315	654	\N	606	1890	LABORATORIO\n\nTOMA DE MUESTRA DE MEDULA OSEA PARA ESTUDIO CITOGENETICO\na) Extracción: \n- Colocar en una jeringa de 5 ml Heparina sódica ESTERIL (0,05 a 0,10 ml aproximadamente). \n- Extraer al menos 2 ml de MEDULA OSEA. Para citogenética está indicado que se debe mandar la primera o segunda porción de extracción. Evite maniobras que impidan la conservación de la\nmuestra en condiciones de estricta esterilidad.\n- Colocar inmediatamente el capuchón en la aguja, o colocar una aguja nueva impidiendo el contacto de la muestra con el aire. No doblar la aguja ni taparla\ncon otros elementos como tapones de goma, gasas, algodón, no estériles. Fijar el émbolo y aguja o tapón estéril con cinta adhesiva.\n\nb) Conservación y envío:\n- La muestra deber ser enviada en la misma jeringa en que se realizó la extracción, sin trasvasar y a temperatura ambiente (o con refrigerante). No debe transportarse con hielo seco.\nMantener en la heladera hasta el momento del envío.\nc) También es posible realizar la extracción en tubos vacutainer con heparina sódica y enviarlos en los mismos.\n\nLa muestra debe enviarse en el menor tiempo posible luego de su extracción para asegurar la viabilidad de las células.\nNo remitir muestras los días viernes.	-	21	verificado	\N	1	Laboratorio SBLab	Los derivantes no deberian remitir las muestras los dias viernes.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2704	CARIOTIP	listo	2316	654	\N	607	1889	LABORATORIO\n\nTOMA DE MUESTRA DE SANGRE PERIFERICA PARA ESTUDIO CITOGENETICO\na) Extracción: \n- Colocar en una jeringa de 5 ml o 10 ml Heparina sódica ESTERIL (0,05 a 0,10 ml aproximadamente).\n- Cambiar la aguja y extraer preferentemente entre 4 y 5 ml de sangre venosa en niños , en caso de bebes puede ser menos ( en lo posible al menos 2ml) y\nentre 8 a 10 ml en adultos. Evite maniobras que impidan la conservación de la\nmuestra en condiciones de estricta esterilidad.\n- Colocar inmediatamente el capuchón en la aguja, o colocar una aguja nueva\nimpidiendo el contacto de la muestra con el aire. No doblar la aguja ni taparla\ncon otros elementos como tapones de goma, gasas, algodón, no estériles. Fijar\nel émbolo y aguja o tapón estéril con cinta adhesiva.\n\nb) Conservación y envío:\n- La muestra deber ser enviada en la misma jeringa en que se realizó la \nextracción, sin trasvasar y a temperatura ambiente (o con refrigerante). No\ndebe transportarse con hielo seco.\nMantener en la heladera hasta el momento del envío.\nc) También es posible realizar la extracción en tubos vacuteiner con heparina sódica y enviarlos en los mismos.\n\nLa muestra debe enviarse en el menor tiempo posible luego de su extracción para asegurar la viabilidad de las células.\nNo remitir muestras los días viernes.	-	63	listo	\N	1	Laboratorio SBLab	Los derivantes no deberian remitir las muestras los dias viernes. Se aumenta el tiempo de demora de 21 a 63 dias.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2719	ECA-LCR	listo	2423	647	\N	612	1869	\N	Menor a 2.5 U/l	8	listo	ECA	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2720	ESTE	listo	2434	656	\N	579	2175	\N	Menor a 4%	8	listo	ESTE	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2721	ESTRIOL	listo	2436	634	95	588	1836	https://drive.google.com/file/d/1vamop087_3twceiXUeCV3yT9TWUN8fTD/view?usp=sharing	Ver MODELO DE INFORME	8	listo	ESL	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2722	FENALA	listo	2445	644	\N	559	2119	\N	📋	15	listo	FENILS	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2723	FOH OSEA	listo	2453	634	\N	588	1772	https://drive.google.com/file/d/1GwshmzZuq5_xwAOSr7hd5GMRkwldSlzz/view?usp=sharing	Ver MODELO DE INFORME	2	listo	OSAL	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2724	FOSGLI	listo	2456	657	\N	613	2131	\N	-	8	listo	FOSGLI	1	Laboratorio SBLab	En el NBU figura como ANTICUERPOS IGG ANTI FOSFATIDIL GLICEROL	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2796	SINCI-M	listo	2764	669	\N	559	1951	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	No tiene valores de referencia en Datatech	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2705	CARIO AL	listo	2317	654	\N	607	1893	LABORATORIO\n\nTOMA DE MUESTRA DE SANGRE PERIFERICA PARA ESTUDIO CITOGENETICO\na) Extracción: \n- Colocar en una jeringa de 5 ml o 10 ml Heparina sódica ESTERIL (0,05 a 0,10 ml aproximadamente).\n- Cambiar la aguja y extraer preferentemente entre 4 y 5 ml de sangre venosa en niños , en caso de bebes puede ser menos ( en lo posible al menos 2ml) y\nentre 8 a 10 ml en adultos. Evite maniobras que impidan la conservación de la\nmuestra en condiciones de estricta esterilidad.\n- Colocar inmediatamente el capuchón en la aguja, o colocar una aguja nueva\nimpidiendo el contacto de la muestra con el aire. No doblar la aguja ni taparla\ncon otros elementos como tapones de goma, gasas, algodón, no estériles. Fijar\nel émbolo y aguja o tapón estéril con cinta adhesiva.\n\nb) Conservación y envío:\n- La muestra deber ser enviada en la misma jeringa en que se realizó la extracción, sin trasvasar y a temperatura ambiente (o con refrigerante). No debe transportarse con hielo seco.\nMantener en la heladera hasta el momento del envío.\nc) También es posible realizar la extracción en tubos vacuteiner con heparina sódica y enviarlos en los mismos.\n\nLa muestra debe enviarse en el menor tiempo posible luego de su extracción para asegurar la viabilidad de las células.\nNo remitir muestras los días viernes.	-	61	listo	\N	1	Laboratorio SBLab	Los derivantes no deberian remitir las muestras los dias viernes.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2706	CARNITIN	listo	2318	649	\N	559	2130	https://drive.google.com/file/d/1aLzqVr5mz3uk1CI111N8LeAD49r1xlbw/view?usp=sharing	Ver MODELO DE INFORME	22	listo	CAR	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2707	CATOHPLC	listo	2319	644	\N	608	2142	CATECOLAMINAS URINARIAS\n\nPACIENTE: ORINA DE 24 HORAS.\nDebe recolectarse con DIETA previa: durante dos días previos a la recolección de la muestra no ingerir bananas, tomates, palta, berenjenas, ananá, chocolate, ciruelas, maní, nueces, vainilla ni ningún alimento que la contenga (tortas, postres, cremas, golosinas, etc.), te ni café.\nDurante dos días hacer la dieta indicada. Al tercer día y continuando con la dieta, recolectar la orina de 24hs: a las 07:00 h orinar y descartar esa orina. A partir de ese momento deben recolectarse TODAS las orinas en su totalidad durante todo el día y hasta las 07:00 h del día siguiente inclusive en un brocal. Mantener refrigerada hasta el momento de llevarla al laboratorio.\n\nLABORATORIO\nRemitir 30 ml de orina de 24hs con pH 2-3, recolectada con dieta previa. Indicar diuresis y datos del paciente.	\N	22	listo	CATFU	1	Laboratorio SBLab	En Datatech tiene una determinacion fantasma (4), pasa por defecto un guion.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2708	CD20	discontinuado	2860	608	\N	564	\N	\N	\N	4	listo	LBCD20	1	Laboratorio SBLab	Se transfiere a IICT.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2709	CORURI-N	listo	2381	634	\N	609	1828	CORTISOL LIBRE URINARIO\n\nPACIENTE\nEl día previo a concurrir al laboratorio comenzar con la recolección de la ORINA DE 24h.\n- Vaciar completamente su vejiga (orinar en el inodoro y desechar esa primera muestra) a las 8 horas o la hora que elija.\n- Anotar la hora de descarte para tomarla como hora de inicio.\n- Recolectar TODAS las micciones de orina del día hasta la primera del siguiente día inclusive, que coincida con la hora de inicio dentro de un recipiente limpio de boca ancha. No perder ninguna muestra de orina.\n- Conservar en heladera hasta su entrega.	21 a 111  µg/24h	3	verificado	CORURI	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2710	CORSAL	listo	2382	634	94	610	1823	https://drive.google.com/file/d/1f3EIfj2r6cOxhizvs0wh8M74t5FJ6onR/view?usp=drive_link	Ver MODELO DE INFORME	3	verificado	COR08	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2711	CORSAL08	listo	2383	634	\N	610	1824	CORTISOL SALIVAL\n\nPACIENTE\nSe recomienda no comer, beber (excepto agua), fumar, ni cepillarse los dientes durante las 2-3 horas previas a la toma de muestra. \nEnjuagar la boca con agua, sin cepillar los dientes.\nEn el horario indicado en la orden médica, salivar en un frasco estéril (recolectar la mayor cantidad posible).\nConservar en heladera hasta su entrega.	1.4 a 10.1 ng/ml	3	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2712	CORSAL12	listo	2384	634	\N	610	1825	CORTISOL SALIVAL\n\nPACIENTE\nSe recomienda no comer, beber (excepto agua), fumar, ni cepillarse los dientes durante las 2-3 horas previas a la toma de muestra. \nEnjuagar la boca con agua, sin cepillar los dientes.\nEn el horario indicado en la orden médica, salivar en un frasco estéril (recolectar la mayor cantidad posible).\nConservar en heladera hasta su entrega.	-	3	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2713	CORSAL18	listo	2385	634	\N	610	1826	CORTISOL SALIVAL\n\nPACIENTE\nSe recomienda no comer, beber (excepto agua), fumar, ni cepillarse los dientes durante las 2-3 horas previas a la toma de muestra. \nEnjuagar la boca con agua, sin cepillar los dientes.\nEn el horario indicado en la orden médica, salivar en un frasco estéril (recolectar la mayor cantidad posible).\nConservar en heladera hasta su entrega.	-	3	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2714	CORSAL22	listo	2386	634	\N	610	1827	CORTISOL SALIVAL\n\nPACIENTE\nSe recomienda no comer, beber (excepto agua), fumar, ni cepillarse los dientes durante las 2-3 horas previas a la toma de muestra. \nEnjuagar la boca con agua, sin cepillar los dientes.\nEn el horario indicado en la orden médica, salivar en un frasco estéril (recolectar la mayor cantidad posible).\nConservar en heladera hasta su entrega.	0.7 a 2.2 ng/ml	3	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2715	FISH 12	listo	2399	610	81	611	2040	https://drive.google.com/file/d/1qr11mtxwMr2G0gWRWrgUdua7jj1ftdEV/view?usp=sharing	-	22	listo	STC12	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2716	DIMETFEN	listo	2407	655	\N	571	2148	DIMETOXIFENILETILAMINA, 3, 4 (DMFA)\n\nPACIENTE\nDebe recolectarse con DIETA previa: durante dos días previos a la recolección de la muestra no ingerir bananas, tomates, palta, berenjenas, ananá, chocolate, ciruelas, maní, nueces, vainilla ni ningún alimento que la contenga (tortas, postres, cremas, golosinas, etc.), te ni café.\nDurante dos días hacer la dieta indicada. Al tercer día y continuando con la dieta, recolectar la orina de 24hs: a las 07:00 h orinar y descartar esa orina. A partir de ese momento deben recolectarse TODAS las orinas en su totalidad durante todo el día y hasta las 07:00 h del día siguiente inclusive en un brocal. Mantener refrigerada hasta el momento de llevarla al laboratorio.	\N	15	listo	DMFEA	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2717	DOPA O	listo	2410	644	\N	608	2146	DOPAMINA URINARIA\n\nPACIENTE: ORINA DE 24 HORAS.\nDebe recolectarse con DIETA previa: durante dos días previos a la recolección de la muestra no ingerir bananas, tomates, palta, berenjenas, ananá, chocolate, ciruelas, maní, nueces, vainilla ni ningún alimento que la contenga (tortas, postres, cremas, golosinas, etc.), te ni café.\nDurante dos días hacer la dieta indicada. Al tercer día y continuando con la dieta, recolectar la orina de 24hs: a las 07:00 h orinar y descartar esa orina. A partir de ese momento deben recolectarse TODAS las orinas en su totalidad durante todo el día y hasta las 07:00 h del día siguiente inclusive en un brocal. Mantener refrigerada hasta el momento de llevarla al laboratorio.\n\nLABORATORIO\nRemitir 30 ml de orina de 24hs con pH 2-3, recolectada con dieta previa. Indicar diuresis y datos del paciente.	\N	22	listo	DOPD	1	Laboratorio SBLab	Valor de referencia en Datatech duplicado (texto y configuración de análisis).	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2725	GALA1	listo	2466	658	93	594	2132	GALACTOSA 1-URIDIL FOSFOTRANSFERASA\n\nLABORATORIO\nRemitir el papel impregnado con sangre y datos del paciente. Conservar a temperatura ambiente.\nObtener la muestra dentro del primer mes de vida. Se recomienda la toma de muestra entre el 2° y 6° día de vida, 24hs despues de iniciada la alimentacion lactea.\nUtilizar el papel de filtro adecuado: S&S 903.\nNo superponer gotas de sangre sobre el mismo punto del papel.	\N	17	listo	GALA1	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2726	ANTI-GAN	listo	2469	605	\N	588	2067	https://drive.google.com/file/d/1Gkfl-Ysb4U-kL_p4SmTdSe5q8XMelECp/view?usp=sharing	Ver MODELO DE INFORME	15	listo	PAG	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2727	GASTRINA	discontinuado	2470	634	\N	588	1888	\N	-	11	pendiente	GASTRI	1	Laboratorio SBLab	Se comienza a derivar a LABMEDICINA. Las unidades y valores de referencia no cambian.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2728	VDK	listo	2489	659	\N	614	2176	GRASAS, CUANTITATIVO (VAN DE KAMER) - MATERIA FECAL\n\nPACIENTE\nLos días 4, 5 y 6 de la dieta, recoger toda la muestra de materia fecal de cada día en frascos separados, rotulados, indicando día de recolección, nombre y apellido del paciente. Remitir al laboratorio.\nDIETA: durante 6 días ingerir diariamente y en su totalidad:\nLACTANTES: 800ml de leche entera en la que se disuelven 2 cucharadas de crema de leche.\nNIÑOS DE 2 A 5 AÑOS: 400ml de leche entera, 1 cucharada de crema de leche y 20g de manteca.\nNIÑOS DE 5 A 12 AÑOS: 300ml de leche entera, 2 cucharadas de crema de leche y 25g de manteca.\nADULTOS: 50g de manteca, 3 cucharadas de crema de leche, 1 huevo duro, 2 fetas de jamón crudo, 50g de queso cremoso, 300ml de leche entera, 2 bifes o costeletas de carne vacuna a la plancha, 1 taza de caldo, galletitas de agua.	📋	8	listo	VANKAM	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2729	AR5	listo	2532	660	\N	588	1913	\N	NEGATIVO	3	listo	AR5	1	Laboratorio SBLab	Se corrigio el codigo de Hexalis porque estaba asignado equivocadamente. Se superponia con la derivacion a SEMIR.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2730	ANTIHIST	listo	2533	641	\N	588	2044	\N	Menor a 0.9	8	listo	HIST	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2731	ANTI-HU	discontinuado	2551	622	\N	588	2073	\N	-	29	listo	HUAC	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2732	INT 1-B	listo	2607	634	\N	559	2109	\N	Menor a 5.0 pg/ml	8	listo	INT	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2733	INTER-8	listo	2608	634	\N	551	2110	\N	Menor a 62.0 pg/ml	8	listo	INT8	1	Laboratorio SBLab	Se modifica en tipo de muestra (estaba cargada por error SUERO)	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2734	IOMF	listo	2609	661	\N	579	1693	\N	\N	8	listo	IOMF	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2735	JA	listo	2616	644	93	594	2165	JARABE DE ARCE - LEUCINA, NEONATAL\n\nLABORATORIO\nRemitir el papel impregnado con sangre y datos del paciente. Conservar a temperatura ambiente.\nObtener la muestra dentro del primer mes de vida. Se recomienda la toma de muestra entre el 2° y 6° día de vida, 24h después de iniciada la alimentación láctea.\nUtilizar el papel de filtro adecuado: S&S 903.\nNo superponer gotas de sangre sobre el mismo punto del papel.	\N	18	listo	JA	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2736	LAMOTRIG	discontinuado	2622	621	\N	559	2096	\N	\N	15	pendiente	LAMO	1	Laboratorio SBLab	Se deriva a LABMEDICINA.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2737	LEPTINA	listo	2624	662	\N	559	2133	https://drive.google.com/file/d/1FPz7Ql9VJbNStd9xxuB5y626f_1XVZcr/view?usp=sharing	Ver MODELO DE INFORME	22	listo	LEPT	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2738	MACROPRL	listo	2634	663	\N	559	1840	https://drive.google.com/file/d/1zTgHA-KIgX-WDAgm6E2NcEd520IhAKUY/view?usp=sharing	📋	3	listo	PROPEG	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2739	MAG.SGPG	listo	2635	664	\N	588	2069	\N	NEGATIVO	29	listo	MAG	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2740	METANEF	listo	2645	644	\N	599	2143	METANEFRINAS FRACCIONADAS URINARIAS\n\nPACIENTE: ORINA DE 24 HORAS.\nDebe recolectarse con DIETA previa: durante dos días previos a la recolección de la muestra no ingerir bananas, tomates, palta, berenjenas, ananá, chocolate, ciruelas, maní, nueces, vainilla ni ningún alimento que la contenga (tortas, postres, cremas, golosinas, etc.), te ni café.\nDurante dos días hacer la dieta indicada. Al tercer día y continuando con la dieta, recolectar la orina de 24hs: a las 07:00 h orinar y descartar esa orina. A partir de ese momento deben recolectarse TODAS las orinas en su totalidad durante todo el día y hasta las 07:00 h del día siguiente inclusive en un brocal. Mantener refrigerada hasta el momento de llevarla al laboratorio.\n\nLABORATORIO\nRemitir 30 ml de orina de 24hs con pH 2-3, recolectada con dieta previa. Indicar diuresis y datos del paciente.	\N	17	listo	METANE	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2741	MOFEG	listo	2658	665	\N	615	2141	\N	1.5 a 5.5 µg/l	19	listo	MOFEGP	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2742	TELOPEP	listo	2667	605	\N	616	1768	\N	200 a 800 µg/mmol/Cr	2	listo	NTX	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2743	AC.POLIS	discontinuado	2669	666	\N	559	2107	https://drive.google.com/file/d/1aVtALB8iM19Dx6KYPf51-snhFtygpRTH/view?usp=sharing	-	16	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2744	NORAURI	listo	2671	644	82	608	2140	NORADRENALINA URINARIA\n\nPACIENTE: ORINA DE 24 HORAS.\nDebe recolectarse con DIETA previa: durante dos días previos a la recolección de la muestra no ingerir bananas, tomates, palta, berenjenas, ananá, chocolate, ciruelas, maní, nueces, vainilla ni ningún alimento que la contenga (tortas, postres, cremas, golosinas, etc.), te ni café.\nDurante dos días hacer la dieta indicada. Al tercer día y continuando con la dieta, recolectar la orina de 24hs: a las 07:00 h orinar y descartar esa orina. A partir de ese momento deben recolectarse TODAS las orinas en su totalidad durante todo el día y hasta las 07:00 h del día siguiente inclusive en un brocal. Mantener refrigerada hasta el momento de llevarla al laboratorio.\n\nLABORATORIO\nRemitir 30 ml de orina de 24hs con pH 2-3, recolectada con dieta previa. Indicar diuresis y datos del paciente.	\N	22	listo	NORAD	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2745	OCRESOL	listo	2676	667	\N	617	2111	ORTO CRESOL\n\nPACIENTE\nRecolectar una muestra de orina al término de la jornada laboral en un recipiente estéril. Mantener refrigerada hasta remitirla al laboratorio.	Menor a 0.3 mg/gCr	15	listo	OCRESOL	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2746	PEP-C-OR	listo	2700	634	82	596	1816	PEPTIDO C URINARIO\n\nRECOLECCION ORINA DE 24 HORAS\n\nUtilizar recipiente limpio y seco.\n\nVaciar completamente su vejiga (orinar en el inodoro y desechar esa primera muestra) a\nlas 8 horas o la hora que elija.\n\nAnotar la hora de descarte para tomarla como hora de inicio.\n\nRecolectar todas las micciones de orina del día hasta la primera del siguiente día inclusive, que coincida con la hora de inicio dentro de un recipiente limpio de boca ancha.\n\nConservar en heladera. Y llevar al laboratorio lo antes posible. No perder ninguna muestra de orina.\n\nSi además se solicita en la misma orden médica ORINA COMPLETA, se debe recolectar la primera orina de la mañana del segundo día en un recipiente separado\ny notificar al técnico o administrativo.	3.6 - 156.0 µg/24h	2	listo	PEPC-U	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2748	ANTIPLAQ	listo	2706	608	\N	618	2063	LABORATORIO\nRemitir al laboratorio dentro de las 24h de la extracción 3 ml de sangre entera con EDTA.\nConservar a T. ambiente.\nNo centrifugar.\nNo congelar.	\N	8	listo	PQAC	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2749	RENINA	discontinuado	2737	634	96	619	1867	LABORATORIO\nSi la muestra debe ser tomada con el paciente acostado, el paciente debe reposar 30 minutos en camilla antes de la extracción.\nRemitir 1,0ml de plasma con EDTA congelado. Ayuno de 4hs.	-	4	pendiente	RENA O RENP	1	Laboratorio SBLab	Se pasa a procesar en CIBIC.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2750	ROSABENG	listo	2747	668	\N	588	1904	\N	NEGATIVO	2	listo	ROB	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2751	ASCA	listo	2751	660	\N	588	2006	https://drive.google.com/file/d/1ZvBs483UMXJN7xn4v0ETz1vEb-PDE6Dq/view?usp=sharing	Ver MODELO DE INFORME	3	listo	ASCA	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2752	TIROG/AS	listo	2792	634	\N	620	1803	\N	-	3	listo	TIROGN	1	Laboratorio SBLab	Falta configurar el codigo externo en Hexalis para que se pueda poner el mnemonico de Datatech	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2753	TIR	listo	2794	644	\N	559	1806	\N	Menor a 196 µmol/l	19	listo	TIR	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2754	TOXTETAN	listo	2804	660	\N	559	1894	https://drive.google.com/file/d/1zq0f5ZEYiZNDIsPc67pFvlW3IYUejBGP/view?usp=sharing	Ver MODELO DE INFORME	3	listo	TEAP	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2755	TRI	listo	2827	605	93	594	2166	\N	Menor a  75 ng/ml	12	listo	TRIN	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2756	NEON6	inactivo	2757	605	93	594	2161	\N	-	12	pendiente	NEO6	1	Laboratorio SBLab	Se usa cuando no hay derivaciones a FBA. Esta inactivo en este momento.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	52	\N
2757	ADENO-G	listo	2224	669	\N	559	1949	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2758	AC-ADREN	inactivo	2228	670	\N	621	2062	\N	\N	16	pendiente	\N	1	Laboratorio SBLab	Codigo de facturacion inactivo. Se envia mail a Fernanda.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2759	E.N.A.	listo	2253	660	\N	559	2048	\N	NEGATIVO	8	listo	\N	1	Laboratorio SBLab	La paridad esta hecha con una sola determinacion. En Datatech se pone una nota de VER INFORME ADJUNTO.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2760	AMC	listo	2254	669	\N	559	2045	\N	NEGATIVO	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2761	ANTICENT	listo	2332	669	\N	559	2047	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2762	CHAIFI	listo	2338	669	\N	559	1911	\N	NEGATIVO	5	verificado	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2763	CHLAPSIG	listo	2343	669	\N	559	1962	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2764	CHLA/PSI	listo	2344	669	\N	559	1961	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2765	PP65 CMV	inactivo	2881	\N	\N	\N	\N	\N	\N	0	pendiente	\N	1	SIN ASIGNAR	Codigo de facturación inactivo. Se envia mail a Fernanda.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2766	ANCA C	listo	2359	669	\N	559	\N	\N	NEGATIVO	8	verificado	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2767	ANCA P	listo	2360	669	\N	559	\N	\N	NEGATIVO	8	verificado	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2768	COXSA-G	pendiente	2882	670	\N	559	\N	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	Codigo de facturacion inactivo. Se envia mail a Fernanda.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2769	COXSA-M	listo	2388	669	\N	559	1966	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2770	DNA	listo	2408	669	\N	559	\N	\N	NEGATIVO	5	verificado	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2771	ECHOVI-G	listo	2412	669	\N	559	1968	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2772	ECHOVI-M	listo	2413	669	\N	559	1967	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2773	AAE-IGA	listo	2417	669	\N	559	2084	\N	NEGATIVO	4	verificado	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2774	AAE-IGG	listo	2418	669	\N	559	2085	\N	NEGATIVO	4	verificado	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2775	FAN	listo	2444	671	\N	559	2043	\N	NEGATIVO	5	verificado	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2776	FTA ABS	listo	2464	669	\N	559	1902	\N	NEGATIVO	4	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2777	HEPBEAC	listo	2508	672	\N	559	1925	\N	NO REACTIVO	5	verificado	\N	1	Laboratorio SBLab	Se incluyen valores normales en Hexalis y se actualiza el método en Hexalis y Datatech	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2778	HEPBCG	listo	2510	673	\N	559	1922	\N	NO REACTIVO	5	listo	\N	1	Laboratorio SBLab	No inclui valores normales en Hexalis porque no se como se informa.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2779	HEPBEAG	listo	2513	674	\N	559	1924	\N	NO REACTIVO	5	verificado	\N	1	Laboratorio SBLab	Se incluyen valores normales en Hexalis y se actualiza el método en Hexalis y Datatech	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2780	HERPE6 G	listo	2528	669	\N	559	1938	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2781	HERPE6 M	listo	2529	669	\N	559	1937	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2782	HIDAGIFI	listo	2530	669	\N	559	1914	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2783	HIDAMIFI	listo	2531	669	\N	559	1912	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2784	LEPTMAT	discontinuado	2883	675	\N	559	\N	\N	\N	4	pendiente	\N	1	SIN ASIGNAR	Codigo de facturacion inactivo. Se envia mail a Fernanda.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2785	AME	listo	2659	669	\N	559	2057	\N	NEGATIVO	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2786	ANTI-OVA	pendiente	2884	669	\N	559	\N	\N	NEGATIVO	8	listo	\N	1	Laboratorio SBLab	Codigo de facturacion inactivo. Se envia mail a Fernanda.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2787	PARA1ACG	listo	2686	628	\N	559	\N	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2788	PARA1ACM	listo	2687	628	\N	559	1984	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	No tiene valor de referencia en Datatech	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2789	PARA3ACG	listo	2690	628	\N	559	1988	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2790	PARA3ACM	listo	2691	628	\N	559	1987	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	No tiene valor de referencia en Datatech	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2791	PAROTID	listo	2694	628	\N	559	1972	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2792	PARO/IGM	listo	2695	628	\N	559	1971	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2793	SARAMP G	listo	2754	669	\N	559	1977	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2794	SARAMP	listo	2755	669	\N	559	1976	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2795	SINCI	listo	2763	669	\N	559	1952	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	No tiene valores de referencia en Datatech	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2797	TOXOCARA	listo	2802	673	\N	559	2005	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	Texto en Datatech: Pueden presentarse reacciones cruzadas con otros ascáridos, especialmente Áscaris lumbricoides.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2798	TOXOCA-M	listo	2803	673	\N	559	2004	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	Texto en Datatech: Pueden presentarse reacciones cruzadas con otros ascáridos, especialmente Áscaris lumbricoides.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2799	FTA-IgM	listo	2820	669	\N	559	1903	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2800	TRICHI	listo	2821	673	\N	559	2000	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	No tiene valores de referencia en Datatech	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2801	664623A	pendiente	2885	676	\N	559	\N	\N	NEGATIVO	8	listo	\N	1	Laboratorio SBLab	Solo se usa cuando el ENA es POSITIVO. No tiene paridad con DATATECH.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2802	TRICHI-M	listo	2822	673	\N	559	1999	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	No tiene valores de referencia en Datatech	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	53	\N
2803	ANTI-HID	listo	2197	605	\N	559	2050	https://drive.google.com/file/d/1aTBEIKuwrDnOrBq61jeS2UeCTMJnhSmc/view?usp=sharing	Ver MODELO DE INFORME	33	verificado	4412.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2804	ACIDOMET	listo	2208	677	\N	597	2124	https://drive.google.com/file/d/13zsTtypTAuMbY4b9lCFqFl2HqjeMUu13/view?usp=sharing	Menor a 3.6 mmol/molCr	32	verificado	1723.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2805	ACTH	listo	2219	629	\N	551	1821	PACIENTE\nDeterminación: ACTH – HORMONA ADRENOCORTICOTROFINA\nMuestra: SANGRE.\nPreparación previa: Mantener el ritmo sueno-vigilia durante los días previos. Ayuno de 4-8 horas. Actividad moderada horas antes de la prueba y fundamentalmente en los 30 minutos previos a la extracción de sangre.  Presentarse al Laboratorio por la mañana para poder realizar la extracción alrededor de las las 8 horas.\nToma de muestra: Punción venosa.\nDatos adicionales: Informar al Laboratorio que medicamentos está tomando.\nVersión: 1.0 (22-SEP-2025)\n\nLABORATORIO\nConservar la muestra congelada si no es enviada en el día de toma de muestra.	7.2 a 63.3 pg/ml	3	verificado	6.0	1	Laboratorio SBLab	04/08/2026 Se cambia a muestra congelada.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2806	PCR ADEN	listo	2223	609	81	622	\N	\N	NO DETECTABLE	3	listo	2145.0	1	Laboratorio SBLab	19/06/2026 Se inactiva porque se procesa en BMSB. 10/07/2026 Se activa para otras muestras.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2807	ANTI-ADR	listo	2228	669	\N	559	2062	https://drive.google.com/file/d/1_AO6Rd-eHEqlGrfxp874SDrA6iOnkpNZ/view?usp=sharing	Ver MODELO DE INFORME	5	listo	1924.0	1	Laboratorio SBLab	Se agrega una determinacion (Titulo) en Datatech	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2808	ALDO/OR	listo	2234	634	82	623	1871	Determinación: ALDOSTERONA URINARIA\nMuestra: ORINA DE 24 HORAS.\nPreparación previa: Se recomienda no recolectar muestras de orina durante el período menstrual. En caso contrario junte cada muestra higienizando previamente y colocándose un tampón vaginal.\nToma de muestra: El día previo a concurrir al laboratorio comenzar con la recolección de la ORINA DE 24h.\n- Vaciar completamente su vejiga (orinar en el inodoro y desechar esa primera muestra) a las 8 horas o la hora que elija.\n- Anotar la hora de descarte para tomarla como hora de inicio.\n- Recolectar TODAS las micciones de orina del día hasta la primera del siguiente día inclusive, que coincida con la hora de inicio dentro de un recipiente limpio de boca ancha. No perder ninguna muestra de orina.\n- Mantener en un lugar fresco y al abrigo de la luz. \nDatos adicionales: Cualquier medicación que esté tomando al momento de realizar el \nestudio debe ser comunicada cuando se entrega muestra.\nVersión: 01 (20/NOV/2025)	1.1 a 30.0  μg/24h	6	listo	1019.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2809	BENCE	listo	2267	678	82	623	1755	Determinación: BENCE JONES, PROTEINAS DE\n\nMuestra: ORINA DE 24 HORAS.\nPreparación previa: Se recomienda no recolectar muestras de orina durante el período menstrual. En caso contrario junte cada muestra higienizando previamente y colocándose un tampón vaginal.\nToma de muestra: El día previo a concurrir al laboratorio comenzar con la recolección de la ORINA DE 24h.\n- Vaciar completamente su vejiga (orinar en el inodoro y desechar esa primera muestra) a las 8 horas o la hora que elija.\n- Anotar la hora de descarte para tomarla como hora de inicio.\n- Recolectar TODAS las micciones de orina del día hasta la primera del siguiente día inclusive, que coincida con la hora de inicio dentro de un recipiente limpio de boca ancha. No perder ninguna muestra de orina.\n- Mantener en un lugar fresco y al abrigo de la luz. \nDatos adicionales: Cualquier medicación que esté tomando al momento de realizar el \nestudio debe ser comunicada cuando se entrega muestra.\nVersión: 01 (02/ENE/2026)	-	17	listo	108.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2810	BORREL-G	listo	2283	605	\N	559	1959	https://drive.google.com/file/d/1K6a_w068eSDoyjMy3TlF39OCSN378J63/view?usp=sharing	Ver MODELO DE INFORME	5	listo	1234.0	1	Laboratorio SBLab	Se modifico metodo en Datatech desde IFI a ELISA	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2811	BORREL-M	listo	2284	605	\N	559	1957	https://drive.google.com/file/d/14mSMjFzlPseaIRGwdqxVtMtXx6OiBW9r/view?usp=sharing	Ver MODELO DE INFORME	5	listo	1235.0	1	Laboratorio SBLab	Se modifico metodo en Datatech desde IFI a ELISA	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2812	C1INHIB	listo	2290	541	\N	559	1636	\N	15 a 35 mg/dl	3	listo	1803.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2813	CYFRA 21	listo	2295	629	\N	559	1878	\N	Menor a 3.2 ng/dl	4	listo	2257.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2814	CALCITO	listo	2305	615	\N	588	1830	\N	📋	3	listo	137.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2815	CHAPCR	listo	2339	679	\N	587	2001	https://drive.google.com/file/d/1DEq3GSi3ktYTLD2r-ye8Y2GEJBA4eim2/view?usp=sharing	Ver MODELO DE INFORME	12	listo	1486.0	1	Laboratorio SBLab	Agregar modelo de informe	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2816	ChlaPAg	listo	2340	609	\N	624	\N	https://drive.google.com/file/d/1TF6ToZbCMQCxonPwYMh5zgCM3xgLKiK4/view?usp=sharing	NO DETECTABLE	5	listo	2513.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2817	CMVPCR-M	listo	2351	609	\N	625	2016	https://drive.google.com/file/d/1R9g6IKF32cjG5uiVWEVxu-s-mpIctJtn/view?usp=sharing	NO DETECTABLE	4	listo	1543.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2818	C1	listo	2374	541	\N	559	\N	\N	10.0 a 20.0 mg/dl	4	listo	1802.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2819	PCR-ENTE	listo	2420	680	81	626	1970	https://drive.google.com/file/d/1ordOsqaUU2N-uxgceG8Nw6zv1Swr8_zH/view?usp=sharing	NO DETECTABLE	4	listo	1471.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2820	PANEL AC	listo	2431	641	\N	559	\N	https://drive.google.com/file/d/11lgE0HYwu0Nhrq2lYtZwYBYfXbnvdHKg/view?usp=sharing	-	21	listo	2818.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2821	PCRHELIC	listo	2493	609	81	627	\N	\N	-	10	revisar	1453.0	1	Laboratorio SBLab	No se genero en Hexalis. Revisar con un paciente de prueba. 22N 268188.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2822	H.C.H.	listo	2498	609	\N	587	\N	\N	NO DETECTABLE	6	listo	2450.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2823	HEV-RNA	listo	2518	680	81	628	\N	https://drive.google.com/file/d/1dhYcYy4iZIGriRaIO4NjnegFJHkFKVq9/view?usp=sharing	NO DETECTABLE	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2824	HERPES	listo	2523	609	\N	629	1939	https://drive.google.com/file/d/1AhIA_FzzkTX9i60rHVgDRptputX_awNF/view?usp=sharing	NO DETECTABLE	4	listo	1559.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2825	666222	pendiente	2207	605	\N	551	2112	LABORATORIO\nLuego de la extracción en tubos con EDTA, centrifugar 10 minutos a 2500 - 2700 rpm, separar el plasma inmediatamente y conservar refrigerado. Remitir inmediatamente.	Menor a 10.00 nM/l	16	listo	1996.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2826	PCR HIST	listo	2535	609	81	630	1996	https://drive.google.com/file/d/1oTCBQUADBXYn9DHwpZ6TQNoeL8AT5y8U/view?usp=sharing	NO DETECTABLE	9	listo	4408.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2827	HIVWB	listo	2540	681	\N	588	\N	https://drive.google.com/file/d/1G3-G_NyUk4KnYQUurQ7UFKEUPZd31PWS/view?usp=sharing	NEGATIVO	5	listo	1255.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2828	HLA-B51	listo	2543	682	\N	631	\N	\N	\N	38	listo	2268.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2829	DQ2 DQ8	listo	2544	609	\N	632	\N	https://drive.google.com/file/d/1kPrZnDkku82l5XUWN4iuRbionflN0q9e/view?usp=sharing	Ver MODELO DE INFORME	6	listo	7011.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2830	HLAB51	listo	2546	683	\N	631	\N	\N	NO DETECTABLE	6	listo	2714.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2831	PCRHTLV (41)	listo	2549	684	\N	633	2008	https://drive.google.com/file/d/1qtQhoVgoReYE0zAro-tgV-GpjdeV8pG2/view?usp=sharing	Ver MODELO DE INFORME	16	listo	7061.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2832	RAST CAL	listo	2561	634	\N	559	\N	\N	Ver MODELO DE INFORME	7	listo	560.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2833	RAST DCF	listo	2566	605	\N	559	\N	https://drive.google.com/file/d/1uNGQFk8g4m0SxSaEM8UjesjyrPIeHc3e/view?usp=sharing	Ver MODELO DE INFORME	15	listo	564.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2834	RAST IBP	listo	2568	605	\N	559	\N	https://drive.google.com/file/d/1bGu_48P7ooVY1-bDfl-niEZQ0VhxNhbU/view?usp=sharing	Ver MODELO DE INFORME	15	listo	564.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2835	RAST LAN	listo	2570	634	\N	559	\N	\N	Ver MODELO DE INFORME	7	listo	560.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2836	RAST MER	listo	2571	634	\N	559	\N	\N	Ver MODELO DE INFORME	7	listo	560.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2837	RAST PCT	listo	2572	605	\N	559	\N	https://drive.google.com/file/d/1B1x0MRHmY1n4Q9ZhfItAoDN8hwJfjKdC/view?usp=sharing	Ver MODELO DE INFORME	15	listo	564.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2838	PAI-BIOL	listo	2584	685	\N	634	1639	\N	9.4 - 26.3 AU/ml	13	listo	1825.0	1	Laboratorio SBLab	Se crea temporalmente en reemplazo del PAI-BIOL de LAHT. Se inactiva una vez se informe. 10/08/2026 SE INACTIVÓ	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2839	INTERL-6 (24)	listo	2606	615	\N	576	\N	\N	Menor a 0.7 pg/ml	3	listo	1533.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2840	MUSK	listo	2661	669	\N	559	\N	https://drive.google.com/file/d/1uVkkDTuFMtkbp6AHX8YaIByNjhmKUxnV/view?usp=sharing	NEGATIVO	13	listo	1520.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2841	MYCOGU	listo	2663	609	81	635	\N	https://drive.google.com/file/d/1E2mFjlHCMobO1SkqP8qKRVEh3RwuZ_m9/view?usp=sharing	Ver MODELO DE INFORME	9	listo	2934.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2842	MYCOPCR	listo	2664	609	81	636	\N	https://drive.google.com/file/d/1GHk8G8uAGJzBkIlHUsHsMnOJgcIc2hBM/view?usp=sharing	NO DETECTABLE	5	listo	2512.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2843	AC.POLIS (31)	listo	2669	605	\N	559	2107	https://drive.google.com/file/d/1eQbDn-7qIvCzlLiUPLzZVgGh7PDlndk8/view?usp=sharing	Ver MODELO DE INFORME	8	listo	1121.0	1	Laboratorio SBLab	Previamente se enviaba a TURNER	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2844	PANELHEP (37)	listo	2682	641	\N	559	2074	https://drive.google.com/file/d/1-3fLt2yVO22nZa5bJGfaq30LD4IudS0d/view?usp=sharing	Ver MODELO DE INFORME	7	listo	1938.0	1	Laboratorio SBLab	El nombre anterior era  PANEL DE ANTICUERPOS AUTOINMUNES HEPATICOS	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2845	PCR PARV	listo	2696	609	81	637	\N	https://drive.google.com/file/d/1T4nOwILSSxwZcJmgShpJ2eusSbjllyYj/view?usp=sharing	NO DETECTABLE	5	listo	2901.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2846	BK CUANT	listo	2712	609	81	638	1932	https://drive.google.com/file/d/1oSOutiKgjAp9KSxsM2nJVcOeC-lSS3L1/view?usp=sharing	NO DETECTABLE	5	listo	4211.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2847	BK CUALI	listo	2713	609	81	639	1931	https://drive.google.com/file/d/14fBzADdr-CNpxKsvJwKCutuhCiTXYPxl/view?usp=sharing	NO DETECTABLE	5	listo	4212.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2848	PREALB (16)	listo	2715	541	\N	559	\N	\N	20.0 a 40.0 mg/dl	4	listo	2285.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2849	PREECLAM (17)	listo	2716	629	87	559	\N	https://drive.google.com/file/d/1cGulIixm3Zngk-EPcIuBfHI_me9wdunS/view?usp=sharing	Ver MODELO DE INFORME	3	listo	2331.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2850	AC.RECOV (32)	listo	2736	605	\N	578	2075	https://drive.google.com/file/d/1epmZt2FUoTmQG3PVL4XmuvTE6rX5pM53/view?usp=sharing	Ver MODELO DE INFORME	10	listo	6784.0	1	Laboratorio SBLab	Se modifica el modelo de informe.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2851	RENINA (14)	listo	2737	634	96	581	1867	Determinación:\nRENINA-ANGIOTENSINA PLASMATICA\nMuestra: SANGRE.\nPreparación previa: Ayuno de 8 horas. No ingerir alcohol desde dos días antes de la prueba. Hay medicamentos que pueden alterar los resultados, de cualquier manera sólo debería suspender cualquier medicación que esté tomando si esa fue la indicación de su médico al prescribir los análisis.\nDe no existir alguna indicación médica con respecto al consumo de sal, se debe hacer una dieta balanceada y normal, sin restringir el consumo de sodio, durante 3 días previos a la toma de muestra. \nToma de muestra: Concurrir al laboratorio con 8 horas de ayuno, entre las 7:00 y 10:00 h. No ingerir alcohol desde dos días antes de la prueba. Si la orden médica indica posición "acostado" o supina, el paciente deberá permanecer acostado en el laboratorio 30 minutos antes de la extracción, si indica de pie, debe permanecer de pie (ya sea inmóvil o en movimiento) durante los 30 minutos inmediatamente anteriores a la extracción de sangre. En ambos casos, la extracción se realizará sentado. El estímulo será el indicado por el médico. \nDatos adicionales: Medicación habitual.\nVersión: 1.0 (12-JUN-2025)	\N	8	listo	2821.0	1	Laboratorio SBLab	Se configuro envio CONGELADO en el flujo de trabajo de AMS. 660812 SI	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2930	NEO-6	listo	2757	568	100	594	2161	https://drive.google.com/file/d/1s-hU3eg3rnUcs59233_Oqwn0XbZBkIpl/view?usp=sharing	Ver MODELO DE INFORME	13	listo	\N	1	Laboratorio SBLab	Se activa en Hexalis	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	62	\N
2968	PIV PCR	listo	2915	609	81	655	\N	\N	NO DETECTABLE	3	listo	\N	1	SIN ASIGNAR	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2852	REN (13)	listo	2738	634	96	581	\N	Determinación: RENINA, ACTIVIDAD\n\nPACIENTE\nMuestra: SANGRE.\nPreparación previa: Concurrir al laboratorio con 8 h de ayuno, entre las 7:00 y 10:00 h. No ingerir alcohol desde dos días antes de la prueba. Hay medicamentos que pueden alterar los resultados, de cualquier manera sólo debería suspender cualquier medicación que esté tomando si esa fue la indicación de su médico al prescribir los análisis. De no existir alguna indicación médica con respecto al consumo de sal, se debe hacer una dieta balanceada y normal, sin restringir el consumo de sodio, durante 3 días previos a la toma de muestra. \nToma de muestra: Si la orden médica indica posición "acostado" o supina, el paciente deberá permanecer acostado en el laboratorio 30 minutos antes de la extracción, si indica de pie, debe permanecer de pie (ya sea inmóvil o en movimiento) durante los 30 minutos inmediatamente anteriores a la extracción de sangre. En ambos casos, la extracción se realizará sentado. El estímulo será el indicado por el médico. \nDatos adicionales: Medicación habitual.\nVersión: 1.0 (12-JUN-2025)\n\nLABORATORIO\nLuego de la extracción en tubos con EDTA, centrifugar 10 minutos a 2500-2700 rpm, separar el plasma inmediatamente y conservar refrigerado. Remitir inmediatamente.	📋	8	listo	2725.0	1	Laboratorio SBLab	Se configuro envio CONGELADO en el flujo de trabajo de AMS. 660812 NO	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2853	ARET-IgA (33)	listo	2740	669	\N	559	\N	\N	NEGATIVO Título menor a 1/10	10	listo	2847.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2854	ANTI-RET (34)	listo	2742	605	\N	559	\N	https://drive.google.com/file/d/1wjAZsgz_hz0NLvS4_UAa84BCI7H7wra2/view?usp=sharing	Ver MODELO DE INFORME	10	revisar	6782.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2855	ANTI-RI (35)	listo	2743	628	\N	559	2072	https://drive.google.com/file/d/12cO7xNq9uTJH-5QxF3s4bB9CmWXrLV_B/view?usp=sharing	Ver MODELO DE INFORME	10	listo	1250.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2856	ANTI-RIB	listo	2744	641	\N	559	2056	\N	\N	14	listo	RIB	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2857	TTBLAS (21)	listo	2784	608	97	640	1739	\N	-	6	listo	995.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2858	DHT	listo	2787	605	\N	595	1848	\N	📋	35	listo	1123.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2859	TRICHPCR	listo	2823	609	81	641	2030	https://drive.google.com/file/d/1NkGANa7nuKw50mrrdXMCTfDAahxmzL6b/view?usp=sharing	Ver MODELO DE INFORME	11	listo	7044.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2860	PCRVARI	listo	2840	609	81	629	1975	https://drive.google.com/file/d/1Imveq6-8MdJEcoKO_rH03WEDZCa0qYTN/view?usp=sharing	NO DETECTABLE	4	listo	2603.0	1	Laboratorio SBLab	f	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2861	VIT-C	listo	2849	644	\N	559	2118	\N	4.0 a 20.0 mg/l	5	listo	1937.0	1	Laboratorio SBLab	S	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	54	\N
2862	ACIDO5	listo	2198	686	82	571	\N	Determinación: ACIDO 5 HIDROX-INDOL ACETICO URINARIO\n\nMuestra: ORINA 24h\n\nPreparación previa:\nDurante 3 días el paciente no debe ingerir: bananas, tomates, chocolate, cacao, vainilla, ni ningún alimento que los contenga (tortas, cremas, postres, helados, etc.). \nNo debe beber té, café, mate ni gaseosas. Debe realizar poco ejercicio físico. \n\nToma de muestra:\nAl cuarto día y continuando con la dieta, debe recolectar ORINA DE 24h. de la siguiente manera:\nEl día que inicia la recolección, puntualmente a las 8 h, o a la hora que usted elija (anótela....) orina en el inodoro, tratando de vaciar bien la vejiga,y desechando esa muestra. \nA partir de este momento, debe recolectar todas las muestras de orina del día y de la noche y toda la cantidad, en el colector para orina de 24 h de boca ancha, sin perder ninguna micción.\nDebe recolectar hasta las 8h del día siguiente o hasta la hora que usted eligió inclusive (anótela....)\nLas 24h se cuentan a partir del momento que se orina en el inodoro y se descarta la orina. Cumpla estrictamente los horarios de inicio y finalización de la recolección , y recoja TODO el volumen TODAS las veces que orine.\nRemita la muestra de su orina dentro de las 24h de finalizar su recolección. Consérvese en heladera.\n\nDatos adicionales: -\n\nVersión: 01 (01/JUN/2026)	2.00 a 9.00 mg/24h	8	listo	HI5	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	55	\N
2863	FOLI ERI	listo	2202	629	\N	642	\N	\N	523 a 1257 ng/ml	3	listo	AFE2	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	55	\N
2864	ADENOSIN	listo	2221	687	81	643	1792	https://drive.google.com/file/d/1oaRzdk6LgCo2CMnMh7sDMX5OtBu9ab2j/view?usp=sharing	Ver MODELO DE INFORME	8	listo	DEA	1	Laboratorio SBLab	20/08/2026 CBOFFELLI Se corrigen los valores de referencia de ADENOSIN (662417) en base a un nuevo resultado recibido de IBC.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	55	\N
2865	ARSE/S	listo	2261	688	\N	576	1780	\N	0.00 a 15.00 µg/l	15	listo	ARS	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	55	\N
2866	BUFO O	listo	2289	689	82	644	2136	https://drive.google.com/file/d/1FBAzQdf37jdi9D8GOHnIhEUv25AcVLkU/view?usp=sharing	1.00 a 8.90 µg%	17	listo	BUF	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	55	\N
2867	CAD-LIBR	listo	2299	541	\N	559	1751	https://drive.google.com/file/d/1N5jEk1eE8lEPJwMNmFJZYmW-HEuERkaS/view?usp=sharing	Ver MODELO DE INFORME	8	listo	KLSL	1	Laboratorio SBLab	Cambiar modelo de informe	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	55	\N
2868	TD-DIG	inactivo	2405	629	\N	559	2091	\N	📋	3	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	55	\N
2869	FENILE	listo	2446	648	82	644	\N	PACIENTE\n\nMuestra: ORINA DE 24 HORAS.\nPreparación previa:\nDebe recolectarse con DIETA previa: durante tres días previos a la recolección de la muestra no ingerir bananas, tomates, chocolate, cacao, vainilla, ni ningún alimento que los contenga (tortas, cremas, postres, helados, etc.). \nNo debe beber té, café, mate ni gaseosas. Debe realizar poco ejercicio físico. \n\nToma de muestra:\nHacer durante tres días la dieta indicada. Al cuarto día y continuando con la dieta, recolectar la orina de 24h:\nA las 07:00 h orinar y descartar esa orina. \nA partir de ese momento deben recolectarse TODAS las orinas en su totalidad durante todo el día y hasta las 07:00 h del día siguiente inclusive en un brocal.\nMantener refrigerada hasta el momento de llevarla al laboratorio. \nRemitir la muestra dentro de las 24h de completada la recolección.\n\nLABORATORIO\nRemitir al menos 300 ml de orina refrigerada.	130.00 a 450.00 µg/24h	17	listo	FEA	1	Laboratorio SBLab	Falta configurar indicaciones al paciente	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	55	\N
2870	GPX	inactivo	2488	647	\N	589	\N	\N	4171 a 10881 U/l	16	listo	GPX	1	Laboratorio SBLab	desactivada momentáneamente por falta de reactivo 24/07/26	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	55	\N
2871	INHIBINA	listo	2585	690	\N	559	\N	\N	📋	45	listo	INH	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	55	\N
2872	IFS	listo	2588	691	\N	559	1748	\N	-	11	listo	IFS	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	55	\N
2931	NEO-7	listo	2759	568	100	594	2162	https://drive.google.com/file/d/1sVIkY79biJwDeXA9NDVJanL8YWlZJoBk/view?usp=sharing	Ver MODELO DE INFORME	13	listo	\N	1	Laboratorio SBLab	Se corrige nombre en Datatech, dado que daba lugar a confusion respecto al SCREENING NEONATAL	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	62	\N
2967	HPV PCR	listo	2684	609	81	667	2029	\N	NO DETECTABLE	21	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2873	IFO	listo	2589	691	82	645	1754	Determinación: INMUNOFIJACION URINARIA\nMuestras: ORINA DE 24 HORAS.\nPreparación previa: No requiere.\nToma de muestra: El día previo a concurrir al laboratorio comenzar con la recolección de la ORINA DE 24h.\n- Vaciar completamente su vejiga (orinar en el inodoro y desechar esa primera muestra) a las 8 horas o la hora que elija.\n- Anotar la hora de descarte para tomarla como hora de inicio.\n- Recolectar TODAS las micciones de orina del día hasta la primera del siguiente día inclusive, que coincida con la hora de inicio dentro de un recipiente limpio de boca ancha. No perder ninguna muestra de orina.\n- Conservar en heladera hasta su entrega.\nDatos adicionales: No aplica.\nVersión: 1.0 (15-SEP-2025)	-	11	listo	IFO	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	55	\N
2874	MF-FQM	listo	2640	692	\N	646	\N	https://drive.google.com/file/d/1468432z-m3X5ojqcKUOhu3NkWjnjTL0n/view?usp=sharing	-	4	listo	FMF	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	55	\N
2875	MIOGOR	listo	2654	693	\N	647	\N	\N	NEGATIVO	3	listo	MIO	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	55	\N
2876	ANTI-RIB	listo	2744	641	\N	559	2056	\N	NEGATIVO	14	listo	RIB	1	Laboratorio SBLab	Previamente se enviaba a CIBIC,  pero este ya no lo procesa.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	55	\N
2877	SEROPLA	inactivo	2761	644	\N	648	2135	Determinación: SEROTONINA PLAQUETARIA\nMuestra: SANGRE\nPreparación previa:\nDurante 4 días no ingerir bananas, palta, berenjenas, ananás, ciruelas y nueces.\nEvitar la ingesta de drogas inhibidoras de la monoaminooxidasa -  Isocarboxazida (Marplan), fenelzina (Nardil), tranilcipromina (Parnate), Selegilina (Eldepryl, Zelapar), rasagilina (Azilect), safinamida (Xadago) - por lo menos 7 días antes de la toma de la muestra. No suspender la medicación sin antes contactar a su médico.\nSe requieren 8 horas de ayuno. \nToma de muestra: Punción venosa.\nDatos adicionales: Informar el nombre de los medicamentos que recibe.\nVersión: 01 (01/AGO/2025)	📋	11	listo	SER	1	Laboratorio SBLab	Alta: 16/09/2025. Baja: 11/11/2025	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	55	\N
2878	TOXIGA	listo	2805	669	\N	559	1942	https://drive.google.com/file/d/12m6PgiCqG9pp_-Mi_8J82VLMEb4ym9qK/view?usp=sharing	NEGATIVO	6	listo	TOXOA	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	55	\N
2879	TOXO-AVI	listo	2807	629	\N	595	1945	https://drive.google.com/file/d/1dGnNNLZDdppK4TJaeg5bBE3DOiDnKo1Z/view?usp=sharing	Ver MODELO DE INFORME	6	listo	TOXA3	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	55	\N
2880	ADENO AG	listo	2226	694	81	649	1950	https://drive.google.com/file/d/1LRjjcH50b96fixJb79G0tMIqHlgpfqjF/view?usp=sharing	NEGATIVO	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	56	\N
2881	BORDET	listo	2277	695	81	650	2025	https://drive.google.com/file/d/1q_KKmXibmb7Z0_VY5CY-3XVV6EGhoC14/view?usp=sharing	NO DETECTABLE	6	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	56	\N
2882	BORM-IFI	listo	2282	669	\N	559	1955	\N	NEGATIVO	3	listo	16407.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	56	\N
2883	AC.ENTER	listo	2421	669	\N	559	1969	https://drive.google.com/file/d/1Zl10q7NR3kGh0AR05DZyqrjsR87DyTwH/view?usp=sharing	NEGATIVO	3	listo	2029.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	56	\N
2884	HISTO G	listo	2536	696	\N	559	1994	\N	NEGATIVO	10	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	56	\N
2885	INFLU AG	listo	2578	694	81	649	1980	https://drive.google.com/file/d/1zherE7E9oWEjNBVlMnQagNaYTAfLeR39/view?usp=sharing	NEGATIVO	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	56	\N
2886	INF B Ag	listo	2582	694	81	649	\N	https://drive.google.com/file/d/1IfmNz4qYuGOJLf_FAB2Rfw5W9xOTQHuo/view?usp=sharing	NEGATIVO	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	56	\N
2887	METAPNEU	listo	2647	694	81	649	\N	https://drive.google.com/file/d/1Oxz7Zcu7dEwxn4frNqdVwgL5K_cJQYh_/view?usp=sharing	NEGATIVO	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	56	\N
2888	PREPCR	listo	2886	609	81	649	\N	\N	NEGATIVO	3	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	56	\N
2889	662745A	inactivo	2683	694	81	649	\N	https://drive.google.com/file/d/1dkOIiwTz9ARnVs2baxlDcHby6KJpQLXU/view?usp=sharing	NEGATIVO	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	56	\N
2890	PRVPCR	listo	2887	609	81	649	\N	\N	NEGATIVO	0	pendiente	\N	1	SIN ASIGNAR	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	56	\N
2891	PINFI  g	listo	2688	694	81	649	1985	https://drive.google.com/file/d/1i6zww08VbG6qif_XHkN3o2mUZiZyUkqM/view?usp=sharing	NEGATIVO	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	56	\N
2892	PINFII g	listo	2689	694	81	649	1986	https://drive.google.com/file/d/1hIU0oiTEZ2ONvI2sHv9LpkogvkVuE8wN/view?usp=sharing	NEGATIVO	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	56	\N
2893	PINFIIIg	listo	2692	694	81	649	1989	https://drive.google.com/file/d/1JYtwU7iim5Wn-ChkL3vgvrBuE09m62Sb/view?usp=sharing	NEGATIVO	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	56	\N
2894	POSACONA	listo	2714	644	\N	559	2089	https://drive.google.com/file/d/1jGiJ3unURTdpavSruTz972XL3lF_B0GK/view?usp=sharing	Ver MODELO DE INFORME	12	listo	42971.0	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	56	\N
2895	VSR Ag	listo	2765	694	81	649	1953	https://drive.google.com/file/d/1AI2CTT-q0ZupDDO23cmKqnfvpNKYTfSb/view?usp=sharing	NEGATIVO	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	56	\N
2896	VORICO	listo	2852	644	\N	576	\N	\N	Rango Terapeútico: 1.5 - 5.0 µg/ml	10	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	56	\N
2897	NA	pendiente	2888	\N	\N	559	\N	\N	\N	2	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	57	\N
2898	000614	pendiente	2889	\N	\N	587	\N	\N	Ver MODELO DE INFORME	1	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	57	\N
2899	660184	pendiente	2890	\N	\N	587	\N	\N	\N	2	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	57	\N
2900	HISTO-AG	listo	2534	560	\N	548	1995	\N	NEGATIVO	5	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	58	\N
2901	HANTAPCR	listo	2891	609	98	651	\N	\N	NO DETECTABLE	5	listo	HANPCR	1	Laboratorio SBLab	Cambio de codigo en Hexalis.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	59	\N
2902	LEPTO	listo	2892	697	98	576	\N	\N	NO REACTIVO	3	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	59	\N
2903	LEPTOM	listo	2893	605	98	576	\N	\N	NO REACTIVO	3	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	59	\N
2904	LEPTOSV	listo	2883	698	98	576	\N	\N	NEGATIVO	7	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	59	\N
2905	F.H.A.	listo	2894	609	98	652	\N	\N	NO DETECTABLE	15	listo	830FHA	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	59	\N
2906	LEPPCR	listo	2895	609	98	651	\N	\N	NO DETECTABLE	10	listo	LEPPCR	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	59	\N
2907	HANTA	listo	2896	605	98	576	\N	\N	\N	15	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	59	\N
2908	DEN-SERO	listo	2897	699	98	576	\N	\N	NO DETECTABLE	8	listo	DENPCR	1	Laboratorio SBLab	Se crea en HexaLIS y Datatech	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	59	\N
2966	PVR	listo	2914	609	81	666	\N	\N	NO DETECTABLE	4	listo	\N	1	Hematologia SBLab	ADJUNTAR MODELO DE INFORME - AGREGAR AL AREA GENERAL	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2909	CAR ABOR	discontinuado	2314	654	\N	605	1891	LABORATORIO\n\nTOMA DE MUESTRA DE MATERIAL DE ABORTO\na) Extracción: \n- Cuando hacen legrado el médico debe tomar una porción de la zona de vellosidades de la placenta o de lo que va a dar origen a la placenta y enviarlo a las condiciones más estériles posibles, por lo general en un recipiente estéril de urocultivo.\n\nb) Conservación y envío:\n- La muestra deber ser enviada en el mismo recipiente en que se realizó la extracción, sin trasvasar y a temperatura ambiente (o con refrigerante). No debe transportarse con hielo seco.\nMantener en la heladera hasta el momento del envío.\n\nLa muestra debe enviarse en el menor tiempo posible luego de su extracción para asegurar la viabilidad de las células.\nNo remitir muestras los días viernes.	-	63	listo	\N	1	Laboratorio SBLab	Los derivantes no deberian remitir las muestras los dias viernes. Se aumenta el tiempo de demora de 21 a 63 dias. 03/07/2026: Se envia a TURNER.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	60	\N
2910	CARIO AL	discontinuado	2317	654	\N	607	1893	LABORATORIO\n\nTOMA DE MUESTRA DE SANGRE PERIFERICA PARA ESTUDIO CITOGENETICO\na) Extracción: \n- Colocar en una jeringa de 5 ml o 10 ml Heparina sódica ESTERIL (0,05 a 0,10 ml aproximadamente).\n- Cambiar la aguja y extraer preferentemente entre 4 y 5 ml de sangre venosa en niños , en caso de bebes puede ser menos ( en lo posible al menos 2ml) y\nentre 8 a 10 ml en adultos. Evite maniobras que impidan la conservación de la\nmuestra en condiciones de estricta esterilidad.\n- Colocar inmediatamente el capuchón en la aguja, o colocar una aguja nueva\nimpidiendo el contacto de la muestra con el aire. No doblar la aguja ni taparla\ncon otros elementos como tapones de goma, gasas, algodón, no estériles. Fijar\nel émbolo y aguja o tapón estéril con cinta adhesiva.\n\nb) Conservación y envío:\n- La muestra deber ser enviada en la misma jeringa en que se realizó la extracción, sin trasvasar y a temperatura ambiente (o con refrigerante). No debe transportarse con hielo seco.\nMantener en la heladera hasta el momento del envío.\nc) También es posible realizar la extracción en tubos vacuteiner con heparina sódica y enviarlos en los mismos.\n\nLa muestra debe enviarse en el menor tiempo posible luego de su extracción para asegurar la viabilidad de las células.\nNo remitir muestras los días viernes.	-	61	listo	\N	1	Laboratorio SBLab	Los derivantes no deberian remitir las muestras los dias viernes. 03/07/2026: Se envia a TURNER.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	60	\N
2911	CARIOTIP	discontinuado	2316	654	\N	607	1889	LABORATORIO\n\nTOMA DE MUESTRA DE SANGRE PERIFERICA PARA ESTUDIO CITOGENETICO\na) Extracción: \n- Colocar en una jeringa de 5 ml o 10 ml Heparina sódica ESTERIL (0,05 a 0,10 ml aproximadamente).\n- Cambiar la aguja y extraer preferentemente entre 4 y 5 ml de sangre venosa en niños , en caso de bebes puede ser menos ( en lo posible al menos 2ml) y\nentre 8 a 10 ml en adultos. Evite maniobras que impidan la conservación de la\nmuestra en condiciones de estricta esterilidad.\n- Colocar inmediatamente el capuchón en la aguja, o colocar una aguja nueva\nimpidiendo el contacto de la muestra con el aire. No doblar la aguja ni taparla\ncon otros elementos como tapones de goma, gasas, algodón, no estériles. Fijar\nel émbolo y aguja o tapón estéril con cinta adhesiva.\n\nb) Conservación y envío:\n- La muestra deber ser enviada en la misma jeringa en que se realizó la \nextracción, sin trasvasar y a temperatura ambiente (o con refrigerante). No\ndebe transportarse con hielo seco.\nMantener en la heladera hasta el momento del envío.\nc) También es posible realizar la extracción en tubos vacuteiner con heparina sódica y enviarlos en los mismos.\n\nLa muestra debe enviarse en el menor tiempo posible luego de su extracción para asegurar la viabilidad de las células.\nNo remitir muestras los días viernes.	-	63	listo	\N	1	Laboratorio SBLab	Los derivantes no deberian remitir las muestras los dias viernes. Se aumenta el tiempo de demora de 21 a 63 dias. 03/07/2026: Se envia a TURNER.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	60	\N
2912	CITOGEN	discontinuado	2315	654	\N	606	1890	LABORATORIO\n\nTOMA DE MUESTRA DE MEDULA OSEA PARA ESTUDIO CITOGENETICO\na) Extracción: \n- Colocar en una jeringa de 5 ml Heparina sódica ESTERIL (0,05 a 0,10 ml aproximadamente). \n- Extraer al menos 2 ml de MEDULA OSEA. Para citogenética está indicado que se debe mandar la primera o segunda porción de extracción. Evite maniobras que impidan la conservación de la\nmuestra en condiciones de estricta esterilidad.\n- Colocar inmediatamente el capuchón en la aguja, o colocar una aguja nueva impidiendo el contacto de la muestra con el aire. No doblar la aguja ni taparla\ncon otros elementos como tapones de goma, gasas, algodón, no estériles. Fijar el émbolo y aguja o tapón estéril con cinta adhesiva.\n\nb) Conservación y envío:\n- La muestra deber ser enviada en la misma jeringa en que se realizó la extracción, sin trasvasar y a temperatura ambiente (o con refrigerante). No debe transportarse con hielo seco.\nMantener en la heladera hasta el momento del envío.\nc) También es posible realizar la extracción en tubos vacutainer con heparina sódica y enviarlos en los mismos.\n\nLa muestra debe enviarse en el menor tiempo posible luego de su extracción para asegurar la viabilidad de las células.\nNo remitir muestras los días viernes.	-	21	verificado	\N	1	Laboratorio SBLab	Los derivantes no deberian remitir las muestras los dias viernes. 03/07/2026: Se envia a TURNER.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	60	\N
2913	CAR LAM	discontinuado	2313	654	\N	604	1892	https://drive.google.com/file/d/1ccZ0fbrjBFdRTob6zP_8eYYbdZKJCgc2/view?usp=sharing	-	35	listo	\N	1	Laboratorio SBLab	Los derivantes no deberian remitir las muestras los dias viernes. 03/07/2026: Se envia a TURNER.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	60	\N
2914	FAC XIII	listo	2898	700	99	653	\N	\N	50 a 150 %	8	revisar	\N	1	Laboratorio SBLab	Faltan valores de referencia en Hexalis y Datatech	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	61	\N
2915	FACT II	listo	2899	\N	99	654	\N	\N	\N	0	pendiente	\N	1	SIN ASIGNAR	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	61	\N
2916	FACT IX	listo	2900	\N	99	653	\N	\N	70 a 120 %	0	pendiente	\N	1	SIN ASIGNAR	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	61	\N
2917	FACT V	listo	2901	\N	99	654	\N	\N	70 a 120 %	0	pendiente	\N	1	SIN ASIGNAR	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	61	\N
2918	FACT VII	listo	2902	701	99	654	\N	\N	\N	0	pendiente	\N	1	SIN ASIGNAR	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	61	\N
2919	FACT VW	listo	2903	702	99	653	\N	\N	📋	8	listo	\N	1	SIN ASIGNAR	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	61	\N
2920	FACT XI	listo	2904	\N	99	654	\N	\N	\N	0	pendiente	\N	1	SIN ASIGNAR	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	61	\N
2921	FACTOR X	listo	2905	\N	99	653	\N	\N	\N	0	pendiente	\N	1	SIN ASIGNAR	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	61	\N
2922	FACTVIII	listo	2906	701	99	653	\N	\N	50 a 150 %	0	pendiente	\N	1	SIN ASIGNAR	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	61	\N
2923	INH VIII	listo	2907	\N	99	653	\N	\N	\N	0	pendiente	\N	1	SIN ASIGNAR	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	61	\N
2924	PAI-BIOL	discontinuado	2584	\N	\N	\N	1639	\N	\N	0	listo	\N	1	SIN ASIGNAR	No se procesa mas en LAHT. Se pasa a CIBIC.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	61	\N
2925	PR S TOT	listo	2908	\N	99	654	\N	\N	\N	0	pendiente	\N	1	SIN ASIGNAR	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	61	\N
2926	PROT S	listo	2909	\N	99	654	\N	\N	\N	0	pendiente	\N	1	SIN ASIGNAR	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	61	\N
2927	RISTOCET	listo	2910	703	99	653	\N	\N	50 - 150 %	8	listo	\N	1	Laboratorio SBLab	Falta adjuntar el modelo de informe.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	61	\N
2928	CORRTP	listo	2809	538	99	511	1625	\N	\N	3	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	61	\N
2929	CORRKPTT	listo	2619	538	99	511	1627	\N	\N	3	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	61	\N
2932	GAL/NEO	listo	2467	704	100	594	2164	LABORATORIO\nColectar las muestras de sangre después de cumplidas 24 h. de ingesta de leche conteniendo lactosa (calostro, leche humana madura o leches maternizadas), y antes de superado el 5° día de vida. \nSi el niño es dado de alta antes de cumplir el tiempo mínimo de\ningesta de leche requerido, se debe colectar la muestra inmediatamente antes del alta sin tener en cuenta su estado alimentario y colectar una segunda muestra una vez cumplimentadas las 24 h. de\ningesta de leche conteniendo lactosa. \nNo utilizar anticoagulantes como EDTA, Citrato u Oxalato.\nCompletar todos los datos solicitados en la tarjeta de recolección de muestras con bolígrafo y con letra clara y legible.\nAsegurarse que la impregnación del papel es correcta. En caso contrario proceder inmediatamente a tomar una nueva muestra de calidad satisfactoria antes de proceder a su envío.	0.00 a 8.00 mg/dl	10	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	62	\N
2933	E.N.N.	listo	2758	655	100	594	\N	https://drive.google.com/file/d/1Xf_fW7sRiXJq9Kv3WXFefSN41xssqsqw/view?usp=sharing	Ver MODELO DE INFORME	26	listo	\N	1	Laboratorio SBLab	El nombre en Datatech continua siendo ESTUDIO NEUROMETABOLICO NEONATAL	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	62	\N
2934	ADV	listo	2222	609	81	655	\N	https://drive.google.com/file/d/1YIBHucnIsDS8OkJvut_1-f4x_zmt-CpK/view?usp=sharing	NO DETECTABLE	3	listo	\N	1	Hematologia SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2935	aRNr	listo	2227	609	81	656	2009	https://drive.google.com/file/d/1U9e0JkUm1-PaLNy5AmaSxdZVqY3djrCe/view?usp=sharing	NO DETECTABLE	11	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2936	CLAMIPCR	listo	2345	609	81	657	2026	https://drive.google.com/file/d/1eXZ9tcsWXfOy2Pi1ZLYmE5spveyp-xDw/view?usp=sharing	NO DETECTABLE	5	listo	\N	1	Hematologia SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2937	CMV-LCR	listo	2350	609	\N	658	\N	https://drive.google.com/file/d/1JMDPgHwztb6jkSd7DPA-kSZZKjiGK6ni/view?usp=sharing	NO DETECTABLE	4	listo	\N	1	Hematologia SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2938	CMVPCR-O	listo	2352	609	\N	659	2015	https://drive.google.com/file/d/10OXEpfI74Nu-BpkTor28zoAVEQLPgj5f/view?usp=sharing	NO DETECTABLE	4	listo	\N	1	Hematologia SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2939	CMV-OR	listo	2353	609	\N	659	2017	\N	NO DETECTABLE	4	listo	\N	1	Laboratorio SBLab	Se cambia el nombre desde CMV EN ORINA CUANTITATIVO - PCR	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2940	PCR CMV	listo	2354	609	\N	581	2014	https://drive.google.com/file/d/1EZJzcfnHXPGF9zEl_7Bz0lcYhrS0COrZ/view?usp=sharing	NO DETECTABLE	4	listo	\N	1	Laboratorio SBLab	Se cambia el nombre desde CMV CUALTITATIVO - PCR. 26/06/2026: Se cambia el nombre desde CITOMEGALOVIRUS EN SANGRE, ADN POR PCR (CUALITATIVO)	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2941	CMV PCR	listo	2357	609	\N	581	2013	https://drive.google.com/file/d/1yciQ-hUbbuozBgeUIykpcJGHHEDx5jlq/view?usp=sharing	NO DETECTABLE	4	listo	\N	1	Laboratorio SBLab	Se cambia el nombre desde CMV CUANTITATIVO - PCR. 23/07/2026 Se agrega la determinacion 5. Valor hallado en logs.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2942	CMV NEO	listo	2911	705	\N	660	\N	\N	NO DETECTABLE	7	listo	\N	1	SIN ASIGNAR	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2943	PCRCOR	listo	2378	609	\N	661	2012	https://drive.google.com/file/d/1qg-HSsotXNNmSqj-DtNSIT4BhqaNzCcj/view?usp=sharing	NO DETECTABLE	4	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2944	PCR DENG	listo	2401	680	\N	581	2018	https://drive.google.com/file/d/1EzDqNny0U2sL1sSLCkAK1m09xOClu5px/view?usp=sharing	NO DETECTABLE	4	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2945	EBV-LCR	listo	2424	609	\N	658	\N	\N	NO DETECTABLE	4	listo	\N	1	Hematologia SBLab	Falta paridad	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2946	EBV-PCR	listo	2427	609	\N	662	2032	https://drive.google.com/file/d/1THf1FHzpVVu3rdMkpVu2-k-tR6EX_dz0/view?usp=sharing	NO DETECTABLE	5	listo	\N	1	Laboratorio SBLab	Carga manual de resultado pre-analítico: TIPO DE MUESTRA.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2947	PCR-EBV	listo	2428	609	81	663	2031	https://drive.google.com/file/d/1VYGeThHrcLDpGizzK_9CMLdeFxp5wKhN/view?usp=sharing	NO DETECTABLE	5	listo	\N	1	Laboratorio SBLab	Carga manual de resultado pre-analítico: TIPO DE MUESTRA (LCR o SANGRE ENTERA)	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2948	FACTOR V	listo	2443	609	\N	582	1648	\N	NO DETECTABLE	26	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2949	HBV PCR	listo	2511	609	\N	662	2020	https://drive.google.com/file/d/1j7L813Bjza4zyJhj-AQtA4ag3Vff1s_7/view?usp=sharing	NO DETECTABLE	4	listo	\N	1	Laboratorio SBLab	Se cambia el nombre desde HBV - PCR CUALITATIVA	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2950	PCR HBV	listo	2514	609	\N	662	2019	\N	NO DETECTABLE	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2951	HCVPCR	listo	2516	609	\N	662	2021	\N	NO DETECTABLE	16	listo	\N	1	Laboratorio SBLab	Se cambia el nombre desde DETECCION DEL VIRUS DE HEPATITIS C	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2952	HEPCCV	listo	2517	609	\N	662	2022	\N	NO DETECTABLE	8	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2953	HSVLCR	listo	2522	609	\N	664	\N	https://drive.google.com/file/d/1xu3gWBX82v-ECnE0OULKGg0HnE70c4jJ/view?usp=sharing	NO DETECTABLE	5	listo	\N	1	Hematologia SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2954	HIVCV	listo	2537	609	\N	662	2010	\N	NO DETECTABLE	10	listo	\N	1	Laboratorio SBLab	Cambio de factor de conversion de UI/ml a copias/ml	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2955	HIV PCR	listo	2538	609	\N	662	2011	\N	NO DETECTABLE	8	listo	\N	1	Laboratorio SBLab	Cambio de factor de conversion de UI/ml a copias/ml	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2956	HLAB27	listo	2545	609	\N	582	2079	\N	NO DETECTABLE	16	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2957	INFLUPCR	inactivo	2912	680	81	649	\N	\N	NO DETECTABLE	3	pendiente	\N	1	coordinacionsblab@sanbritanico.com.ar	Se inactiva. A partir de este dia se piden individualmente.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2958	INFP	listo	2579	609	81	665	2023	\N	NO DETECTABLE	3	listo	\N	1	Laboratorio SBLab	Reemplaza a la prueba INFLUENZA A + B, DETECCION POR PCR, que se inactiva.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2959	INFB-RNA	listo	2583	680	81	665	2024	\N	NO DETECTABLE	3	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2960	JAK2	listo	2614	706	\N	582	2159	\N	NO DETECTABLE	15	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2961	HMPV PCR	listo	2646	609	81	655	\N	https://drive.google.com/file/d/18GPmMev4gcqCxfNc6eqyVRMX7fqvTSeK/view?usp=sharing	NO DETECTABLE	3	listo	\N	1	SIN ASIGNAR	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2962	MYCO- RT	listo	2662	609	81	657	2028	https://drive.google.com/file/d/1f46b19yT3_XBH4lamBakADYjXKrErqoZ/view?usp=sharing	NO DETECTABLE	4	listo	\N	1	Hematologia SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2963	GONOPCR	listo	2668	609	81	657	2027	https://drive.google.com/file/d/1G0TWQ38mDIZrj6-VoF6tX20KQqo4kFnF/view?usp=sharing	NO DETECTABLE	4	listo	\N	1	Hematologia SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2964	PAI	listo	2680	683	\N	582	1650	\N	\N	16	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2965	PRVS	listo	2913	609	81	666	\N	\N	NO DETECTABLE	4	listo	\N	1	Hematologia SBLab	ADJUNTAR MODELO DE INFORME - AGREGAR AL AREA GENERAL	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2969	NEUJI	listo	2710	609	\N	668	1965	https://drive.google.com/file/d/1j4cTRdy2gSOXY501h_VqWUTTQAgVoubc/view?usp=sharing	NO DETECTABLE	4	listo	\N	1	Hematologia SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2970	PNEUMOJI	listo	2711	609	\N	668	\N	https://drive.google.com/file/d/1kTGRBjzr5xXNkeDYAKfz4lkv1uNXgsgP/view?usp=sharing	NO DETECTABLE	4	listo	\N	1	SIN ASIGNAR	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2971	PT2021	listo	2731	609	\N	582	1649	\N	NO DETECTABLE	26	listo	\N	1	Laboratorio SBLab	Se cambia el nombre desde MUTACION EN GEN PROTROMBINA 20210	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2972	VZVLCR	listo	2841	609	\N	664	\N	https://drive.google.com/file/d/14JWRcbTrf5nxcdKJFLuB9I6lXCiEI6aX/view?usp=sharing	NO DETECTABLE	5	listo	\N	1	Hematologia SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2973	VSP	listo	2844	609	81	669	2033	LABORATORIO\nMuestra en al menos 2 ml de SHIELD 1X.	NO DETECTABLE	3	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	63	\N
2974	CRYCUANT	pendiente	2916	707	81	670	\N	\N	NO DETECTABLE	3	listo	\N	1	Laboratorio SBLab	\N	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	64	\N
2975	NEUJI	discontinuado	2710	609	81	671	1965	Tipo de muestra: ESPUTO Higiene previa: - Cepillar los dientes - Retirar prótesis, si posee - Hacer buches con agua. Recoleccion: - Toser profundamente y recolectar flema en frasco estéril, solamente expectoración bronquial profunda (flema). No saliva. Recolectar primer esputo de la mañana. - Cerrar el envase, rotular y llevar inmediatamente al Laboratorio.	NO DETECTABLE	8	listo	1485.0	1	Laboratorio SBLab	Se envia a CIBIC. 14/08/2026 Se comienza a procesar en BMSB.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	64	\N
2976	GALACT	listo	2917	708	\N	672	\N	\N	-	3	listo	\N	1	Laboratorio SBLab	Congelar la muestra hasta procesarla en el tubo primario.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	64	\N
2977	GALACTAG	inactivo	2918	605	\N	672	\N	\N	-	8	listo	\N	1	Laboratorio SBLab	Congelar la muestra hasta procesarla en el tubo primario.	2026-08-24 14:57:54.97231-03	2026-08-24 14:57:54.97231-03	64	\N
2234	FOLICO	listo	2201	532	\N	505	1761		3.1 a 20.0 ng/ml	1	listo		1	Laboratorio SBLab		2026-08-24 14:57:54.97231-03	2026-08-24 18:10:35.716527-03	49	\N
\.


--
-- Data for Name: estudio_colega_modelo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.estudio_colega_modelo (id, id_estudio_colega, nombre_archivo, contenido, tamanio_bytes, created_at) FROM stdin;
\.


--
-- Data for Name: estudio_colega_muestra; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.estudio_colega_muestra (id, id_estudio_colega, id_tipo_muestra, id_aditivo, volumen, id_unidad_medida, id_recipiente, id_modalidad_recoleccion, id_tecnica_recoleccion, id_conservacion, id_condicion_especial, id_prioridad_envio, created_at, orden, observacion) FROM stdin;
180	2235	23	4	2.00	2	\N	\N	\N	2	2	1	2026-09-01 18:09:54.273131-03	1	\N
187	2236	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
232	2237	2	\N	\N	\N	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
188	2238	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
189	2239	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
233	2240	15	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
190	2241	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
234	2242	3	3	2.00	2	\N	\N	\N	3	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
235	2243	3	2	2.00	2	\N	\N	\N	3	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
236	2244	1	\N	2.00	2	\N	\N	\N	3	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
237	2245	1	\N	2.00	2	\N	\N	\N	3	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
238	2246	1	\N	2.00	2	\N	\N	\N	3	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
239	2247	1	\N	2.00	2	\N	\N	\N	3	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
240	2248	1	\N	2.00	2	\N	\N	\N	3	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
245	2249	3	1	2.00	2	\N	\N	\N	3	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
191	2250	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
192	2251	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
193	2252	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
194	2253	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
181	2254	23	4	2.00	2	\N	\N	\N	2	2	1	2026-09-01 18:09:54.273131-03	1	\N
195	2255	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
196	2256	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
197	2257	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
198	2258	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
199	2259	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
249	2260	2	\N	10.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
182	2261	23	4	2.00	2	\N	\N	\N	2	2	1	2026-09-01 18:09:54.273131-03	1	\N
200	2262	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
250	2263	2	\N	\N	\N	\N	\N	\N	2	1	\N	2026-09-01 18:09:54.273131-03	1	\N
251	2264	18	\N	\N	\N	\N	\N	\N	1	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
183	2265	23	4	2.00	2	\N	\N	\N	2	2	1	2026-09-01 18:09:54.273131-03	1	\N
201	2266	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
241	2267	1	\N	2.00	2	\N	\N	\N	3	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
184	2268	23	4	2.00	2	\N	\N	\N	2	2	1	2026-09-01 18:09:54.273131-03	1	\N
252	2269	2	\N	\N	\N	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
202	2270	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
242	2271	1	\N	2.00	2	\N	\N	\N	3	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
203	2272	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
204	2273	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
205	2274	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
254	2275	23	3	3.00	2	\N	\N	\N	1	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
255	2276	23	1	3.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
206	2277	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
207	2278	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
208	2279	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
209	2280	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
210	2281	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
211	2282	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
212	2283	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
213	2284	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
214	2285	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
215	2286	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
216	2287	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
217	2288	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
256	2289	12	\N	1.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
218	2290	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
219	2291	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
257	2292	15	3	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
253	2293	2	\N	\N	\N	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
220	2294	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
258	2295	2	\N	10.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
260	2296	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
261	2297	23	\N	\N	\N	\N	\N	\N	1	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
243	2298	1	\N	2.00	2	\N	\N	\N	3	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
221	2299	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
222	2300	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
246	2301	3	1	2.00	2	\N	\N	\N	3	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
262	2302	2	\N	10.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
223	2303	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
224	2304	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
263	2305	23	3	3.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
185	2306	23	4	2.00	2	\N	\N	\N	2	2	1	2026-09-01 18:09:54.273131-03	1	\N
186	2307	23	4	2.00	2	\N	\N	\N	2	2	1	2026-09-01 18:09:54.273131-03	1	\N
225	2308	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
264	2309	23	3	2.50	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
247	2310	3	1	2.00	2	\N	\N	\N	3	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
244	2311	1	\N	2.00	2	\N	\N	\N	3	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
226	2312	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
227	2313	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
248	2314	3	1	2.00	2	\N	\N	\N	3	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
265	2315	24	\N	\N	\N	\N	\N	\N	1	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
228	2316	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
229	2317	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
259	2318	2	\N	10.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
266	2319	2	\N	10.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
267	2320	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
230	2321	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
231	2322	1	\N	2.00	2	\N	\N	\N	2	\N	\N	2026-09-01 18:09:54.273131-03	1	\N
\.


--
-- Data for Name: estudio_colega_muestra_alternativa; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.estudio_colega_muestra_alternativa (id, id_estudio_colega_muestra, id_tipo_muestra, id_aditivo, volumen, id_unidad_medida, id_recipiente, id_modalidad_recoleccion, id_tecnica_recoleccion, id_conservacion, id_condicion_especial, id_prioridad_envio, orden, observacion, created_at) FROM stdin;
\.


--
-- Data for Name: metodo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.metodo (id, nombre, descripcion) FROM stdin;
532	CMIA	\N
533	Enzimático amperimétrico	\N
534	Enzimático colorimétrico	\N
535	Recuento en cámara	\N
536	Colorimétrico con BCF	\N
537	Enzimático con GLDH	\N
538	Coagulométrico automatizado	\N
539	Turbidimétrico	\N
540	Cromogénico cinético a 405 nm	\N
541	Inmunoturbidimetría	\N
542	Fórmula de Astrup	\N
543	Reacción diazo	\N
544	Arsenazo III	\N
545	Ión-electrodo selectivo	\N
546	Placa para manchas	\N
547	Espectrométrico	\N
548	Inmunodifusión radial	\N
549	Nitroprusiato	\N
550	HAI	\N
551	Deterg. acelerador especifico	\N
552	Deterg. selectivo líquido	\N
553	Enzimático CHOD-PAP	\N
554	Enzimático	\N
555	Butirilcolina segun DGKC 37ºC	\N
556	Hemólisis al 50% (Grimberg)	\N
557	Cinetico UV a 37ªC con NAC	\N
558	Picrato alcalino cinético	\N
559	Inmunoensayo turbidimétrico	\N
560	Inmunocromatografía	\N
561	Westergreen	\N
562	Electrométrico	\N
563	Compleximétrico	\N
564	Coagulométrico, Clauss modificado	\N
565	Recuento automatizado	\N
566	Cinét.405 nm a 37ªC con p-NPP	\N
567	Fosfomolibdato	\N
568	Varios	\N
569	Colorimetría con NBT/formazán	\N
570	Colorimétrico enzimático	\N
571	Enzimático hexocinasa/G6PDH	\N
572	Enzimático (GOD)-amperimétrico	\N
573	Microscopía óptica	\N
574	Cinético cromogénico a 405 nm	\N
575	Cinético, reacción diazo.	\N
576	Inmunoanálisis cualitativo	\N
577	Aglutinación en placa	\N
578	Inmundifusión radial	\N
579	Turbidimetría	\N
580	Ión selectivo	\N
581	Cinético UV a 37ªC (IFCC)	\N
582	Rumpel-Leede	\N
583	Inmunoturbidimétrico	\N
584	SCLAVO-TEST-PPD: 2 UI/0.1 ml	\N
585	Calculado	\N
586	Inmunoturbidimetría, cinético	\N
587	Tira react., microscop. optica	\N
588	Osmolalidad por cálculo	\N
589	Cromogénico cinético a  405 nm	\N
590	Colorimetría	\N
591	Biuret	\N
592	Coagulométrico	\N
593	Aglutinación directa	\N
594	Lee-Whyte y Duke	\N
595	Inmunocromatrografía	\N
596	Formula de Vermeulen	\N
597	Cinético U.V. a 37·C	\N
598	Inmunoturbidimetria	\N
599	Ferene	\N
600	Enzimático GPO-PAP	\N
601	Enzimático UV	\N
602	Enz.URICASA-PAP	\N
603	Floculación	\N
604	qRT-PCR - COBAS Z480	\N
605	ELISA	\N
606	Titulometria	\N
607	PCR y Secuenciación	\N
608	Citometría de flujo	\N
609	PCR en tiempo real	\N
610	FISH	\N
611	PCR	\N
612	HIV-1 PROVIRAL- PCR cualitativa	\N
613	Secuenciación	\N
614	Biologia molecular	\N
615	ECLIA	\N
616	Electroforesis en gel de agarosa	\N
617	Electroforesis capilar (Sebia)	\N
618	RIA	\N
619	CLIA	\N
620	Enzimático Cinético UV	\N
621	HPLC-UV	\N
622	IFI	\N
623	HPLC-MS	\N
624	RIE	\N
625	Crossley y Elliot	\N
626	GFAAS	\N
627	Isoelectroenfoque-IF, nefelometría	\N
628	Inmunofluorescencia	\N
629	Electroquimioluminiscencia	\N
630	ELFA	\N
631	Enzimático cinético UV	\N
632	TRACE - Inmunofluorométrico automatizado	\N
633	Cromatografía líquida con detector MS/MS	\N
634	Quimioluminiscencia	\N
635	Cinético 37ºC	\N
636	EAST	\N
637	IRMA	\N
638	Electrodo de ión selectivo	\N
639	HYAAS	\N
640	Cinético	\N
641	LIA	\N
642	HPLC-EQ	\N
643	LC-MS/MS – Cromatografía líquida con detector MS/MS	\N
644	HPLC	\N
645	Electroforesis capilar.	\N
646	QLIA	\N
647	Espectrofotometría	\N
648	Cromatografía gaseosa	\N
649	Espectrometría de masa en tándem	\N
650	Cinetico UV 37ºC automatizado	\N
651	Espectrometría de masa en tandem	\N
652	Espectrometria de masa en tandem	\N
653	Floculación en tubo	\N
654	Citogenético directo	\N
655	Espectrometría de masa	\N
656	Centrifugación	\N
657	Cromatografía en capa delgada	\N
658	Fluorometría	\N
659	Van de Kamer	\N
660	Enzimoinmunoensayo	\N
661	Electrodo ión-selectivo	\N
662	Inmunoensayo enzimático	\N
663	Precipitación/Quimioluminiscencia	\N
664	IFI/Western Blot	\N
665	HPLC/EchD	\N
666	EIA	\N
667	HPLC/FLD	\N
668	Aglutinación	\N
669	Inmunofluorescencia indirecta	\N
670	Inmunofluorescencia Indirecta	\N
671	Inmunofluorescencia indirecta - Linea Hep2	\N
672	EIA de neutralización	\N
673	EIA indirecto	\N
674	EIA-captura de antígeno	\N
675	Microaglutinación	\N
676	Doble difusión	\N
677	CG-MS -Cromatografía gaseosa con detector MS.	\N
678	Electroforesis	\N
679	Reaccion en cadena de la polimerasa	\N
680	RT-PCR en tiempo real	\N
681	Inmunoelectrotransferencia (WB)	\N
682	SSO-PCR Luminex	\N
683	PCR alelo específica	\N
684	Nested PCR	\N
685	Cromogénico	\N
686	Sjoerdsma	\N
687	Colorimétrico - Giusti	\N
688	Absorción Atómica Generador de Hidruros (AA-GH)	\N
689	Spatz	\N
690	ELISA sandwich en fase sólida	\N
691	Inmunofijación en gel de agarosa	\N
692	Macroscópico-microscópico	\N
693	Separación con sulfato de amonio	\N
694	Inmunofluorescencia directa	\N
695	PCR real time	\N
696	Inmunodifusión	\N
697	Macroaglutinación con Ag TR	\N
698	Microaglutinación (MAT)	\N
699	PCR Multiplex en tiempo real	\N
700	Solubilidad en urea 5M	\N
701	Coagulativo	\N
702	Inmunológico	\N
703	Agregometría	\N
704	Enzimático-florimétrico	\N
705	LAMP	\N
706	ARMS PCR	\N
707	Aglutinación de látex	\N
708	Inmunocromatografia	\N
\.


--
-- Data for Name: modalidad_recoleccion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.modalidad_recoleccion (id, nombre) FROM stdin;
1	1º micción del dia
2	3 Horas de Retención
3	20 min / 40 min (Series Temporales)
4	Post-Dexametasona
5	Post-Dosis (4 horas)
6	Post-Estímulo (30 min, 60 min)
7	Post-HD (Post-Hemodiálisis)
8	Post-Isquemia
9	Post-Jornada Laboral
10	Post-Sobrecarga (30 min, 60 min, 90 min, 120 min, 180 min)
11	Muestras Simultáneas
12	Pool de Orinas (5 muestras)
13	Con Dieta Específica
14	Recolección Multidía (Día 4, 5 y 6)
15	retencion 3h
16	retencion 12h
17	retencion 24h
18	Orina Aislada / Espontánea
\.


--
-- Data for Name: muestra; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.muestra (id, nombre, observacion) FROM stdin;
505	SUERO/PLASMA HEPARINIZADO (1 ml) TUBO OPACO	\N
506	SANGRE HEPARINIZADA EN ANAEROBIOSIS (2 ml) REFRIGERADA ENVIO URGENTE	\N
507	SUERO/PLASMA HEPARINIZADO (1 ml)	\N
508	ORINA 12h (50 ml) REFRIGERADA	\N
509	LIQUIDO BIOLOGICO (1 ml)	\N
510	SANGRE CON EDTA EN ANAEROBIOSIS (2 ml) REFRIGERADO ENVIO URGENTE	\N
511	PLASMA CITRATADO (2 ml) REFRIGERADO	\N
512	SUERO (1 ml)	\N
513	PLASMA CITRATADO (1 ml)	\N
514	ORINA AISLADA (2 ml)	\N
515	ORINA 24h (10 ml)	\N
516	CALCULO URINARIO	\N
517	ORINA AISLADA (2 ml) REFRIGERADA	\N
518	SANGRE ENTERA	\N
519	SANGRE CON EDTA (2 ml) Y PLASMA CITRATADO (2 ml)	\N
520	SUERO POST DEXAMETASONA (1 ml)	\N
521	LIQUIDO BIOLOGICO	\N
522	ORINA 24h (10 ml) REFRIGERADA	\N
523	ORINA 24h (10 ml) Y SUERO (1 ml) REFRIGERADOS	\N
524	SUERO (1 ml)  Y PLASMA CITRATADO (1 ml)	\N
525	ORINA AISLADA (10 ml)	\N
526	SANGRE CON EDTA (2 ml)	\N
527	PLASMA CITRATADO POST-ISQUEMIA  (1 ml)	\N
528	SANGRE CON EDTA (1 ml)	\N
529	ORINA AISLADA	\N
530	ORINA 24h Y SUERO	\N
531	SANGRE HEPARINIZADA EN ANAEROBIOSIS	\N
532	SUERO 120 min POST-SOBRECARGA (1 ml)	\N
533	SUERO 180 min POST-SOBRECARGA (1 ml)	\N
534	SUERO 30 min POST-SOBRECARGA (1 ml)	\N
535	SUERO 60 min POST-SOBRECARGA (1 ml)	\N
536	SUERO 90 min POST-SOBRECARGA (1 ml)	\N
537	ORINA 3h (totalidad)	\N
538	ORINA AISLADA (20 ml) FRESCA	\N
539	PLASMA CITRATADO 4h POST-DOSIS (1 ml) DOBLE CENTRIFUGACION	\N
540	PLASMA HEPARINIZADO (1 ml)	\N
541	SALIVA (1 ml)	\N
542	ORINA 24h	\N
543	PLASMA CITRATADO (2 ml)	\N
544	HECES	\N
545	LCR	\N
546	LIQUIDO DE PUNCION	\N
547	PLASMA HEPARINIZADO (1 ml) TUBO OPACO REFRIGERADO	\N
548	ORINA AISLADA (10 ml) REFRIGERADA	\N
549	EXTENDIDO DE MOCO NASAL	\N
550	ORINA AISLADA (3 horas de retención, 10 ml) REFRIGERADA	\N
551	PLASMA CON EDTA (1 ml) REFRIGERADO	\N
552	PLASMA CON EDTA (2 ml)	\N
553	SUERO, SUERO 20 min Y SUERO 40 min	\N
554	PLASMA CITRATADO (1 ml) REFRIGERADO	\N
555	SUERO 30 min POST-ESTIMULO (1 ml)	\N
556	SUERO 60 min POST-ESTIMULO (1 ml)	\N
557	SUERO/PLASMA HEPARINIZADO (1 ml) Y SUERO POST-HD (1 ml)	\N
558	SANGRE/MEDULA OSEA CON EDTA (6 ml) REFRIGERADO	\N
559	SUERO (1 ml) REFRIGERADO	\N
560	ORINA ASISLADA (10 ml) FRESCA REFRIGERADA	\N
561	ORINA 24 h (100 ml) REFRIGERADA	\N
562	SANGRE CON EDTA (6 a 10 ml) REFRIGERADA	\N
563	SANGRE CON EDTA	\N
564	SANGRE CON EDTA (2.5 ml)	\N
565	SANGRE o MEDULA OSEA, CON EDTA (2 ml) REFRIGERADA	\N
566	MEDULA OSEA/SANGRE CON EDTA (5 ml) REFRIGERADO	\N
567	MEDULA OSEA CON EDTA (2 ml) REFRIGERADO	\N
568	PLASMA CON EDTA	\N
569	TACO EMBEBIDO EN PARAFINA, BIOPSIA EN SF, SANGRE CON EDTA, MEDULA OSEA, DNA EXTRAIDO REFRIGERADO	\N
570	MUESTRA BIOLOGICA CON EDTA (2 ml) REFRIGERADA	\N
571	ORINA 24h (100 ml) REFRIGERADA	\N
572	HECES (porción) REFRIGERADA	\N
573	MEDULA OSEA	\N
574	ORINA AISLADA POST-JORNADA LABORAL (40 ml) REFRIGERADA	\N
575	ORINA 24h (15 ml) ACIDIFICADA	\N
576	SUERO (2 ml) REFRIGERADO	\N
577	PLASMA HEPARINIZADO (2.5 ml) REFRIGERADO	\N
578	SUERO (3 ml) REFRIGERADO	\N
579	HECES (porcion) REFRIGERADA	\N
580	SUERO (1 ml) REFRIGERADO y HECES (totalidad de 2 dias)	\N
581	PLASMA CON EDTA (2 ml) REFRIGERADO	\N
582	SANGRE CON EDTA (3 ml) REFRIGERADO	\N
583	LCR (1 ml) REFRIGERADO	\N
584	LCR (1 ml) y SUERO (1 ml) SIMULTANEOS REFRIGERADOS	\N
585	ORINA 24h (2 alícuotas de 15 ml c/u) REFRIGERADA	\N
586	ORINA AISLADA/ORINA 24h (10 ml) REFRIGERADA	\N
587	SANGRE CON EDTA (2 ml) REFRIGERADA	\N
588	SUERO (0.5 ml) REFRIGERADO	\N
589	SANGRE HEPARINIZADA (5 ml) REFRIGERADA	\N
590	ORINA AISLADA POST-JORNADA LABORAL (40 ml) SIN REFRIGERAR	\N
591	SUERO (2 ml) REFRIGERADO TUBO OPACO	\N
592	PLASMA CON EDTA (1 ml) TUBO OPACO	\N
593	PLASMA CON HEPARINA (1 ml) TUBO OPACO	\N
594	SANGRE SOBRE SOPORTE	\N
595	SUERO (1.5 ml) REFRIGERADO	\N
596	ORINA 24h (50 ml) REFRIGERADA	\N
597	POOL DE ORINAS (5 muestras) ESTERILES (50 ml)	\N
598	SANGRE HEPARINIZADA EN ANAEROBIOSIS (2 ml) ENVIO URGENTE	\N
599	ORINA 24h (100 ml) ACIDIFICADA y REFRIGERADA	\N
600	POOL DE ORINAS (5 muestras) ESTERILES (100 ml)	\N
601	ORINA 24h (50 ml) ACIDIFICADA y REFRIGERADA	\N
602	SUERO (2.5 ml) REFRIGERADO TUBO OPACO	\N
603	ASPIRADO DE NODULO EN 1 ml DE SOLUCION FISIOLOGICA REFRIGERADO	\N
604	LIQUIDO AMNIOTICO (25 ml) EN RECIPIENTE ESTERIL ENVIO URGENTE	\N
605	MATERIAL DE ABORTO (RESTOS OVULARES) EN RECIPIENTE ESTÉRIL ENVIO URGENTE	\N
606	MEDULA OSEA EN HEPARINA SODICA (2 ml) REFRIGERADA ENVIO URGENTE	\N
607	SANGRE ENTERA CON HEPARINA SODICA (10 ml) REFRIGERADA ENVIO URGENTE	\N
608	ORINA 24h (30 ml) ACIDIFICADA y REFRIGERADA	\N
609	ORINA 24h (5 ml) REFRIGERADA	\N
610	SALIVA (1 ml) REFRIGERADA	\N
611	SANGRE o MEDULA OSEA, CON EDTA (2 ml), LIQ. AMINOTICO, REFRIGERADO	\N
612	LIQUIDO CEFALORRAQUIDEO (0.5 ml) REFRIGERADO	\N
613	LIQUIDO AMNIOTICO REFRIGERADO	\N
614	MATERIA FECAL (día 4, 5 y 6, totalidad) CON DIETA REFRIGERADA	\N
615	PLASMA CON EDTA (1.5 ml) REFRIGERADO	\N
616	1º ORINA DE LA MAÑANA (20 ml) REFRIGERADA	\N
617	ORINA AISLADA POST JORNADA LABORAL (15 ml) REFRIGERADA	\N
618	SANGRE CON EDTA (3 ml) A TEMP. AMBIENTE y SUERO (0.5 ml) REFRIGERADO	\N
619	PLASMA CON EDTA (1 ml) CONGELADO	\N
620	ASPIRADO DE NODULO CON AGUJA FINA (1 ml de SF) REFRIGERADO	\N
621	SUERO	\N
622	LIQ. BIOLOGICO (1 ml)/MATERIA FECAL/BIOPSIA REFRIGERADO	\N
623	ORINA DE 24h (10 ml) REFRIGERADA	\N
624	ASPIRADO NASOFARINGEO REFRIGERADO	\N
625	MATERIA FECAL/BIOPSIA	\N
626	LCR, HECES, PLASMA CON EDTA, LIQ.BIOL (0.5 ml) REFRIGERADO	\N
627	MATERIA FECAL/BIOPSIA/LAVADO GASTRODUODENAL en RECIPIENTE ESTERIL	\N
628	PLASMA CON EDTA (0.5 ml)/HECES FRESCAS REFRIGERADAS	\N
629	BIOPSIA ,HISOPADO, LIQ. PUNCION, LESION, SANGRE CON EDTA (0.5 ml) REFRIGERADO	\N
630	SANGRE o MEDULA OSEA CON EDTA, LCR, BAL,  ESPUTO (1 ml) REFRIGERADO	\N
631	SANGRE CON EDTA (4 ml) REFRIGERADA	\N
632	SANGRE CON EDTA (5 ml) REFRIGERADA	\N
633	SANGRE CON EDTA (3 ml) REFRIGERADA	\N
634	PLASMA CITRATADO (2.5 ml) REFRIGERADO	\N
635	HISOPADO UROGENITAL, SEMEN, ORINA (1º CHORRO) REFRIGERADO	\N
636	MUESTRA RESPIRATORIA, SANGRE O LIQ. BIOLOGICOS REFRIGERADOS	\N
637	SANGRE o MEDULA OSEA CON EDTA, LCR, BIOPSIA, LIQ. BIOLOGICO (3 ml) REFRIGERADO	\N
638	PLASMA CON EDTA (1 ml), ORINA REFRIGERADA	\N
639	SANGRE CON EDTA, ORINA, LIQ. BIOLOGICO, BIOPSIA REFRIGERADA	\N
640	SANGRE HEPARINIZADA (2 ml) REFRIGERADA	\N
641	FLUJO, EX URETRAL, SEMEN ,ORINA REFRIGERADO	\N
642	SANGRE CON EDTA (2 ml) REFRIGERADO	\N
643	SOBRENADANTE DE LIQUIDOS DE PUNCION (2 ml) REFRIGERADO	\N
644	ORINA 24h (300 ml) REFRIGERADA	\N
645	ORINA 24h (25 ml) REFRIGERADA	\N
646	HECES ESPONTANEAS FRESCAS REFRIGERADAS	\N
647	ORINA, 1º DE LA MAÑANA (20 ml) REFRIGERADA	\N
648	SANGRE CON EDTA (6 ml) REFRIGERADO	\N
649	HISOPADO NASAL, MiniBAL o BAL REFRIGERADO	\N
650	ASPIRADO NASOFARINGEO o BAL REFRIGERADO	\N
651	SANGRE CON EDTA (10 ml) REFRIGERADA	\N
652	SANGRE CON EDTA (3 ml) y SUERO (1 ml) REFRIGERADA	\N
653	PLASMA CITRATADO PP (3 ml) REFRIGERADO	\N
654	PLASMA CITRATADO PP (2 ml) REFRIGERADO	\N
655	HISOPADO o ASPIRADO NASOFARINGEO en 2 ml SHIELD 1X a T. AMBIENTE	\N
656	SANGRE CON EDTA (3 ml), BIOPSIA, MEDULA OSEA, LIQUIDO DE PUNCION o SEMEN, ESTERILES REFRIGERADO	\N
657	ORINA (1º CHORRO), EX. ENDOCERV., EX. URETRAL, SEMEN REFRIGERADO	\N
658	LIQUIDO CEFALORRAQUIDEO (1 ml) REFRIGERADO	\N
659	ORINA AISLADA (2 ml) REFRIGERADO (VIABLE SOLO 24h)	\N
660	HISOPADO BUCAL	\N
661	HISOPADO NASOFARINGEO T. AMBIENTE	\N
662	PLASMA CON EDTA (3 ml) REFRIGERADO	\N
663	PLASMA CON EDTA o LCR (3 ml) REFRIGERADO	\N
664	LIQUIDO CEFALORRAQUIDEO (0.7 ml) REFRIGERADO	\N
665	MUESTRAS RESPIRATORIAS T. AMBIENTE	\N
666	HISOPADO NASOFARINGEO, ASPIRADO NF T. AMBIENTE	\N
667	HISOPADO, CEPILLADO CERVICAL, SEMEN, ORINA O BIOPSIA (3 ml) REFRIGERADO	\N
668	LAVADO BRONQUEOALVEOLAR	\N
669	HISOPADO NASAL, NASOFARINGEO, ASPIRADO NF T. AMBIENTE	\N
670	SUERO o LCR (1 ml) REFRIGERADO	\N
671	ESPUTO, BAL, MiniBAL, BIOPSIA, ASPIRADO TRAQUEAL REFRIGERADO	\N
672	SUERO o BAL (1 ml) ESTERIL REFRIGERADO	\N
\.


--
-- Data for Name: preanalitico; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.preanalitico (id, nombre, descripcion) FROM stdin;
76	VOLUMEN DE 12h	\N
77	TIPO DE MUESTRA	\N
78	DIURESIS	\N
79	TIEMPO DE SANGRIA	\N
80	DIURESIS, PESO Y ALTURA	\N
81	Tipo de muestra	\N
82	Diuresis	\N
83	Horario post-infusión (24, 48 o 72h)	\N
84	pH del moco nasal	\N
85	Tiempo de sangría	\N
86	FUM	\N
87	Semanas de gestación	\N
88	Edad	\N
89	Dosis y última toma	\N
90	Postura en el momento de toma de muestra	\N
91	Dosis y horario de última toma	\N
92	Alergeno	\N
93	TARJETA DE RECOLECCION DE MUESTRA	\N
94	Horario de toma de muestra	\N
95	Nº de semanas de gestación	\N
96	POSTURA EN TOMA DE MUESTRA (DE PIE, ACOSTADO, POST-ESTIMULO)	\N
97	FECHA Y HORA DE TOMA DE DROGA	\N
98	Ficha epidemiológica	\N
99	¿ANTICOAGULACION? ¿SANGRADO? ¿HEPATOPATIAS?	\N
100	Tarjeta de recolección de muestra	\N
\.


--
-- Data for Name: prioridad_envio; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.prioridad_envio (id, nombre) FROM stdin;
1	Envío Urgente
2	Normal / Estándar
3	Viable solo 24 horas
\.


--
-- Data for Name: recipiente; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.recipiente (id, nombre) FROM stdin;
1	Recipiente Estéril
2	Soporte / Papel de Filtro (DBS)
3	Tubo Opaco
4	Tubo Estándar
\.


--
-- Data for Name: sector; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sector (id, nombre) FROM stdin;
1	Autoinmunidad / Inmuno
2	Biología Molecular
3	Citometría
4	Drogas Terapéuticas
5	Endocrinlogía
6	Hematología
7	Hemostasia
8	Marcadores Tumorales
9	Materia Fecal
10	Metabolismon y Nutrición
11	Miscelaneas
12	Neo
13	Neuroend.
14	Orina (no dosajes)
15	Química
16	Serología y Virología
\.


--
-- Data for Name: tecnica_recoleccion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tecnica_recoleccion (id, nombre) FROM stdin;
1	AAF / PAAF (Aspiración con Aguja Fina)
2	Aspirado
3	Cepillado Cervical
4	Extendido / Frotis
5	Hisopado (Bucal, Nasal, Nasofaríngeo, Urogenital)
6	Lavado Gastroduodenal
7	MiniBAL
8	Punción
9	Sobrenadante (Post-Centrifugación de Punción)
\.


--
-- Data for Name: tipo_muestra; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tipo_muestra (id, nombre) FROM stdin;
1	Biopsia
2	Cálculo Urinario
3	DNA Extraído
4	Esputo
5	Exudado Endocervical
6	Exudado Uretral
7	Flujo Urogenital
8	Heces / Materia Fecal
9	LCR (Líquido Cefalorraquídeo)
10	Lesión
11	Líquido Amniótico
12	Líquido Biológico
13	Líquido de Punción
14	Moco Nasal
15	Material de Aborto (Restos Ovulares)
16	Médula Ósea
17	Muestra Biológica (Genérica)
18	Muestra Respiratoria (Genérica)
19	Nódulo
20	Orina
21	Plasma
22	Saliva
23	Sangre / Sangre Entera
24	Secreción Nasofaríngea
25	Secreción Traqueal
26	Semen
27	Suero
\.


--
-- Data for Name: unidad_medida; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.unidad_medida (id, nombre) FROM stdin;
1	µL
2	mL
3	mg
4	g
5	tubo completo
6	unidad
\.


--
-- Data for Name: valor_estudio_sector; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.valor_estudio_sector (id, id_estudio, posicion_informe, rango, id_sector) FROM stdin;
1612	2502	1	0 A 100	6
1613	2501	5	0 A 100	6
1614	2497	9	0 A 100	6
1615	2477	13	0 A 100	6
1616	2500	17	0 A 100	6
1617	2476	21	0 A 100	6
1618	2452	25	0 A 100	6
1619	2707	29	0 A 100	6
1620	2741	33	0 A 100	6
1621	2397	37	0 A 100	6
1622	2396	41	0 A 100	6
1623	2430	45	0 A 100	6
1624	2789	101	100 A 300	7
1625	2809	105	100 A 300	7
1626	2618	109	100 A 300	7
1627	2619	113	100 A 300	7
1628	2450	117	100 A 300	7
1629	2790	121	100 A 300	7
1630	2365	125	100 A 300	7
1631	2753	129	100 A 300	7
1632	2364	133	100 A 300	7
1633	2623	137	100 A 300	7
1634	2246	141	100 A 300	7
1635	2722	145	100 A 300	7
1636	2290	155	100 A 300	7
1637	2256	161	100 A 300	7
1638	2503	165	100 A 300	7
1639	2584	173	100 A 300	7
1640	2269	176	100 A 300	7
1641	2268	177	100 A 300	7
1642	2312	184	100 A 300	7
1643	2311	185	100 A 300	7
1644	2460	192	100 A 300	7
1645	2459	193	100 A 300	7
1646	2438	201	100 A 300	7
1647	2439	202	100 A 300	7
1648	2443	249	100 A 300	7
1649	2731	253	100 A 300	7
1650	2680	257	100 A 300	7
1651	2648	258	100 A 300	7
1652	2478	301	301 A 900	15
1653	2479	305	301 A 900	15
1654	2483	306	301 A 900	15
1655	2484	307	301 A 900	15
1656	2485	308	301 A 900	15
1657	2480	313	301 A 900	15
1658	2481	313	301 A 900	15
1659	2482	315	301 A 900	15
1660	2487	333	301 A 900	15
1661	2462	337	301 A 900	15
1662	2499	341	301 A 900	15
1663	2199	353	301 A 900	15
1664	2650	357	301 A 900	15
1665	2651	361	301 A 900	15
1666	2832	365	301 A 900	15
1667	2833	369	301 A 900	15
1668	2829	373	301 A 900	15
1669	2830	377	301 A 900	15
1670	2831	381	301 A 900	15
1671	2393	385	301 A 900	15
1672	2391	389	301 A 900	15
1673	2392	393	301 A 900	15
1674	2394	397	301 A 900	15
1675	2395	401	301 A 900	15
1676	2348	402	301 A 900	15
1677	2220	409	301 A 900	15
1678	2835	417	301 A 900	15
1679	2836	421	301 A 900	15
1680	2303	425	301 A 900	15
1681	2302	429	301 A 900	15
1682	2301	433	301 A 900	15
1683	2304	437	301 A 900	15
1684	2455	441	301 A 900	15
1685	2461	445	301 A 900	15
1686	2457	449	301 A 900	15
1687	2458	453	301 A 900	15
1688	2636	457	301 A 900	15
1689	2637	461	301 A 900	15
1690	2611	465	301 A 900	15
1691	2612	469	301 A 900	15
1692	2610	473	301 A 900	15
1693	2609	477	301 A 900	15
1694	2721	481	301 A 900	15
1695	2717	485	301 A 900	15
1696	2810	489	301 A 900	15
1697	2811	493	301 A 900	15
1698	2454	497	301 A 900	15
1699	2275	501	301 A 900	15
1700	2521	505	301 A 900	15
1701	2468	509	301 A 900	15
1702	2621	513	301 A 900	15
1703	2491	514	301 A 900	15
1704	2373	517	301 A 900	15
1705	2241	521	301 A 900	15
1706	2240	525	301 A 900	15
1707	2628	529	301 A 900	15
1708	2389	533	301 A 900	15
1709	2390	534	301 A 900	15
1710	2232	537	301 A 900	15
1711	2653	545	301 A 900	15
1712	2828	549	301 A 900	15
1713	2703	553	301 A 900	15
1714	2406	557	301 A 900	15
1715	2369	561	301 A 900	15
1716	2367	565	301 A 900	15
1717	2368	569	301 A 900	15
1718	2372	569	301 A 900	15
1719	2371	577	301 A 900	15
1720	2370	577	301 A 900	15
1721	2824	585	301 A 900	15
1722	2257	589	301 A 900	15
1723	2258	590	301 A 900	15
1724	2629	597	301 A 900	15
1725	2216	601	301 A 900	15
1726	2548	605	301 A 900	15
1727	2724	606	301 A 900	15
1728	2231	609	301 A 900	15
1729	2725	613	301 A 900	15
1730	2590	617	301 A 900	15
1731	2591	618	301 A 900	15
1732	2597	633	301 A 900	15
1733	2594	636	301 A 900	15
1734	2595	637	301 A 900	15
1735	2592	638	301 A 900	15
1736	2593	639	301 A 900	15
1737	2569	640	301 A 900	15
1738	2596	640	301 A 900	15
1739	2784	642	301 A 900	15
1740	2375	649	301 A 900	15
1741	2376	650	301 A 900	15
1742	2377	651	301 A 900	15
1743	2248	661	301 A 900	15
1744	2442	665	301 A 900	15
1745	2748	669	301 A 900	15
1746	2270	673	301 A 900	15
1747	2728	677	301 A 900	15
1748	2588	678	301 A 900	15
1749	2263	681	301 A 900	15
1750	2297	685	301 A 900	15
1751	2299	686	301 A 900	15
1752	2729	691	301 A 900	15
1753	2730	693	301 A 900	15
1754	2589	694	301 A 900	15
1755	2267	695	301 A 900	15
1756	2448	697	301 A 900	15
1757	2812	701	301 A 900	15
1758	2813	705	301 A 900	15
1759	2449	709	301 A 900	15
1760	2486	713	301 A 900	15
1761	2201	721	301 A 900	15
1762	2847	725	301 A 900	15
1763	2211	729	301 A 900	15
1764	2361	733	301 A 900	15
1765	2349	737	301 A 900	15
1766	2307	741	301 A 900	15
1767	2272	745	301 A 900	15
1768	2667	749	301 A 900	15
1769	2402	753	301 A 900	15
1770	2850	757	301 A 900	15
1771	2678	761	301 A 900	15
1772	2453	765	301 A 900	15
1773	2215	769	301 A 900	15
1774	2333	773	301 A 900	15
1775	2366	777	301 A 900	15
1776	2638	781	301 A 900	15
1777	2760	785	301 A 900	15
1778	2708	789	301 A 900	15
1779	2854	789	301 A 900	15
1780	2261	791	301 A 900	15
1781	2432	793	301 A 900	15
1782	2433	797	301 A 900	15
1783	2704	800	301 A 900	15
1784	2273	801	301 A 900	15
1785	2310	805	301 A 900	15
1786	2644	809	301 A 900	15
1787	2206	810	301 A 900	15
1788	2244	811	301 A 900	15
1789	2677	821	301 A 900	15
1790	2631	829	301 A 900	15
1791	2630	833	301 A 900	15
1792	2221	834	301 A 900	15
1793	2655	837	301 A 900	15
1794	2825	901	901 A 1300	5
1795	2826	902	901 A 1300	5
1796	2798	909	901 A 1300	5
1797	2799	910	901 A 1300	5
1798	2795	911	901 A 1300	5
1799	2796	913	901 A 1300	5
1800	2797	915	901 A 1300	5
1801	2734	918	901 A 1300	5
1802	2791	929	901 A 1300	5
1803	2792	930	901 A 1300	5
1804	2793	937	901 A 1300	5
1805	2262	941	901 A 1300	5
1806	2794	949	901 A 1300	5
1807	2598	953	901 A 1300	5
1808	2602	954	901 A 1300	5
1809	2603	955	901 A 1300	5
1810	2604	956	901 A 1300	5
1811	2599	957	901 A 1300	5
1812	2600	957	901 A 1300	5
1813	2601	958	901 A 1300	5
1814	2547	981	901 A 1300	5
1815	2699	985	901 A 1300	5
1816	2700	986	901 A 1300	5
1817	2605	993	901 A 1300	5
1818	2613	997	901 A 1300	5
1819	2465	1001	901 A 1300	5
1820	2195	1002	901 A 1300	5
1821	2219	1005	901 A 1300	5
1822	2379	1009	901 A 1300	5
1823	2382	1016	901 A 1300	5
1824	2383	1017	901 A 1300	5
1825	2384	1018	901 A 1300	5
1826	2385	1019	901 A 1300	5
1827	2386	1020	901 A 1300	5
1828	2381	1037	901 A 1300	5
1829	2693	1045	901 A 1300	5
1830	2305	1049	901 A 1300	5
1831	2306	1050	901 A 1300	5
1832	2463	1057	901 A 1300	5
1833	2627	1061	901 A 1300	5
1834	2435	1065	901 A 1300	5
1835	2437	1069	901 A 1300	5
1836	2436	1073	901 A 1300	5
1837	2718	1077	901 A 1300	5
1838	2719	1081	901 A 1300	5
1839	2720	1082	901 A 1300	5
1840	2634	1089	901 A 1300	5
1841	2400	1093	901 A 1300	5
1842	2245	1097	901 A 1300	5
1843	2196	1101	901 A 1300	5
1844	2403	1105	901 A 1300	5
1845	2785	1109	901 A 1300	5
1846	2786	1113	901 A 1300	5
1847	2788	1117	901 A 1300	5
1848	2787	1119	901 A 1300	5
1849	2475	1121	901 A 1300	5
1850	2255	1125	901 A 1300	5
1851	2779	1129	901 A 1300	5
1852	2780	1130	901 A 1300	5
1853	2778	1133	901 A 1300	5
1854	2781	1141	901 A 1300	5
1855	2685	1145	901 A 1300	5
1856	2723	1149	901 A 1300	5
1857	2772	1153	901 A 1300	5
1858	2775	1154	901 A 1300	5
1859	2776	1155	901 A 1300	5
1860	2777	1156	901 A 1300	5
1861	2773	1157	901 A 1300	5
1862	2774	1158	901 A 1300	5
1863	2771	1177	901 A 1300	5
1864	2768	1178	901 A 1300	5
1865	2769	1179	901 A 1300	5
1866	2770	1180	901 A 1300	5
1867	2737	1209	901 A 1300	5
1868	2422	1213	901 A 1300	5
1869	2423	1217	901 A 1300	5
1870	2233	1221	901 A 1300	5
1871	2234	1222	901 A 1300	5
1872	2247	1225	901 A 1300	5
1873	2330	1301	1301 A 1400	8
1874	2238	1305	1301 A 1400	8
1875	2292	1309	1301 A 1400	8
1876	2294	1313	1301 A 1400	8
1877	2293	1317	1301 A 1400	8
1878	2295	1318	1301 A 1400	8
1879	2291	1321	1301 A 1400	8
1880	2296	1322	1301 A 1400	8
1881	2249	1325	1301 A 1400	8
1882	2250	1329	1301 A 1400	8
1883	2252	1333	1301 A 1400	8
1884	2251	1337	1301 A 1400	8
1885	2419	1339	1301 A 1400	8
1886	2492	1341	1301 A 1400	8
1887	2398	1345	1301 A 1400	8
1888	2470	1349	1301 A 1400	8
1889	2316	1370	1301 A 1400	8
1890	2315	1371	1301 A 1400	8
1891	2314	1372	1301 A 1400	8
1892	2313	1373	1301 A 1400	8
1893	2317	1375	1301 A 1400	8
1894	2804	1401	1401 A 1800	16
1895	2669	1405	1401 A 1800	16
1896	2552	1409	1401 A 1800	16
1897	2853	1413	1401 A 1800	16
1898	2639	1417	1401 A 1800	16
1899	2657	1421	1401 A 1800	16
1900	2838	1425	1401 A 1800	16
1901	2837	1429	1401 A 1800	16
1902	2464	1433	1401 A 1800	16
1903	2820	1437	1401 A 1800	16
1904	2747	1441	1401 A 1800	16
1905	2285	1445	1401 A 1800	16
1906	2286	1449	1401 A 1800	16
1907	2288	1452	1401 A 1800	16
1908	2287	1453	1401 A 1800	16
1909	2337	1461	1401 A 1800	16
1910	2336	1469	1401 A 1800	16
1911	2338	1470	1401 A 1800	16
1912	2531	1472	1401 A 1800	16
1913	2532	1472	1401 A 1800	16
1914	2530	1473	1401 A 1800	16
1915	2541	1481	1401 A 1800	16
1916	2542	1485	1401 A 1800	16
1917	2505	1488	1401 A 1800	16
1918	2504	1489	1401 A 1800	16
1919	2512	1497	1401 A 1800	16
1920	2507	1499	1401 A 1800	16
1921	2506	1500	1401 A 1800	16
1922	2510	1501	1401 A 1800	16
1923	2509	1509	1401 A 1800	16
1924	2513	1513	1401 A 1800	16
1925	2508	1517	1401 A 1800	16
1926	2519	1520	1401 A 1800	16
1927	2515	1521	1401 A 1800	16
1928	2356	1528	1401 A 1800	16
1929	2355	1529	1401 A 1800	16
1930	2358	1541	1401 A 1800	16
1931	2713	1546	1401 A 1800	16
1932	2712	1547	1401 A 1800	16
1933	2525	1548	1401 A 1800	16
1934	2524	1549	1401 A 1800	16
1935	2527	1556	1401 A 1800	16
1936	2526	1557	1401 A 1800	16
1937	2529	1564	1401 A 1800	16
1938	2528	1565	1401 A 1800	16
1939	2523	1569	1401 A 1800	16
1940	2750	1572	1401 A 1800	16
1941	2749	1573	1401 A 1800	16
1942	2805	1579	1401 A 1800	16
1943	2808	1580	1401 A 1800	16
2144	2213	2537	2501 A 2600	13
1944	2806	1581	1401 A 1800	16
1945	2807	1582	1401 A 1800	16
1946	2426	1588	1401 A 1800	16
1947	2425	1589	1401 A 1800	16
1948	2225	1596	1401 A 1800	16
1949	2224	1597	1401 A 1800	16
1950	2226	1598	1401 A 1800	16
1951	2764	1604	1401 A 1800	16
1952	2763	1605	1401 A 1800	16
1953	2765	1606	1401 A 1800	16
1954	2280	1610	1401 A 1800	16
1955	2282	1610	1401 A 1800	16
1956	2278	1611	1401 A 1800	16
1957	2284	1612	1401 A 1800	16
1958	2342	1612	1401 A 1800	16
1959	2283	1613	1401 A 1800	16
1960	2341	1613	1401 A 1800	16
1961	2344	1620	1401 A 1800	16
1962	2343	1621	1401 A 1800	16
1963	2666	1628	1401 A 1800	16
1964	2665	1629	1401 A 1800	16
1965	2710	1630	1401 A 1800	16
1966	2388	1640	1401 A 1800	16
1967	2413	1648	1401 A 1800	16
1968	2412	1649	1401 A 1800	16
1969	2421	1650	1401 A 1800	16
1970	2420	1653	1401 A 1800	16
1971	2695	1656	1401 A 1800	16
1972	2694	1657	1401 A 1800	16
1973	2843	1664	1401 A 1800	16
1974	2842	1665	1401 A 1800	16
1975	2840	1666	1401 A 1800	16
1976	2755	1672	1401 A 1800	16
1977	2754	1673	1401 A 1800	16
1978	2577	1680	1401 A 1800	16
1979	2576	1681	1401 A 1800	16
1980	2578	1682	1401 A 1800	16
1981	2581	1688	1401 A 1800	16
1982	2580	1689	1401 A 1800	16
1983	2583	1690	1401 A 1800	16
1984	2687	1698	1401 A 1800	16
1985	2688	1699	1401 A 1800	16
1986	2689	1703	1401 A 1800	16
1987	2691	1704	1401 A 1800	16
1988	2690	1705	1401 A 1800	16
1989	2692	1706	1401 A 1800	16
1990	2698	1712	1401 A 1800	16
1991	2697	1713	1401 A 1800	16
1992	2495	1720	1401 A 1800	16
1993	2494	1721	1401 A 1800	16
1994	2536	1724	1401 A 1800	16
1995	2534	1725	1401 A 1800	16
1996	2535	1726	1401 A 1800	16
1997	2347	1728	1401 A 1800	16
1998	2346	1729	1401 A 1800	16
1999	2822	1736	1401 A 1800	16
2000	2821	1737	1401 A 1800	16
2001	2339	1741	1401 A 1800	16
2002	2265	1744	1401 A 1800	16
2003	2264	1745	1401 A 1800	16
2004	2803	1753	1401 A 1800	16
2005	2802	1754	1401 A 1800	16
2006	2751	1761	1401 A 1800	16
2007	2550	1765	1401 A 1800	16
2008	2549	1766	1401 A 1800	16
2009	2227	1801	1801 A 2000	2
2010	2537	1809	1801 A 2000	2
2011	2538	1813	1801 A 2000	2
2012	2378	1817	1801 A 2000	2
2013	2357	1821	1801 A 2000	2
2014	2354	1825	1801 A 2000	2
2015	2352	1826	1801 A 2000	2
2016	2351	1827	1801 A 2000	2
2017	2353	1829	1801 A 2000	2
2018	2401	1833	1801 A 2000	2
2019	2514	1837	1801 A 2000	2
2020	2511	1841	1801 A 2000	2
2021	2516	1845	1801 A 2000	2
2022	2517	1849	1801 A 2000	2
2023	2579	1853	1801 A 2000	2
2024	2583	1857	1801 A 2000	2
2025	2277	1859	1801 A 2000	2
2026	2345	1862	1801 A 2000	2
2027	2668	1863	1801 A 2000	2
2028	2662	1864	1801 A 2000	2
2029	2684	1865	1801 A 2000	2
2030	2823	1866	1801 A 2000	2
2031	2428	1869	1801 A 2000	2
2032	2427	1873	1801 A 2000	2
2033	2844	1877	1801 A 2000	2
2034	2554	1900	1801 A 2000	2
2035	2783	1901	1801 A 2000	2
2036	2300	1910	1801 A 2000	2
2037	2816	1920	1801 A 2000	2
2038	2818	1922	1801 A 2000	2
2039	2817	1923	1801 A 2000	2
2040	2399	1935	1801 A 2000	2
2041	2701	2001	2001 A 2200	1
2042	2586	2003	2001 A 2200	1
2043	2444	2005	2001 A 2200	1
2044	2533	2009	2001 A 2200	1
2045	2254	2017	2001 A 2200	1
2046	2633	2021	2001 A 2200	1
2047	2332	2025	2001 A 2200	1
2048	2253	2029	2001 A 2200	1
2049	2766	2033	2001 A 2200	1
2050	2197	2034	2001 A 2200	1
2051	2745	2037	2001 A 2200	1
2052	2746	2041	2001 A 2200	1
2053	2620	2045	2001 A 2200	1
2054	2756	2049	2001 A 2200	1
2055	2617	2053	2001 A 2200	1
2056	2744	2055	2001 A 2200	1
2057	2659	2057	2001 A 2200	1
2058	2660	2061	2001 A 2200	1
2059	2642	2065	2001 A 2200	1
2060	2652	2077	2001 A 2200	1
2061	2726	2081	2001 A 2200	1
2062	2228	2089	2001 A 2200	1
2063	2706	2093	2001 A 2200	1
2064	2331	2097	2001 A 2200	1
2065	2441	2101	2001 A 2200	1
2066	2735	2105	2001 A 2200	1
2067	2469	2109	2001 A 2200	1
2068	2656	2113	2001 A 2200	1
2069	2635	2117	2001 A 2200	1
2070	2681	2121	2001 A 2200	1
2071	2415	2125	2001 A 2200	1
2072	2743	2125	2001 A 2200	1
2073	2551	2127	2001 A 2200	1
2074	2682	2127	2001 A 2200	1
2075	2736	2128	2001 A 2200	1
2076	2416	2129	2001 A 2200	1
2077	2259	2132	2001 A 2200	1
2078	2260	2133	2001 A 2200	1
2079	2545	2137	2001 A 2200	1
2080	2474	2145	2001 A 2200	1
2081	2473	2149	2001 A 2200	1
2082	2471	2153	2001 A 2200	1
2083	2472	2157	2001 A 2200	1
2084	2417	2161	2001 A 2200	1
2085	2418	2165	2001 A 2200	1
2086	2814	2169	2001 A 2200	1
2087	2815	2173	2001 A 2200	1
2088	2839	2201	2201 A 2300	4
2089	2714	2206	2201 A 2300	4
2090	2632	2213	2201 A 2300	4
2091	2405	2214	2201 A 2300	4
2092	2309	2217	2201 A 2300	4
2093	2679	2221	2201 A 2300	4
2094	2404	2225	2201 A 2300	4
2095	2214	2229	2201 A 2300	4
2096	2622	2233	2201 A 2300	4
2097	2362	2235	2201 A 2300	4
2098	2801	2236	2201 A 2300	4
2099	2626	2237	2201 A 2300	4
2100	2447	2238	2201 A 2300	4
2101	2440	2240	2201 A 2300	4
2102	2782	2241	2201 A 2300	4
2103	2649	2245	2201 A 2300	4
2104	2429	2249	2201 A 2300	4
2105	2411	2301	2301 A 2400	11
2106	2702	2305	2301 A 2400	11
2107	2669	2307	2301 A 2400	11
2108	2218	2309	2301 A 2400	11
2109	2607	2317	2301 A 2400	11
2110	2608	2321	2301 A 2400	11
2111	2676	2325	2301 A 2400	11
2112	2207	2330	2301 A 2400	11
2113	2271	2401	2401 A 2500	10
2114	2845	2405	2401 A 2500	10
2115	2851	2409	2401 A 2500	10
2116	2846	2413	2401 A 2500	10
2117	2848	2417	2401 A 2500	10
2118	2849	2421	2401 A 2500	10
2119	2445	2429	2401 A 2500	10
2120	2204	2433	2401 A 2500	10
2121	2200	2437	2401 A 2500	10
2122	2203	2441	2401 A 2500	10
2123	2210	2445	2401 A 2500	10
2124	2208	2446	2401 A 2500	10
2125	2209	2447	2401 A 2500	10
2126	2212	2449	2401 A 2500	10
2127	2217	2453	2401 A 2500	10
2128	2242	2457	2401 A 2500	10
2129	2243	2461	2401 A 2500	10
2130	2318	2465	2401 A 2500	10
2131	2456	2469	2401 A 2500	10
2132	2466	2473	2401 A 2500	10
2133	2624	2477	2401 A 2500	10
2134	2762	2501	2501 A 2600	13
2135	2761	2505	2501 A 2600	13
2136	2289	2506	2501 A 2600	13
2137	2229	2509	2501 A 2600	13
2138	2230	2513	2501 A 2600	13
2139	2670	2517	2501 A 2600	13
2140	2671	2521	2501 A 2600	13
2141	2658	2525	2501 A 2600	13
2142	2319	2529	2501 A 2600	13
2143	2645	2533	2501 A 2600	13
2145	2409	2541	2501 A 2600	13
2146	2410	2545	2501 A 2600	13
2147	2205	2549	2501 A 2600	13
2148	2407	2553	2501 A 2600	13
2149	2329	2605	2601 A 2700	3
2150	2327	2609	2601 A 2700	3
2151	2326	2613	2601 A 2700	3
2152	2321	2617	2601 A 2700	3
2153	2328	2621	2601 A 2700	3
2154	2325	2625	2601 A 2700	3
2155	2320	2629	2601 A 2700	3
2156	2322	2637	2601 A 2700	3
2157	2266	2641	2601 A 2700	3
2158	2615	2645	2601 A 2700	3
2159	2614	2649	1801 A 2000	2
2160	2757	2701	2701 A 2800	12
2161	2757	2705	2701 A 2800	12
2162	2759	2709	2701 A 2800	12
2163	2276	2717	2701 A 2800	12
2164	2467	2721	2701 A 2800	12
2165	2616	2725	2701 A 2800	12
2166	2827	2729	2701 A 2800	12
2167	2195	2733	2701 A 2800	12
2168	2752	2801	2801 A 2900	9
2169	2625	2805	2801 A 2900	9
2170	2236	2809	2801 A 2900	9
2171	2235	2813	2801 A 2900	9
2172	2237	2817	2801 A 2900	9
2173	2414	2821	2801 A 2900	9
2174	2733	2825	2801 A 2900	9
2175	2434	2829	2801 A 2900	9
2176	2489	2833	2801 A 2900	9
2177	2308	2837	2801 A 2900	9
2178	2675	2901	2901  A 2950	14
2179	2496	2905	2901  A 2950	14
\.


--
-- Name: aditivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.aditivo_id_seq', 5, true);


--
-- Name: colega_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.colega_id_seq', 65, true);


--
-- Name: condicion_especial_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.condicion_especial_id_seq', 4, true);


--
-- Name: conservacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.conservacion_id_seq', 5, true);


--
-- Name: estudio_colega_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estudio_colega_id_seq', 2979, true);


--
-- Name: estudio_colega_modelo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estudio_colega_modelo_id_seq', 2, true);


--
-- Name: estudio_colega_muestra_alternativa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estudio_colega_muestra_alternativa_id_seq', 2, true);


--
-- Name: estudio_colega_muestra_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estudio_colega_muestra_id_seq', 267, true);


--
-- Name: estudio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estudio_id_seq', 2918, true);


--
-- Name: metodo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.metodo_id_seq', 714, true);


--
-- Name: modalidad_recoleccion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.modalidad_recoleccion_id_seq', 18, true);


--
-- Name: muestra_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.muestra_id_seq', 672, true);


--
-- Name: preanalitico_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.preanalitico_id_seq', 100, true);


--
-- Name: prioridad_envio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.prioridad_envio_id_seq', 3, true);


--
-- Name: recipiente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.recipiente_id_seq', 5, true);


--
-- Name: sector_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sector_id_seq', 16, true);


--
-- Name: tecnica_recoleccion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tecnica_recoleccion_id_seq', 9, true);


--
-- Name: tipo_muestra_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tipo_muestra_id_seq', 27, true);


--
-- Name: unidad_medida_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.unidad_medida_id_seq', 6, true);


--
-- Name: valor_estudio_sector_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.valor_estudio_sector_id_seq', 2179, true);


--
-- Name: aditivo aditivo_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aditivo
    ADD CONSTRAINT aditivo_nombre_key UNIQUE (nombre);


--
-- Name: aditivo aditivo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aditivo
    ADD CONSTRAINT aditivo_pkey PRIMARY KEY (id);


--
-- Name: colega colega_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.colega
    ADD CONSTRAINT colega_pkey PRIMARY KEY (id);


--
-- Name: condicion_especial condicion_especial_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.condicion_especial
    ADD CONSTRAINT condicion_especial_nombre_key UNIQUE (nombre);


--
-- Name: condicion_especial condicion_especial_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.condicion_especial
    ADD CONSTRAINT condicion_especial_pkey PRIMARY KEY (id);


--
-- Name: conservacion conservacion_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conservacion
    ADD CONSTRAINT conservacion_nombre_key UNIQUE (nombre);


--
-- Name: conservacion conservacion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conservacion
    ADD CONSTRAINT conservacion_pkey PRIMARY KEY (id);


--
-- Name: estudio estudio_codigo_hexalis_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio
    ADD CONSTRAINT estudio_codigo_hexalis_key UNIQUE (codigo_hexalis);


--
-- Name: estudio_colega_modelo estudio_colega_modelo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_modelo
    ADD CONSTRAINT estudio_colega_modelo_pkey PRIMARY KEY (id);


--
-- Name: estudio_colega_muestra_alternativa estudio_colega_muestra_alternativa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra_alternativa
    ADD CONSTRAINT estudio_colega_muestra_alternativa_pkey PRIMARY KEY (id);


--
-- Name: estudio_colega_muestra estudio_colega_muestra_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra
    ADD CONSTRAINT estudio_colega_muestra_pkey PRIMARY KEY (id);


--
-- Name: estudio_colega estudio_colega_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega
    ADD CONSTRAINT estudio_colega_pkey PRIMARY KEY (id);


--
-- Name: estudio estudio_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio
    ADD CONSTRAINT estudio_pkey PRIMARY KEY (id);


--
-- Name: metodo metodo_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metodo
    ADD CONSTRAINT metodo_nombre_key UNIQUE (nombre);


--
-- Name: metodo metodo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metodo
    ADD CONSTRAINT metodo_pkey PRIMARY KEY (id);


--
-- Name: modalidad_recoleccion modalidad_recoleccion_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modalidad_recoleccion
    ADD CONSTRAINT modalidad_recoleccion_nombre_key UNIQUE (nombre);


--
-- Name: modalidad_recoleccion modalidad_recoleccion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modalidad_recoleccion
    ADD CONSTRAINT modalidad_recoleccion_pkey PRIMARY KEY (id);


--
-- Name: muestra muestra_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.muestra
    ADD CONSTRAINT muestra_nombre_key UNIQUE (nombre);


--
-- Name: muestra muestra_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.muestra
    ADD CONSTRAINT muestra_pkey PRIMARY KEY (id);


--
-- Name: preanalitico preanalitico_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.preanalitico
    ADD CONSTRAINT preanalitico_nombre_key UNIQUE (nombre);


--
-- Name: preanalitico preanalitico_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.preanalitico
    ADD CONSTRAINT preanalitico_pkey PRIMARY KEY (id);


--
-- Name: prioridad_envio prioridad_envio_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prioridad_envio
    ADD CONSTRAINT prioridad_envio_nombre_key UNIQUE (nombre);


--
-- Name: prioridad_envio prioridad_envio_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prioridad_envio
    ADD CONSTRAINT prioridad_envio_pkey PRIMARY KEY (id);


--
-- Name: recipiente recipiente_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipiente
    ADD CONSTRAINT recipiente_nombre_key UNIQUE (nombre);


--
-- Name: recipiente recipiente_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipiente
    ADD CONSTRAINT recipiente_pkey PRIMARY KEY (id);


--
-- Name: sector sector_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sector
    ADD CONSTRAINT sector_nombre_key UNIQUE (nombre);


--
-- Name: sector sector_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sector
    ADD CONSTRAINT sector_pkey PRIMARY KEY (id);


--
-- Name: tecnica_recoleccion tecnica_recoleccion_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tecnica_recoleccion
    ADD CONSTRAINT tecnica_recoleccion_nombre_key UNIQUE (nombre);


--
-- Name: tecnica_recoleccion tecnica_recoleccion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tecnica_recoleccion
    ADD CONSTRAINT tecnica_recoleccion_pkey PRIMARY KEY (id);


--
-- Name: tipo_muestra tipo_muestra_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipo_muestra
    ADD CONSTRAINT tipo_muestra_nombre_key UNIQUE (nombre);


--
-- Name: tipo_muestra tipo_muestra_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipo_muestra
    ADD CONSTRAINT tipo_muestra_pkey PRIMARY KEY (id);


--
-- Name: unidad_medida unidad_medida_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unidad_medida
    ADD CONSTRAINT unidad_medida_nombre_key UNIQUE (nombre);


--
-- Name: unidad_medida unidad_medida_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unidad_medida
    ADD CONSTRAINT unidad_medida_pkey PRIMARY KEY (id);


--
-- Name: valor_estudio_sector uq_estudio_sector_posicion; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.valor_estudio_sector
    ADD CONSTRAINT uq_estudio_sector_posicion UNIQUE (id_estudio, id_sector, posicion_informe);


--
-- Name: valor_estudio_sector valor_estudio_sector_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.valor_estudio_sector
    ADD CONSTRAINT valor_estudio_sector_pkey PRIMARY KEY (id);


--
-- Name: idx_ecm_id_estudio_colega; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ecm_id_estudio_colega ON public.estudio_colega_modelo USING btree (id_estudio_colega);


--
-- Name: estudio_colega_modelo ecm_id_estudio_colega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_modelo
    ADD CONSTRAINT ecm_id_estudio_colega_fkey FOREIGN KEY (id_estudio_colega) REFERENCES public.estudio_colega(id) ON DELETE CASCADE;


--
-- Name: estudio_colega_muestra_alternativa ecma_id_aditivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra_alternativa
    ADD CONSTRAINT ecma_id_aditivo_fkey FOREIGN KEY (id_aditivo) REFERENCES public.aditivo(id) ON DELETE SET NULL;


--
-- Name: estudio_colega_muestra_alternativa ecma_id_condicion_especial_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra_alternativa
    ADD CONSTRAINT ecma_id_condicion_especial_fkey FOREIGN KEY (id_condicion_especial) REFERENCES public.condicion_especial(id) ON DELETE SET NULL;


--
-- Name: estudio_colega_muestra_alternativa ecma_id_conservacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra_alternativa
    ADD CONSTRAINT ecma_id_conservacion_fkey FOREIGN KEY (id_conservacion) REFERENCES public.conservacion(id) ON DELETE SET NULL;


--
-- Name: estudio_colega_muestra_alternativa ecma_id_estudio_colega_muestra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra_alternativa
    ADD CONSTRAINT ecma_id_estudio_colega_muestra_fkey FOREIGN KEY (id_estudio_colega_muestra) REFERENCES public.estudio_colega_muestra(id) ON DELETE CASCADE;


--
-- Name: estudio_colega_muestra_alternativa ecma_id_modalidad_recoleccion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra_alternativa
    ADD CONSTRAINT ecma_id_modalidad_recoleccion_fkey FOREIGN KEY (id_modalidad_recoleccion) REFERENCES public.modalidad_recoleccion(id) ON DELETE SET NULL;


--
-- Name: estudio_colega_muestra_alternativa ecma_id_prioridad_envio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra_alternativa
    ADD CONSTRAINT ecma_id_prioridad_envio_fkey FOREIGN KEY (id_prioridad_envio) REFERENCES public.prioridad_envio(id) ON DELETE SET NULL;


--
-- Name: estudio_colega_muestra_alternativa ecma_id_recipiente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra_alternativa
    ADD CONSTRAINT ecma_id_recipiente_fkey FOREIGN KEY (id_recipiente) REFERENCES public.recipiente(id) ON DELETE SET NULL;


--
-- Name: estudio_colega_muestra_alternativa ecma_id_tecnica_recoleccion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra_alternativa
    ADD CONSTRAINT ecma_id_tecnica_recoleccion_fkey FOREIGN KEY (id_tecnica_recoleccion) REFERENCES public.tecnica_recoleccion(id) ON DELETE SET NULL;


--
-- Name: estudio_colega_muestra_alternativa ecma_id_tipo_muestra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra_alternativa
    ADD CONSTRAINT ecma_id_tipo_muestra_fkey FOREIGN KEY (id_tipo_muestra) REFERENCES public.tipo_muestra(id);


--
-- Name: estudio_colega_muestra_alternativa ecma_id_unidad_medida_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra_alternativa
    ADD CONSTRAINT ecma_id_unidad_medida_fkey FOREIGN KEY (id_unidad_medida) REFERENCES public.unidad_medida(id) ON DELETE SET NULL;


--
-- Name: estudio_colega_muestra edm_id_aditivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra
    ADD CONSTRAINT edm_id_aditivo_fkey FOREIGN KEY (id_aditivo) REFERENCES public.aditivo(id) ON DELETE SET NULL;


--
-- Name: estudio_colega_muestra edm_id_condicion_especial_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra
    ADD CONSTRAINT edm_id_condicion_especial_fkey FOREIGN KEY (id_condicion_especial) REFERENCES public.condicion_especial(id) ON DELETE SET NULL;


--
-- Name: estudio_colega_muestra edm_id_conservacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra
    ADD CONSTRAINT edm_id_conservacion_fkey FOREIGN KEY (id_conservacion) REFERENCES public.conservacion(id) ON DELETE SET NULL;


--
-- Name: estudio_colega_muestra edm_id_estudio_colega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra
    ADD CONSTRAINT edm_id_estudio_colega_fkey FOREIGN KEY (id_estudio_colega) REFERENCES public.estudio_colega(id) ON DELETE CASCADE;


--
-- Name: estudio_colega_muestra edm_id_modalidad_recoleccion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra
    ADD CONSTRAINT edm_id_modalidad_recoleccion_fkey FOREIGN KEY (id_modalidad_recoleccion) REFERENCES public.modalidad_recoleccion(id) ON DELETE SET NULL;


--
-- Name: estudio_colega_muestra edm_id_prioridad_envio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra
    ADD CONSTRAINT edm_id_prioridad_envio_fkey FOREIGN KEY (id_prioridad_envio) REFERENCES public.prioridad_envio(id) ON DELETE SET NULL;


--
-- Name: estudio_colega_muestra edm_id_recipiente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra
    ADD CONSTRAINT edm_id_recipiente_fkey FOREIGN KEY (id_recipiente) REFERENCES public.recipiente(id) ON DELETE SET NULL;


--
-- Name: estudio_colega_muestra edm_id_tecnica_recoleccion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra
    ADD CONSTRAINT edm_id_tecnica_recoleccion_fkey FOREIGN KEY (id_tecnica_recoleccion) REFERENCES public.tecnica_recoleccion(id) ON DELETE SET NULL;


--
-- Name: estudio_colega_muestra edm_id_tipo_muestra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra
    ADD CONSTRAINT edm_id_tipo_muestra_fkey FOREIGN KEY (id_tipo_muestra) REFERENCES public.tipo_muestra(id);


--
-- Name: estudio_colega_muestra edm_id_unidad_medida_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega_muestra
    ADD CONSTRAINT edm_id_unidad_medida_fkey FOREIGN KEY (id_unidad_medida) REFERENCES public.unidad_medida(id) ON DELETE SET NULL;


--
-- Name: estudio_colega estudio_colega_id_estudio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega
    ADD CONSTRAINT estudio_colega_id_estudio_fkey FOREIGN KEY (id_estudio) REFERENCES public.estudio(id) ON DELETE RESTRICT;


--
-- Name: estudio_colega estudio_colega_id_metodo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega
    ADD CONSTRAINT estudio_colega_id_metodo_fkey FOREIGN KEY (id_metodo) REFERENCES public.metodo(id) ON DELETE SET NULL;


--
-- Name: estudio_colega estudio_colega_id_muestra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega
    ADD CONSTRAINT estudio_colega_id_muestra_fkey FOREIGN KEY (id_muestra) REFERENCES public.muestra(id) ON DELETE SET NULL;


--
-- Name: estudio_colega estudio_colega_id_preanalitico_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega
    ADD CONSTRAINT estudio_colega_id_preanalitico_fkey FOREIGN KEY (id_preanalitico) REFERENCES public.preanalitico(id) ON DELETE SET NULL;


--
-- Name: estudio_colega estudio_colega_id_sector_laboratorio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega
    ADD CONSTRAINT estudio_colega_id_sector_laboratorio_fkey FOREIGN KEY (id_sector_laboratorio) REFERENCES public.valor_estudio_sector(id) ON DELETE SET NULL;


--
-- Name: estudio_colega fk_estudio_colega_colega; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega
    ADD CONSTRAINT fk_estudio_colega_colega FOREIGN KEY (colega_id) REFERENCES public.colega(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: valor_estudio_sector valor_estudio_sector_id_estudio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.valor_estudio_sector
    ADD CONSTRAINT valor_estudio_sector_id_estudio_fkey FOREIGN KEY (id_estudio) REFERENCES public.estudio(id) ON DELETE CASCADE;


--
-- Name: valor_estudio_sector valor_estudio_sector_id_sector_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.valor_estudio_sector
    ADD CONSTRAINT valor_estudio_sector_id_sector_fkey FOREIGN KEY (id_sector) REFERENCES public.sector(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 4OletR0tGoYQc1lG1Y1g1oLVDHqoU03LuPP6fX1nwgB5dwX7z2YnAhflWeXN4zT

