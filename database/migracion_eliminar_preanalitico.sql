-- Se elimina el catálogo "preanalitico" (tabla + FK id_preanalitico en
-- estudio_colega) y el campo valor_referencia: ambos quedan reemplazados por
-- el dropdown "Preanalítico" (preanalitico_descripcion + PDFs), que NO se ve
-- afectado por esta migración.
--
-- Esto borra datos reales: al momento de escribir esta migración había 25
-- registros en preanalitico, 151 estudio_colega con id_preanalitico cargado
-- y 639 con valor_referencia cargado. Se pierden a propósito, por pedido
-- explícito.
BEGIN;

-- v_estudios_colegas (vista legacy, sin uso en la app: la arma en Python
-- app/routes/estudio_colega.py) depende de ambas columnas; se recrea sin
-- ellas siguiendo el mismo patrón de las migraciones anteriores que ya la
-- tocaron (drop + create).
DROP VIEW IF EXISTS public.v_estudios_colegas;

ALTER TABLE public.estudio_colega DROP COLUMN id_preanalitico;
ALTER TABLE public.estudio_colega DROP COLUMN valor_referencia;
DROP TABLE public.preanalitico;

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
   FROM estudio_colega ec
     JOIN estudio e ON ec.id_estudio = e.id
     LEFT JOIN metodo m ON ec.id_metodo = m.id
     LEFT JOIN muestra mu ON ec.id_muestra = mu.id
     LEFT JOIN valor_estudio_sector ves ON ec.id_sector_laboratorio = ves.id
     LEFT JOIN sector sec ON ves.id_sector = sec.id;

COMMIT;
