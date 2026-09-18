-- "Paridad" (estudio_colega.paridad_datatech_hexalis) pasa de mostrar el
-- enum de 5 valores (listo/pendiente/revisar/inactivo/discontinuado) a un
-- desplegable Sí/No en el formulario. La columna ya se manejaba como texto
-- plano del lado de SQLAlchemy; ahora también lo es en la base (se saca el
-- enum estado_paridad_enum), sin tocar los valores ya cargados.
BEGIN;

-- Vista legacy no usada por la app (nada en flask-lab-api la referencia),
-- pero depende de la columna: hay que sacarla del medio y recrearla igual.
DROP VIEW IF EXISTS public.v_estudios_colegas;

ALTER TABLE public.estudio_colega ALTER COLUMN paridad_datatech_hexalis DROP DEFAULT;
ALTER TABLE public.estudio_colega
    ALTER COLUMN paridad_datatech_hexalis TYPE varchar(20) USING paridad_datatech_hexalis::text;
ALTER TABLE public.estudio_colega ALTER COLUMN paridad_datatech_hexalis SET DEFAULT 'No';

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
