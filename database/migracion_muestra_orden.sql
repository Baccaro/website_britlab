-- Agrega orden (para poder tener N alternativas ordenadas, la de orden=1 es
-- la "Principal") y una observación puntual por muestra a estudio_colega_muestra.

BEGIN;

ALTER TABLE public.estudio_colega_muestra ADD COLUMN orden int4 NOT NULL DEFAULT 1;
ALTER TABLE public.estudio_colega_muestra ADD COLUMN observacion text NULL;

-- Para las muestras ya cargadas, numerar el orden según su id dentro de cada
-- estudio_colega (así la primera cargada queda como "Principal").
WITH numeradas AS (
    SELECT id, row_number() OVER (PARTITION BY id_estudio_colega ORDER BY id) AS rn
    FROM public.estudio_colega_muestra
)
UPDATE public.estudio_colega_muestra ecm
SET orden = numeradas.rn
FROM numeradas
WHERE numeradas.id = ecm.id;

COMMIT;
