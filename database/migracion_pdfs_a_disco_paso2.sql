-- Paso 2 de 2: sólo correr DESPUÉS de que database/migrar_pdfs_a_disco.py
-- terminó de escribir todos los PDFs a disco y completar "ruta_archivo" en
-- cada fila (si algún registro queda con ruta_archivo NULL acá, el
-- NOT NULL de abajo va a fallar y no se va a perder nada: revisá el
-- resultado del script antes de correr esto).
BEGIN;

ALTER TABLE public.estudio_colega_modelo ALTER COLUMN ruta_archivo SET NOT NULL;
ALTER TABLE public.estudio_colega_modelo DROP COLUMN contenido;

COMMIT;
