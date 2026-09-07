-- Agrega el flag "es_propio" a colega: indica si el laboratorio es propio
-- del Sanatorio Británico (hoy sólo BRITLAB) o un colega externo tercerizado.
BEGIN;

ALTER TABLE public.colega
    ADD COLUMN es_propio boolean NOT NULL DEFAULT false;

UPDATE public.colega SET es_propio = true WHERE descripcion = 'BRITLAB';

COMMIT;
