-- Redefine los estados posibles de Estudio x Colega (estudio_colega.estado,
-- enum estado_registro_enum).
--
-- Antes: listo / pendiente / revisar / verificado / borrador
-- Ahora:  activo / inactivo / discontinuado / pendiente / borrador
--
-- Mapeo de datos existentes (no hay equivalente 1 a 1 para 'revisar' ni
-- 'verificado' en el nuevo esquema de 5 estados, pedido explícitamente por
-- el usuario):
--   listo      -> activo       (se renombra el label del enum)
--   verificado -> activo       (se funde con 'listo' antes de renombrar)
--   pendiente  -> pendiente    (sin cambios)
--   revisar    -> pendiente    (se funde: "incompleto" es lo más parecido)
--   borrador   -> borrador     (sin cambios; pasa a ser el DEFAULT)
--
-- 'inactivo' y 'discontinuado' son estados nuevos sin datos previos.
--
-- Nota: Postgres no permite borrar valores de un enum (DROP VALUE no
-- existe), así que 'verificado' y 'revisar' quedan como labels huérfanos
-- del tipo (sin ninguna fila usándolos, e inalcanzables desde la UI, que
-- sólo ofrece los 5 valores nuevos).

-- 1) Agregar los valores nuevos. Deben ir sueltos (fuera de un BEGIN/COMMIT
--    explícito): ALTER TYPE ... ADD VALUE no puede usarse en la misma
--    transacción en la que luego se consume el valor agregado.
ALTER TYPE public.estado_registro_enum ADD VALUE IF NOT EXISTS 'inactivo';
ALTER TYPE public.estado_registro_enum ADD VALUE IF NOT EXISTS 'discontinuado';

-- 2) Fusionar los estados sin equivalente directo, antes de renombrar 'listo'.
BEGIN;
UPDATE public.estudio_colega SET estado = 'listo' WHERE estado = 'verificado';
UPDATE public.estudio_colega SET estado = 'pendiente' WHERE estado = 'revisar';
COMMIT;

-- 3) Renombrar el label 'listo' a 'activo': todas las filas que ya estaban
--    en 'listo' (incluidas las recién fusionadas desde 'verificado') pasan
--    a 'activo' automáticamente, sin necesidad de un UPDATE adicional.
ALTER TYPE public.estado_registro_enum RENAME VALUE 'listo' TO 'activo';

-- 4) Nuevo valor por defecto: 'borrador' es el estado inicial al crear un
--    estudio (antes era 'pendiente').
ALTER TABLE public.estudio_colega ALTER COLUMN estado SET DEFAULT 'borrador';
