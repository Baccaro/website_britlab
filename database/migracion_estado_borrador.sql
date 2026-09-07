-- Agrega 'borrador' como valor válido del enum de estado de un registro
-- Estudio x Colega (estado_registro_enum), para la nueva sección
-- "Paridad y Publicación" del formulario.
BEGIN;

ALTER TYPE public.estado_registro_enum ADD VALUE IF NOT EXISTS 'borrador';

COMMIT;
