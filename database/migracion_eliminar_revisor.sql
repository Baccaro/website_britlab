-- Elimina el campo "revisor" de estudio_colega (pedido explícito): la
-- auditoría de quién cargó/modificó el registro queda sólo a cargo de
-- creado_por_id / actualizado_por_id (ya existentes), que es lo único que
-- debe quedar.
--
-- v_estudios_colegas (vista legacy, sin uso en la app) depende de la
-- columna: se recrea sin revisor, mismo patrón ya usado en
-- migracion_eliminar_preanalitico.sql / migracion_paridad_texto_libre.sql /
-- migracion_indicaciones_paciente_colega.sql.
BEGIN;

DROP VIEW IF EXISTS public.v_estudios_colegas;

ALTER TABLE public.estudio_colega DROP COLUMN revisor;

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
