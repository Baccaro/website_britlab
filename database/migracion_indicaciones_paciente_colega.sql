-- Separa 'indicaciones' de estudio_colega en dos columnas: lo que existía
-- hasta ahora pasa a 'indicaciones_pacientes' (rename puro, sin pérdida de
-- datos), y se agrega 'indicaciones_colega' nueva (vacía).

BEGIN;

DROP VIEW IF EXISTS public.v_estudios_colegas;

ALTER TABLE public.estudio_colega RENAME COLUMN indicaciones TO indicaciones_pacientes;
ALTER TABLE public.estudio_colega ADD COLUMN indicaciones_colega text NULL;

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
   FROM estudio_colega ec
     JOIN estudio e ON ec.id_estudio = e.id
     LEFT JOIN metodo m ON ec.id_metodo = m.id
     LEFT JOIN preanalitico p ON ec.id_preanalitico = p.id
     LEFT JOIN muestra mu ON ec.id_muestra = mu.id
     LEFT JOIN valor_estudio_sector ves ON ec.id_sector_laboratorio = ves.id
     LEFT JOIN sector sec ON ves.id_sector = sec.id;

COMMIT;
