-- Estudio x Colega: código AMS (reemplaza el placeholder "Tharsis", nunca
-- persistido), disponibilidad real para Web/IA (antes sólo visual) y
-- auditoría de creación/edición (mismo patrón que public.faq).
BEGIN;

ALTER TABLE public.estudio_colega
    ADD COLUMN codigo_ams varchar(100),
    ADD COLUMN habilitar_web boolean NOT NULL DEFAULT false,
    ADD COLUMN habilitar_ia boolean NOT NULL DEFAULT false,
    ADD COLUMN creado_por_id integer REFERENCES public.usuario(id) ON DELETE SET NULL,
    ADD COLUMN actualizado_por_id integer REFERENCES public.usuario(id) ON DELETE SET NULL;

COMMIT;
