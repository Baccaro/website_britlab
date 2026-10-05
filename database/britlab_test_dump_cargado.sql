--
-- PostgreSQL database dump
--

\restrict wTh2Cdz7FwaxXYSiWeFBkpbrk3B6P1iZlI93thEwZkieBnJof9rB5ZAKd2VPw7a

-- Dumped from database version 15.18
-- Dumped by pg_dump version 15.18

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
-- Name: autorizador; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.autorizador (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    tipo character varying(30) DEFAULT 'Portal externo'::character varying NOT NULL,
    link text,
    instructivo text,
    observacion text,
    estado character varying(20) DEFAULT 'activo'::character varying NOT NULL,
    creado_por_id integer,
    actualizado_por_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_autorizador_estado CHECK (((estado)::text = ANY (ARRAY[('activo'::character varying)::text, ('inactivo'::character varying)::text]))),
    CONSTRAINT chk_autorizador_tipo CHECK (((tipo)::text = ANY (ARRAY[('Portal externo'::character varying)::text, ('Sistema interno'::character varying)::text])))
);


--
-- Name: autorizador_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.autorizador_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: autorizador_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.autorizador_id_seq OWNED BY public.autorizador.id;


--
-- Name: colega; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.colega (
    id integer NOT NULL,
    descripcion character varying(255) NOT NULL,
    es_propio boolean DEFAULT false NOT NULL,
    habilitado boolean DEFAULT true NOT NULL,
    portal_url text,
    portal_usuario character varying(150),
    portal_password character varying(255),
    observaciones text
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
-- Name: cv; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cv (
    id integer NOT NULL,
    nombre_completo character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    nombre_archivo character varying(255) NOT NULL,
    ruta_archivo character varying(500) NOT NULL,
    tamanio_bytes integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: cv_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cv_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cv_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cv_id_seq OWNED BY public.cv.id;


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
    paridad_datatech_hexalis character varying(20) DEFAULT 'No'::character varying NOT NULL,
    id_estudio integer NOT NULL,
    id_metodo integer,
    id_muestra integer,
    id_sector_laboratorio integer,
    indicaciones_pacientes text,
    dias_demora integer DEFAULT 0,
    estado public.estado_registro_enum DEFAULT 'pendiente'::public.estado_registro_enum NOT NULL,
    codigo_laboratorio character varying(50) DEFAULT NULL::character varying,
    version integer DEFAULT 1 NOT NULL,
    revisor character varying(100) NOT NULL,
    observacion text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    colega_id integer NOT NULL,
    indicaciones_colega text,
    preanalitico_descripcion text,
    modelo_derivante_observaciones text,
    codigo_ams character varying(100),
    habilitar_web boolean DEFAULT false NOT NULL,
    habilitar_ia boolean DEFAULT false NOT NULL,
    creado_por_id integer,
    actualizado_por_id integer
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
    ruta_archivo character varying(500) NOT NULL,
    tamanio_bytes integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    categoria character varying(20) DEFAULT 'colega'::character varying NOT NULL,
    descripcion text,
    CONSTRAINT chk_ecm_categoria CHECK (((categoria)::text = ANY (ARRAY[('preanalitico'::character varying)::text, ('paciente'::character varying)::text, ('colega'::character varying)::text])))
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
-- Name: faq; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.faq (
    id integer NOT NULL,
    pregunta text NOT NULL,
    respuesta text NOT NULL,
    categoria character varying(150) NOT NULL,
    disponible_web boolean DEFAULT false NOT NULL,
    disponible_ia boolean DEFAULT false NOT NULL,
    estado character varying(20) DEFAULT 'borrador'::character varying NOT NULL,
    creado_por_id integer,
    actualizado_por_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_faq_estado CHECK (((estado)::text = ANY (ARRAY[('borrador'::character varying)::text, ('activo'::character varying)::text, ('inactivo'::character varying)::text])))
);


--
-- Name: faq_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.faq_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: faq_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.faq_id_seq OWNED BY public.faq.id;


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
-- Name: nomenclador; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.nomenclador (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    tipo character varying(30) DEFAULT 'NBU'::character varying NOT NULL,
    version_o_fecha character varying(100),
    vigencia character varying(100),
    link text,
    observacion text,
    estado character varying(20) DEFAULT 'activo'::character varying NOT NULL,
    creado_por_id integer,
    actualizado_por_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_nomenclador_estado CHECK (((estado)::text = ANY (ARRAY[('activo'::character varying)::text, ('inactivo'::character varying)::text]))),
    CONSTRAINT chk_nomenclador_tipo CHECK (((tipo)::text = ANY (ARRAY[('NBU'::character varying)::text, ('especial'::character varying)::text, ('convenio_particular'::character varying)::text, ('listado_anexo'::character varying)::text])))
);


--
-- Name: nomenclador_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.nomenclador_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: nomenclador_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.nomenclador_id_seq OWNED BY public.nomenclador.id;


--
-- Name: noticia; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.noticia (
    id integer NOT NULL,
    titulo character varying(255) NOT NULL,
    descripcion text NOT NULL,
    cuerpo text NOT NULL,
    categoria character varying(150) NOT NULL,
    fecha date NOT NULL,
    imagen_nombre_archivo character varying(255),
    imagen_ruta character varying(500),
    creado_por_id integer,
    actualizado_por_id integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: noticia_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.noticia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: noticia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.noticia_id_seq OWNED BY public.noticia.id;


--
-- Name: obra_social; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.obra_social (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    estado character varying(20) DEFAULT 'activo'::character varying NOT NULL,
    estado_informacion character varying(20) DEFAULT 'borrador'::character varying NOT NULL,
    mostrar_web boolean DEFAULT false NOT NULL,
    habilitar_ia boolean DEFAULT false NOT NULL,
    modalidad_autorizacion character varying(50),
    observacion_general text,
    informacion_publica text,
    fecha_ultima_validacion timestamp without time zone,
    validado_por_id integer,
    creado_por_id integer,
    actualizado_por_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_obra_social_estado CHECK (((estado)::text = ANY (ARRAY[('activo'::character varying)::text, ('limitada'::character varying)::text, ('suspendida'::character varying)::text, ('sin_atencion'::character varying)::text]))),
    CONSTRAINT chk_obra_social_estado_info CHECK (((estado_informacion)::text = ANY (ARRAY[('borrador'::character varying)::text, ('validada'::character varying)::text])))
);


--
-- Name: obra_social_alias; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.obra_social_alias (
    id integer NOT NULL,
    id_obra_social integer NOT NULL,
    alias character varying(150) NOT NULL
);


--
-- Name: obra_social_alias_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.obra_social_alias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: obra_social_alias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.obra_social_alias_id_seq OWNED BY public.obra_social_alias.id;


--
-- Name: obra_social_autorizador; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.obra_social_autorizador (
    id integer NOT NULL,
    id_obra_social integer NOT NULL,
    id_autorizador integer NOT NULL,
    prioridad character varying(20) DEFAULT 'principal'::character varying NOT NULL,
    usuario character varying(150),
    password character varying(255),
    observacion text,
    CONSTRAINT chk_obra_social_autorizador_prioridad CHECK (((prioridad)::text = ANY (ARRAY[('principal'::character varying)::text, ('alternativo'::character varying)::text])))
);


--
-- Name: obra_social_autorizador_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.obra_social_autorizador_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: obra_social_autorizador_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.obra_social_autorizador_id_seq OWNED BY public.obra_social_autorizador.id;


--
-- Name: obra_social_contacto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.obra_social_contacto (
    id integer NOT NULL,
    id_obra_social integer NOT NULL,
    tipo character varying(30) DEFAULT 'General'::character varying NOT NULL,
    nombre character varying(150),
    telefono character varying(50),
    whatsapp character varying(50),
    email character varying(150),
    observacion text,
    CONSTRAINT chk_obra_social_contacto_tipo CHECK (((tipo)::text = ANY (ARRAY[('General'::character varying)::text, ('Autorizaciones'::character varying)::text, ('Auditoría'::character varying)::text, ('Convenios'::character varying)::text, ('Facturación'::character varying)::text, ('Otro'::character varying)::text])))
);


--
-- Name: obra_social_contacto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.obra_social_contacto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: obra_social_contacto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.obra_social_contacto_id_seq OWNED BY public.obra_social_contacto.id;


--
-- Name: obra_social_historial_estado; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.obra_social_historial_estado (
    id integer NOT NULL,
    id_obra_social integer NOT NULL,
    id_plan integer,
    estado_anterior character varying(20),
    estado_nuevo character varying(20) NOT NULL,
    comunicado_por character varying(150),
    motivo text,
    creado_por_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: obra_social_historial_estado_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.obra_social_historial_estado_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: obra_social_historial_estado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.obra_social_historial_estado_id_seq OWNED BY public.obra_social_historial_estado.id;


--
-- Name: obra_social_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.obra_social_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: obra_social_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.obra_social_id_seq OWNED BY public.obra_social.id;


--
-- Name: obra_social_nomenclador; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.obra_social_nomenclador (
    id integer NOT NULL,
    id_obra_social integer NOT NULL,
    id_nomenclador integer NOT NULL
);


--
-- Name: obra_social_nomenclador_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.obra_social_nomenclador_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: obra_social_nomenclador_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.obra_social_nomenclador_id_seq OWNED BY public.obra_social_nomenclador.id;


--
-- Name: obra_social_plan; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.obra_social_plan (
    id integer NOT NULL,
    id_obra_social integer NOT NULL,
    nombre character varying(150) NOT NULL,
    codigo_datatech_gravado character varying(50),
    codigo_datatech_exento character varying(50),
    estado character varying(20) DEFAULT 'activo'::character varying NOT NULL,
    observacion text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_obra_social_plan_estado CHECK (((estado)::text = ANY (ARRAY[('activo'::character varying)::text, ('limitada'::character varying)::text, ('suspendida'::character varying)::text, ('sin_atencion'::character varying)::text])))
);


--
-- Name: obra_social_plan_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.obra_social_plan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: obra_social_plan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.obra_social_plan_id_seq OWNED BY public.obra_social_plan.id;


--
-- Name: password_reset_token; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.password_reset_token (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    token character varying(255) NOT NULL,
    expira timestamp without time zone NOT NULL,
    usado boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: password_reset_token_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.password_reset_token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: password_reset_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.password_reset_token_id_seq OWNED BY public.password_reset_token.id;


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
-- Name: tarifario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tarifario (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    tipo character varying(20) DEFAULT 'TARIFARIO'::character varying NOT NULL,
    tipo_relacionado character varying(50) DEFAULT 'Laboratorio / Procesador externo'::character varying NOT NULL,
    entidad character varying(255),
    moneda character varying(10) DEFAULT 'ARS'::character varying NOT NULL,
    estado character varying(20) DEFAULT 'activo'::character varying NOT NULL,
    observaciones text,
    creado_por_id integer,
    actualizado_por_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_tarifario_estado CHECK (((estado)::text = ANY (ARRAY[('activo'::character varying)::text, ('inactivo'::character varying)::text]))),
    CONSTRAINT chk_tarifario_tipo CHECK (((tipo)::text = ANY (ARRAY[('TARIFARIO'::character varying)::text, ('CONVENIO'::character varying)::text, ('DERIVACION'::character varying)::text, ('LISTA'::character varying)::text, ('ANEXO'::character varying)::text])))
);


--
-- Name: tarifario_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tarifario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tarifario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tarifario_id_seq OWNED BY public.tarifario.id;


--
-- Name: tarifario_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tarifario_item (
    id integer NOT NULL,
    id_tarifario integer NOT NULL,
    id_estudio integer NOT NULL,
    nemonico character varying(50),
    codigo character varying(50),
    estado character varying(20) DEFAULT 'Activo'::character varying NOT NULL,
    nota text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_tarifario_item_estado CHECK (((estado)::text = ANY (ARRAY[('Activo'::character varying)::text, ('Inactivo'::character varying)::text])))
);


--
-- Name: tarifario_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tarifario_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tarifario_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tarifario_item_id_seq OWNED BY public.tarifario_item.id;


--
-- Name: tarifario_item_periodo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tarifario_item_periodo (
    id integer NOT NULL,
    id_tarifario_item integer NOT NULL,
    periodo character varying(100) NOT NULL,
    precio numeric(14,2) NOT NULL,
    creado_por_id integer,
    actualizado_por_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: tarifario_item_periodo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tarifario_item_periodo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tarifario_item_periodo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tarifario_item_periodo_id_seq OWNED BY public.tarifario_item_periodo.id;


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
-- Name: usuario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usuario (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    nombre_completo character varying(150),
    email character varying(255),
    password_hash character varying(255) NOT NULL,
    rol character varying(20) DEFAULT 'user'::character varying NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    permisos jsonb,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_usuario_rol CHECK (((rol)::text = ANY (ARRAY[('superadmin'::character varying)::text, ('user'::character varying)::text])))
);


--
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;


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
    ec.id_muestra,
    mu.nombre AS muestra_nombre,
    ec.id_sector_laboratorio,
    sec.nombre AS sector_nombre,
    ves.posicion_informe,
    ves.rango AS sector_rango,
    ec.indicaciones_pacientes,
    ec.indicaciones_colega,
    ec.dias_demora,
    ec.estado,
    ec.codigo_laboratorio,
    ec.version,
    ec.revisor,
    ec.observacion,
    ec.created_at,
    ec.updated_at
   FROM (((((public.estudio_colega ec
     JOIN public.estudio e ON ((ec.id_estudio = e.id)))
     LEFT JOIN public.metodo m ON ((ec.id_metodo = m.id)))
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
-- Name: autorizador id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.autorizador ALTER COLUMN id SET DEFAULT nextval('public.autorizador_id_seq'::regclass);


--
-- Name: condicion_especial id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.condicion_especial ALTER COLUMN id SET DEFAULT nextval('public.condicion_especial_id_seq'::regclass);


--
-- Name: conservacion id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conservacion ALTER COLUMN id SET DEFAULT nextval('public.conservacion_id_seq'::regclass);


--
-- Name: cv id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cv ALTER COLUMN id SET DEFAULT nextval('public.cv_id_seq'::regclass);


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
-- Name: faq id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faq ALTER COLUMN id SET DEFAULT nextval('public.faq_id_seq'::regclass);


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
-- Name: nomenclador id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nomenclador ALTER COLUMN id SET DEFAULT nextval('public.nomenclador_id_seq'::regclass);


--
-- Name: noticia id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.noticia ALTER COLUMN id SET DEFAULT nextval('public.noticia_id_seq'::regclass);


--
-- Name: obra_social id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social ALTER COLUMN id SET DEFAULT nextval('public.obra_social_id_seq'::regclass);


--
-- Name: obra_social_alias id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_alias ALTER COLUMN id SET DEFAULT nextval('public.obra_social_alias_id_seq'::regclass);


--
-- Name: obra_social_autorizador id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_autorizador ALTER COLUMN id SET DEFAULT nextval('public.obra_social_autorizador_id_seq'::regclass);


--
-- Name: obra_social_contacto id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_contacto ALTER COLUMN id SET DEFAULT nextval('public.obra_social_contacto_id_seq'::regclass);


--
-- Name: obra_social_historial_estado id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_historial_estado ALTER COLUMN id SET DEFAULT nextval('public.obra_social_historial_estado_id_seq'::regclass);


--
-- Name: obra_social_nomenclador id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_nomenclador ALTER COLUMN id SET DEFAULT nextval('public.obra_social_nomenclador_id_seq'::regclass);


--
-- Name: obra_social_plan id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_plan ALTER COLUMN id SET DEFAULT nextval('public.obra_social_plan_id_seq'::regclass);


--
-- Name: password_reset_token id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_token ALTER COLUMN id SET DEFAULT nextval('public.password_reset_token_id_seq'::regclass);


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
-- Name: tarifario id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tarifario ALTER COLUMN id SET DEFAULT nextval('public.tarifario_id_seq'::regclass);


--
-- Name: tarifario_item id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tarifario_item ALTER COLUMN id SET DEFAULT nextval('public.tarifario_item_id_seq'::regclass);


--
-- Name: tarifario_item_periodo id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tarifario_item_periodo ALTER COLUMN id SET DEFAULT nextval('public.tarifario_item_periodo_id_seq'::regclass);


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
-- Name: usuario id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);


--
-- Name: valor_estudio_sector id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.valor_estudio_sector ALTER COLUMN id SET DEFAULT nextval('public.valor_estudio_sector_id_seq'::regclass);


--
-- Data for Name: aditivo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.aditivo (id, nombre) FROM stdin;
\.


--
-- Data for Name: autorizador; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.autorizador (id, nombre, tipo, link, instructivo, observacion, estado, creado_por_id, actualizado_por_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: colega; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.colega (id, descripcion, es_propio, habilitado, portal_url, portal_usuario, portal_password, observaciones) FROM stdin;
\.


--
-- Data for Name: condicion_especial; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.condicion_especial (id, nombre) FROM stdin;
\.


--
-- Data for Name: conservacion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.conservacion (id, nombre) FROM stdin;
\.


--
-- Data for Name: cv; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cv (id, nombre_completo, email, nombre_archivo, ruta_archivo, tamanio_bytes, created_at) FROM stdin;
\.


--
-- Data for Name: estudio; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.estudio (id, codigo_hexalis, descripcion) FROM stdin;
\.


--
-- Data for Name: estudio_colega; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.estudio_colega (id, nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, id_muestra, id_sector_laboratorio, indicaciones_pacientes, dias_demora, estado, codigo_laboratorio, version, revisor, observacion, created_at, updated_at, colega_id, indicaciones_colega, preanalitico_descripcion, modelo_derivante_observaciones, codigo_ams, habilitar_web, habilitar_ia, creado_por_id, actualizado_por_id) FROM stdin;
\.


--
-- Data for Name: estudio_colega_modelo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.estudio_colega_modelo (id, id_estudio_colega, nombre_archivo, ruta_archivo, tamanio_bytes, created_at, categoria, descripcion) FROM stdin;
\.


--
-- Data for Name: estudio_colega_muestra; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.estudio_colega_muestra (id, id_estudio_colega, id_tipo_muestra, id_aditivo, volumen, id_unidad_medida, id_recipiente, id_modalidad_recoleccion, id_tecnica_recoleccion, id_conservacion, id_condicion_especial, id_prioridad_envio, created_at, orden, observacion) FROM stdin;
\.


--
-- Data for Name: estudio_colega_muestra_alternativa; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.estudio_colega_muestra_alternativa (id, id_estudio_colega_muestra, id_tipo_muestra, id_aditivo, volumen, id_unidad_medida, id_recipiente, id_modalidad_recoleccion, id_tecnica_recoleccion, id_conservacion, id_condicion_especial, id_prioridad_envio, orden, observacion, created_at) FROM stdin;
\.


--
-- Data for Name: faq; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.faq (id, pregunta, respuesta, categoria, disponible_web, disponible_ia, estado, creado_por_id, actualizado_por_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: metodo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.metodo (id, nombre, descripcion) FROM stdin;
\.


--
-- Data for Name: modalidad_recoleccion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.modalidad_recoleccion (id, nombre) FROM stdin;
\.


--
-- Data for Name: muestra; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.muestra (id, nombre, observacion) FROM stdin;
\.


--
-- Data for Name: nomenclador; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.nomenclador (id, nombre, tipo, version_o_fecha, vigencia, link, observacion, estado, creado_por_id, actualizado_por_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: noticia; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.noticia (id, titulo, descripcion, cuerpo, categoria, fecha, imagen_nombre_archivo, imagen_ruta, creado_por_id, actualizado_por_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: obra_social; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.obra_social (id, nombre, estado, estado_informacion, mostrar_web, habilitar_ia, modalidad_autorizacion, observacion_general, informacion_publica, fecha_ultima_validacion, validado_por_id, creado_por_id, actualizado_por_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: obra_social_alias; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.obra_social_alias (id, id_obra_social, alias) FROM stdin;
\.


--
-- Data for Name: obra_social_autorizador; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.obra_social_autorizador (id, id_obra_social, id_autorizador, prioridad, usuario, password, observacion) FROM stdin;
\.


--
-- Data for Name: obra_social_contacto; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.obra_social_contacto (id, id_obra_social, tipo, nombre, telefono, whatsapp, email, observacion) FROM stdin;
\.


--
-- Data for Name: obra_social_historial_estado; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.obra_social_historial_estado (id, id_obra_social, id_plan, estado_anterior, estado_nuevo, comunicado_por, motivo, creado_por_id, created_at) FROM stdin;
\.


--
-- Data for Name: obra_social_nomenclador; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.obra_social_nomenclador (id, id_obra_social, id_nomenclador) FROM stdin;
\.


--
-- Data for Name: obra_social_plan; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.obra_social_plan (id, id_obra_social, nombre, codigo_datatech_gravado, codigo_datatech_exento, estado, observacion, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: password_reset_token; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.password_reset_token (id, id_usuario, token, expira, usado, created_at) FROM stdin;
\.


--
-- Data for Name: prioridad_envio; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.prioridad_envio (id, nombre) FROM stdin;
\.


--
-- Data for Name: recipiente; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.recipiente (id, nombre) FROM stdin;
\.


--
-- Data for Name: sector; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sector (id, nombre) FROM stdin;
\.


--
-- Data for Name: tarifario; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tarifario (id, nombre, tipo, tipo_relacionado, entidad, moneda, estado, observaciones, creado_por_id, actualizado_por_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: tarifario_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tarifario_item (id, id_tarifario, id_estudio, nemonico, codigo, estado, nota, created_at) FROM stdin;
\.


--
-- Data for Name: tarifario_item_periodo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tarifario_item_periodo (id, id_tarifario_item, periodo, precio, creado_por_id, actualizado_por_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: tecnica_recoleccion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tecnica_recoleccion (id, nombre) FROM stdin;
\.


--
-- Data for Name: tipo_muestra; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tipo_muestra (id, nombre) FROM stdin;
\.


--
-- Data for Name: unidad_medida; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.unidad_medida (id, nombre) FROM stdin;
\.


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.usuario (id, username, nombre_completo, email, password_hash, rol, activo, permisos, created_at) FROM stdin;
1	nbojanich	nbojanich	\N	scrypt:32768:8:1$U8dn7aspZMVGEXvT$bfe6e06e30e5c772b95f6bb0ff0b8011de6d236193fcb8432f00a72d13f9a23081e21fe353e70ad53965d4e1074a455b62ac459c003470b7c22c19589f04ef9c	superadmin	t	\N	2026-09-09 15:32:03.530391
3	rbaccaro	rbaccaro	\N	scrypt:32768:8:1$xKmP2lSFVdj38lIm$245e98e6fb6d0fd60c79d2d62736dce3dde38a95feea071d9dc5b7ee6c48f5dead2f55ceca368cdff1068b7b8d884bd4587a5d84a4e329384ca918aeafdf5986	superadmin	t	\N	2026-09-09 15:32:03.530391
8	test	test gonzales	tgonzales@gmail.com	scrypt:32768:8:1$4E91aeoxbBXatWhq$1c56abdb3236e011f010403440914cd2c8ffb214a26e9f73d3c0732ac3d23391debcac5d670ea1e57c72552a27103ad2ebcffb533acf70aec1e7a94e07439c1c	user	t	{"modulos": {"estudios": "consultor"}, "columnas_ocultas_estudios": ["estudio_descripcion", "codigo_hexalis", "nemonico_datatech", "colega_descripcion", "muestra", "indicaciones_pacientes", "estado", "observacion"]}	2026-09-09 16:02:46.471077
2	ccarletti	ccarletti	\N	scrypt:32768:8:1$hTlXxdD77lNvONAD$5a96c5333c760db74d941d8a8222ec0a3ba9cb90a357eeec9521b3453e12b9433c129f158a57f1a701ea71785bcced7e1b471889d2bebc0c75ab701e2005a288	superadmin	t	{"columnas_ocultas_estudios": null}	2026-09-09 15:32:03.530391
15	test2	testi	testo@gmail.com	scrypt:32768:8:1$6IrfZIgg7CwP6Xg3$5e2a61406b0265b341d2bfae3ae5f5e6f73dec96297920df7b9e40024d714a056af2c66725397e7881dde3aa2becc2176db717d448690302e6cdf7faf65f2d39	user	t	{"modulos": {"estudios": "consultor"}, "ver_credenciales_colegas": false, "columnas_ocultas_estudios": ["revisor"]}	2026-09-15 17:09:22.097073
19	qa_tarifarios	QA Tarifarios	\N	scrypt:32768:8:1$831eIaUlVhWlKJJU$8c99841f9ec55e6ad54c7ceed6ac223cebc0679ebfc6184641705b274de25126904c7fbe4b29ca96daec6d2cc68d252ac6d6dec84ca6ce8e40190a5373458362	user	f	{"modulos": {"obras_sociales": "administrador"}}	2026-09-22 23:07:45.389103
\.


--
-- Data for Name: valor_estudio_sector; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.valor_estudio_sector (id, id_estudio, posicion_informe, rango, id_sector) FROM stdin;
\.


--
-- Name: aditivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.aditivo_id_seq', 1, false);


--
-- Name: autorizador_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.autorizador_id_seq', 1, false);


--
-- Name: colega_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.colega_id_seq', 1, false);


--
-- Name: condicion_especial_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.condicion_especial_id_seq', 1, false);


--
-- Name: conservacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.conservacion_id_seq', 1, false);


--
-- Name: cv_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cv_id_seq', 1, false);


--
-- Name: estudio_colega_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estudio_colega_id_seq', 1, false);


--
-- Name: estudio_colega_modelo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estudio_colega_modelo_id_seq', 1, false);


--
-- Name: estudio_colega_muestra_alternativa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estudio_colega_muestra_alternativa_id_seq', 1, false);


--
-- Name: estudio_colega_muestra_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estudio_colega_muestra_id_seq', 1, false);


--
-- Name: estudio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estudio_id_seq', 1, false);


--
-- Name: faq_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.faq_id_seq', 1, false);


--
-- Name: metodo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.metodo_id_seq', 1, false);


--
-- Name: modalidad_recoleccion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.modalidad_recoleccion_id_seq', 1, false);


--
-- Name: muestra_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.muestra_id_seq', 1, false);


--
-- Name: nomenclador_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.nomenclador_id_seq', 1, false);


--
-- Name: noticia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.noticia_id_seq', 1, false);


--
-- Name: obra_social_alias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.obra_social_alias_id_seq', 1, false);


--
-- Name: obra_social_autorizador_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.obra_social_autorizador_id_seq', 1, false);


--
-- Name: obra_social_contacto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.obra_social_contacto_id_seq', 1, false);


--
-- Name: obra_social_historial_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.obra_social_historial_estado_id_seq', 1, false);


--
-- Name: obra_social_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.obra_social_id_seq', 1, false);


--
-- Name: obra_social_nomenclador_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.obra_social_nomenclador_id_seq', 1, false);


--
-- Name: obra_social_plan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.obra_social_plan_id_seq', 1, false);


--
-- Name: password_reset_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.password_reset_token_id_seq', 1, false);


--
-- Name: prioridad_envio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.prioridad_envio_id_seq', 1, false);


--
-- Name: recipiente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.recipiente_id_seq', 1, false);


--
-- Name: sector_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sector_id_seq', 1, false);


--
-- Name: tarifario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tarifario_id_seq', 1, false);


--
-- Name: tarifario_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tarifario_item_id_seq', 1, false);


--
-- Name: tarifario_item_periodo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tarifario_item_periodo_id_seq', 1, false);


--
-- Name: tecnica_recoleccion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tecnica_recoleccion_id_seq', 1, false);


--
-- Name: tipo_muestra_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tipo_muestra_id_seq', 1, false);


--
-- Name: unidad_medida_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.unidad_medida_id_seq', 1, false);


--
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.usuario_id_seq', 19, true);


--
-- Name: valor_estudio_sector_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.valor_estudio_sector_id_seq', 1, false);


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
-- Name: autorizador autorizador_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.autorizador
    ADD CONSTRAINT autorizador_pkey PRIMARY KEY (id);


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
-- Name: cv cv_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cv
    ADD CONSTRAINT cv_pkey PRIMARY KEY (id);


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
-- Name: faq faq_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faq
    ADD CONSTRAINT faq_pkey PRIMARY KEY (id);


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
-- Name: nomenclador nomenclador_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nomenclador
    ADD CONSTRAINT nomenclador_pkey PRIMARY KEY (id);


--
-- Name: noticia noticia_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.noticia
    ADD CONSTRAINT noticia_pkey PRIMARY KEY (id);


--
-- Name: obra_social_alias obra_social_alias_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_alias
    ADD CONSTRAINT obra_social_alias_pkey PRIMARY KEY (id);


--
-- Name: obra_social_autorizador obra_social_autorizador_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_autorizador
    ADD CONSTRAINT obra_social_autorizador_pkey PRIMARY KEY (id);


--
-- Name: obra_social_contacto obra_social_contacto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_contacto
    ADD CONSTRAINT obra_social_contacto_pkey PRIMARY KEY (id);


--
-- Name: obra_social_historial_estado obra_social_historial_estado_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_historial_estado
    ADD CONSTRAINT obra_social_historial_estado_pkey PRIMARY KEY (id);


--
-- Name: obra_social_nomenclador obra_social_nomenclador_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_nomenclador
    ADD CONSTRAINT obra_social_nomenclador_pkey PRIMARY KEY (id);


--
-- Name: obra_social obra_social_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social
    ADD CONSTRAINT obra_social_pkey PRIMARY KEY (id);


--
-- Name: obra_social_plan obra_social_plan_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_plan
    ADD CONSTRAINT obra_social_plan_pkey PRIMARY KEY (id);


--
-- Name: password_reset_token password_reset_token_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_token
    ADD CONSTRAINT password_reset_token_pkey PRIMARY KEY (id);


--
-- Name: password_reset_token password_reset_token_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_token
    ADD CONSTRAINT password_reset_token_token_key UNIQUE (token);


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
-- Name: tarifario_item_periodo tarifario_item_periodo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tarifario_item_periodo
    ADD CONSTRAINT tarifario_item_periodo_pkey PRIMARY KEY (id);


--
-- Name: tarifario_item tarifario_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tarifario_item
    ADD CONSTRAINT tarifario_item_pkey PRIMARY KEY (id);


--
-- Name: tarifario tarifario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tarifario
    ADD CONSTRAINT tarifario_pkey PRIMARY KEY (id);


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
-- Name: colega uq_colega_descripcion; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.colega
    ADD CONSTRAINT uq_colega_descripcion UNIQUE (descripcion);


--
-- Name: valor_estudio_sector uq_estudio_sector_posicion; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.valor_estudio_sector
    ADD CONSTRAINT uq_estudio_sector_posicion UNIQUE (id_estudio, id_sector, posicion_informe);


--
-- Name: obra_social_autorizador uq_obra_social_autorizador; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_autorizador
    ADD CONSTRAINT uq_obra_social_autorizador UNIQUE (id_obra_social, id_autorizador);


--
-- Name: obra_social_nomenclador uq_obra_social_nomenclador; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_nomenclador
    ADD CONSTRAINT uq_obra_social_nomenclador UNIQUE (id_obra_social, id_nomenclador);


--
-- Name: tarifario_item_periodo uq_tarifario_item_periodo; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tarifario_item_periodo
    ADD CONSTRAINT uq_tarifario_item_periodo UNIQUE (id_tarifario_item, periodo);


--
-- Name: usuario usuario_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);


--
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- Name: usuario usuario_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_username_key UNIQUE (username);


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
-- Name: idx_faq_categoria; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_faq_categoria ON public.faq USING btree (categoria);


--
-- Name: idx_obra_social_alias_obra_social; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_obra_social_alias_obra_social ON public.obra_social_alias USING btree (id_obra_social);


--
-- Name: idx_obra_social_contacto_obra_social; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_obra_social_contacto_obra_social ON public.obra_social_contacto USING btree (id_obra_social);


--
-- Name: idx_obra_social_historial_obra_social; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_obra_social_historial_obra_social ON public.obra_social_historial_estado USING btree (id_obra_social, created_at);


--
-- Name: idx_obra_social_plan_obra_social; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_obra_social_plan_obra_social ON public.obra_social_plan USING btree (id_obra_social);


--
-- Name: idx_password_reset_token_usuario; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_password_reset_token_usuario ON public.password_reset_token USING btree (id_usuario);


--
-- Name: idx_tarifario_item_periodo_item; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tarifario_item_periodo_item ON public.tarifario_item_periodo USING btree (id_tarifario_item, created_at);


--
-- Name: idx_tarifario_item_tarifario; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tarifario_item_tarifario ON public.tarifario_item USING btree (id_tarifario);


--
-- Name: autorizador autorizador_actualizado_por_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.autorizador
    ADD CONSTRAINT autorizador_actualizado_por_id_fkey FOREIGN KEY (actualizado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL;


--
-- Name: autorizador autorizador_creado_por_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.autorizador
    ADD CONSTRAINT autorizador_creado_por_id_fkey FOREIGN KEY (creado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL;


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
-- Name: estudio_colega estudio_colega_actualizado_por_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega
    ADD CONSTRAINT estudio_colega_actualizado_por_id_fkey FOREIGN KEY (actualizado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL;


--
-- Name: estudio_colega estudio_colega_creado_por_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega
    ADD CONSTRAINT estudio_colega_creado_por_id_fkey FOREIGN KEY (creado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL;


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
-- Name: estudio_colega estudio_colega_id_sector_laboratorio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega
    ADD CONSTRAINT estudio_colega_id_sector_laboratorio_fkey FOREIGN KEY (id_sector_laboratorio) REFERENCES public.valor_estudio_sector(id) ON DELETE SET NULL;


--
-- Name: faq faq_actualizado_por_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faq
    ADD CONSTRAINT faq_actualizado_por_id_fkey FOREIGN KEY (actualizado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL;


--
-- Name: faq faq_creado_por_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faq
    ADD CONSTRAINT faq_creado_por_id_fkey FOREIGN KEY (creado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL;


--
-- Name: estudio_colega fk_estudio_colega_colega; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudio_colega
    ADD CONSTRAINT fk_estudio_colega_colega FOREIGN KEY (colega_id) REFERENCES public.colega(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: nomenclador nomenclador_actualizado_por_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nomenclador
    ADD CONSTRAINT nomenclador_actualizado_por_id_fkey FOREIGN KEY (actualizado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL;


--
-- Name: nomenclador nomenclador_creado_por_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nomenclador
    ADD CONSTRAINT nomenclador_creado_por_id_fkey FOREIGN KEY (creado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL;


--
-- Name: noticia noticia_actualizado_por_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.noticia
    ADD CONSTRAINT noticia_actualizado_por_id_fkey FOREIGN KEY (actualizado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL;


--
-- Name: noticia noticia_creado_por_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.noticia
    ADD CONSTRAINT noticia_creado_por_id_fkey FOREIGN KEY (creado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL;


--
-- Name: obra_social obra_social_actualizado_por_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social
    ADD CONSTRAINT obra_social_actualizado_por_id_fkey FOREIGN KEY (actualizado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL;


--
-- Name: obra_social_alias obra_social_alias_id_obra_social_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_alias
    ADD CONSTRAINT obra_social_alias_id_obra_social_fkey FOREIGN KEY (id_obra_social) REFERENCES public.obra_social(id) ON DELETE CASCADE;


--
-- Name: obra_social_autorizador obra_social_autorizador_id_autorizador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_autorizador
    ADD CONSTRAINT obra_social_autorizador_id_autorizador_fkey FOREIGN KEY (id_autorizador) REFERENCES public.autorizador(id) ON DELETE RESTRICT;


--
-- Name: obra_social_autorizador obra_social_autorizador_id_obra_social_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_autorizador
    ADD CONSTRAINT obra_social_autorizador_id_obra_social_fkey FOREIGN KEY (id_obra_social) REFERENCES public.obra_social(id) ON DELETE CASCADE;


--
-- Name: obra_social_contacto obra_social_contacto_id_obra_social_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_contacto
    ADD CONSTRAINT obra_social_contacto_id_obra_social_fkey FOREIGN KEY (id_obra_social) REFERENCES public.obra_social(id) ON DELETE CASCADE;


--
-- Name: obra_social obra_social_creado_por_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social
    ADD CONSTRAINT obra_social_creado_por_id_fkey FOREIGN KEY (creado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL;


--
-- Name: obra_social_historial_estado obra_social_historial_estado_creado_por_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_historial_estado
    ADD CONSTRAINT obra_social_historial_estado_creado_por_id_fkey FOREIGN KEY (creado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL;


--
-- Name: obra_social_historial_estado obra_social_historial_estado_id_obra_social_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_historial_estado
    ADD CONSTRAINT obra_social_historial_estado_id_obra_social_fkey FOREIGN KEY (id_obra_social) REFERENCES public.obra_social(id) ON DELETE CASCADE;


--
-- Name: obra_social_historial_estado obra_social_historial_estado_id_plan_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_historial_estado
    ADD CONSTRAINT obra_social_historial_estado_id_plan_fkey FOREIGN KEY (id_plan) REFERENCES public.obra_social_plan(id) ON DELETE CASCADE;


--
-- Name: obra_social_nomenclador obra_social_nomenclador_id_nomenclador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_nomenclador
    ADD CONSTRAINT obra_social_nomenclador_id_nomenclador_fkey FOREIGN KEY (id_nomenclador) REFERENCES public.nomenclador(id) ON DELETE RESTRICT;


--
-- Name: obra_social_nomenclador obra_social_nomenclador_id_obra_social_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_nomenclador
    ADD CONSTRAINT obra_social_nomenclador_id_obra_social_fkey FOREIGN KEY (id_obra_social) REFERENCES public.obra_social(id) ON DELETE CASCADE;


--
-- Name: obra_social_plan obra_social_plan_id_obra_social_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social_plan
    ADD CONSTRAINT obra_social_plan_id_obra_social_fkey FOREIGN KEY (id_obra_social) REFERENCES public.obra_social(id) ON DELETE CASCADE;


--
-- Name: obra_social obra_social_validado_por_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.obra_social
    ADD CONSTRAINT obra_social_validado_por_id_fkey FOREIGN KEY (validado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL;


--
-- Name: password_reset_token password_reset_token_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_token
    ADD CONSTRAINT password_reset_token_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- Name: tarifario tarifario_actualizado_por_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tarifario
    ADD CONSTRAINT tarifario_actualizado_por_id_fkey FOREIGN KEY (actualizado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL;


--
-- Name: tarifario tarifario_creado_por_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tarifario
    ADD CONSTRAINT tarifario_creado_por_id_fkey FOREIGN KEY (creado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL;


--
-- Name: tarifario_item tarifario_item_id_estudio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tarifario_item
    ADD CONSTRAINT tarifario_item_id_estudio_fkey FOREIGN KEY (id_estudio) REFERENCES public.estudio(id) ON DELETE RESTRICT;


--
-- Name: tarifario_item tarifario_item_id_tarifario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tarifario_item
    ADD CONSTRAINT tarifario_item_id_tarifario_fkey FOREIGN KEY (id_tarifario) REFERENCES public.tarifario(id) ON DELETE CASCADE;


--
-- Name: tarifario_item_periodo tarifario_item_periodo_actualizado_por_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tarifario_item_periodo
    ADD CONSTRAINT tarifario_item_periodo_actualizado_por_id_fkey FOREIGN KEY (actualizado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL;


--
-- Name: tarifario_item_periodo tarifario_item_periodo_creado_por_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tarifario_item_periodo
    ADD CONSTRAINT tarifario_item_periodo_creado_por_id_fkey FOREIGN KEY (creado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL;


--
-- Name: tarifario_item_periodo tarifario_item_periodo_id_tarifario_item_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tarifario_item_periodo
    ADD CONSTRAINT tarifario_item_periodo_id_tarifario_item_fkey FOREIGN KEY (id_tarifario_item) REFERENCES public.tarifario_item(id) ON DELETE CASCADE;


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

\unrestrict wTh2Cdz7FwaxXYSiWeFBkpbrk3B6P1iZlI93thEwZkieBnJof9rB5ZAKd2VPw7a

