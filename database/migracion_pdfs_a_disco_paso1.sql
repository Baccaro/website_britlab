-- Paso 1 de 2: agrega la columna nueva SIN tocar "contenido" todavía. El paso
-- 2 (migracion_pdfs_a_disco_paso2.sql) recién se corre después de migrar los
-- archivos existentes a disco con database/migrar_pdfs_a_disco.py, que
-- necesita poder seguir leyendo "contenido" mientras hace ese trabajo.
BEGIN;

ALTER TABLE public.estudio_colega_modelo ADD COLUMN IF NOT EXISTS ruta_archivo varchar(500);

COMMIT;
