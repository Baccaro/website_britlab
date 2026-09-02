-- Renombra "derivante" a "colega" en todo el esquema (tablas, columnas,
-- constraints, secuencias, vista). Es un rename puro: no se pierde ni se
-- transforma ningún dato.

BEGIN;

DROP VIEW IF EXISTS public.v_estudios_derivantes;

-- Tabla derivante -> colega
ALTER TABLE public.derivante RENAME TO colega;
ALTER SEQUENCE public.derivante_id_seq RENAME TO colega_id_seq;
ALTER TABLE public.colega RENAME CONSTRAINT derivante_pkey TO colega_pkey;

-- Tabla estudio_derivante -> estudio_colega
ALTER TABLE public.estudio_derivante RENAME TO estudio_colega;
ALTER TABLE public.estudio_colega RENAME COLUMN derivante_id TO colega_id;
ALTER SEQUENCE public.estudio_derivante_id_seq RENAME TO estudio_colega_id_seq;
ALTER TABLE public.estudio_colega RENAME CONSTRAINT estudio_derivante_pkey TO estudio_colega_pkey;
ALTER TABLE public.estudio_colega RENAME CONSTRAINT estudio_derivante_id_estudio_fkey TO estudio_colega_id_estudio_fkey;
ALTER TABLE public.estudio_colega RENAME CONSTRAINT estudio_derivante_id_metodo_fkey TO estudio_colega_id_metodo_fkey;
ALTER TABLE public.estudio_colega RENAME CONSTRAINT estudio_derivante_id_muestra_fkey TO estudio_colega_id_muestra_fkey;
ALTER TABLE public.estudio_colega RENAME CONSTRAINT estudio_derivante_id_preanalitico_fkey TO estudio_colega_id_preanalitico_fkey;
ALTER TABLE public.estudio_colega RENAME CONSTRAINT estudio_derivante_id_sector_laboratorio_fkey TO estudio_colega_id_sector_laboratorio_fkey;
ALTER TABLE public.estudio_colega RENAME CONSTRAINT fk_estudio_derivante_derivante TO fk_estudio_colega_colega;

-- Tabla estudio_derivante_muestra -> estudio_colega_muestra
ALTER TABLE public.estudio_derivante_muestra RENAME TO estudio_colega_muestra;
ALTER TABLE public.estudio_colega_muestra RENAME COLUMN id_estudio_derivante TO id_estudio_colega;
ALTER SEQUENCE public.estudio_derivante_muestra_id_seq RENAME TO estudio_colega_muestra_id_seq;
ALTER TABLE public.estudio_colega_muestra RENAME CONSTRAINT estudio_derivante_muestra_pkey TO estudio_colega_muestra_pkey;
ALTER TABLE public.estudio_colega_muestra RENAME CONSTRAINT edm_id_estudio_derivante_fkey TO edm_id_estudio_colega_fkey;

-- Recrear la vista (preexistente, no generada por esta app) con los nombres nuevos
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
    ec.indicaciones,
    ec.valor_referencia,
    ec.dias_demora,
    ec.estado,
    ec.codigo_laboratorio,
    ec.version,
    ec.revisor,
    ec.observacion,
    ec.created_at,
    ec.updated_at
   FROM estudio_colega ec
     JOIN estudio e ON ec.id_estudio = e.id
     LEFT JOIN metodo m ON ec.id_metodo = m.id
     LEFT JOIN preanalitico p ON ec.id_preanalitico = p.id
     LEFT JOIN muestra mu ON ec.id_muestra = mu.id
     LEFT JOIN valor_estudio_sector ves ON ec.id_sector_laboratorio = ves.id
     LEFT JOIN sector sec ON ves.id_sector = sec.id;

COMMIT;
