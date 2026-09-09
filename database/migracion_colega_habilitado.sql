-- Colega: se agrega habilitado (true/false) para reemplazar el borrado (que
-- dejaría huérfanos los estudios de ese colega) por habilitar/deshabilitar, y
-- se agrega un unique constraint sobre descripcion para no permitir dos
-- colegas con el mismo nombre.
BEGIN;

ALTER TABLE public.colega
    ADD COLUMN habilitado boolean NOT NULL DEFAULT true;

ALTER TABLE public.colega
    ADD CONSTRAINT uq_colega_descripcion UNIQUE (descripcion);

COMMIT;
