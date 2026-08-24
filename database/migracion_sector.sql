-- Separa sector_laboratorio en dos tablas:
--   sector: catálogo simple de sectores (Hematología, Hemostasia, Química, ...)
--   valor_estudio_sector: la posición/rango de un estudio dentro de un sector
--                          (lo que antes vivía todo junto en sector_laboratorio)
BEGIN;

-- La vista v_estudios_derivantes (preexistente, no generada por esta app) depende
-- de sector_laboratorio.descripcion; se recrea al final contra el esquema nuevo
-- (y de paso se le agrega derivante_id, que le faltaba para poder filtrar por derivante).
DROP VIEW IF EXISTS public.v_estudios_derivantes;

CREATE TABLE public.sector (
    id serial4 NOT NULL,
    nombre varchar(150) NOT NULL,
    CONSTRAINT sector_pkey PRIMARY KEY (id),
    CONSTRAINT sector_nombre_key UNIQUE (nombre)
);

INSERT INTO public.sector (nombre)
    SELECT DISTINCT descripcion FROM public.sector_laboratorio ORDER BY 1;

ALTER TABLE public.sector_laboratorio ADD COLUMN id_sector int4;

UPDATE public.sector_laboratorio sl
    SET id_sector = s.id
    FROM public.sector s
    WHERE s.nombre = sl.descripcion;

ALTER TABLE public.sector_laboratorio ALTER COLUMN id_sector SET NOT NULL;
ALTER TABLE public.sector_laboratorio
    ADD CONSTRAINT sector_laboratorio_id_sector_fkey FOREIGN KEY (id_sector) REFERENCES public.sector(id);

ALTER TABLE public.sector_laboratorio DROP CONSTRAINT uq_estudio_sector_posicion;
ALTER TABLE public.sector_laboratorio DROP COLUMN descripcion;
ALTER TABLE public.sector_laboratorio
    ADD CONSTRAINT uq_estudio_sector_posicion UNIQUE (id_estudio, id_sector, posicion_informe);

ALTER TABLE public.sector_laboratorio RENAME TO valor_estudio_sector;
ALTER TABLE public.valor_estudio_sector RENAME CONSTRAINT sector_laboratorio_pkey TO valor_estudio_sector_pkey;
ALTER TABLE public.valor_estudio_sector RENAME CONSTRAINT sector_laboratorio_id_estudio_fkey TO valor_estudio_sector_id_estudio_fkey;
ALTER TABLE public.valor_estudio_sector RENAME CONSTRAINT sector_laboratorio_id_sector_fkey TO valor_estudio_sector_id_sector_fkey;
ALTER SEQUENCE public.sector_laboratorio_id_seq RENAME TO valor_estudio_sector_id_seq;

CREATE VIEW public.v_estudios_derivantes AS
 SELECT ed.id,
    ed.nemonico_datatech,
    ed.paridad_datatech_hexalis,
    ed.derivante_id,
    ed.id_estudio,
    e.codigo_hexalis,
    e.descripcion AS estudio_descripcion,
    ed.id_metodo,
    m.nombre AS metodo_nombre,
    ed.id_preanalitico,
    p.nombre AS preanalitico_nombre,
    ed.id_muestra,
    mu.nombre AS muestra_nombre,
    ed.id_sector_laboratorio,
    sec.nombre AS sector_nombre,
    ves.posicion_informe,
    ves.rango AS sector_rango,
    ed.indicaciones,
    ed.valor_referencia,
    ed.dias_demora,
    ed.estado,
    ed.codigo_laboratorio,
    ed.version,
    ed.revisor,
    ed.observacion,
    ed.created_at,
    ed.updated_at
   FROM estudio_derivante ed
     JOIN estudio e ON ed.id_estudio = e.id
     LEFT JOIN metodo m ON ed.id_metodo = m.id
     LEFT JOIN preanalitico p ON ed.id_preanalitico = p.id
     LEFT JOIN muestra mu ON ed.id_muestra = mu.id
     LEFT JOIN valor_estudio_sector ves ON ed.id_sector_laboratorio = ves.id
     LEFT JOIN sector sec ON ves.id_sector = sec.id;

COMMIT;
