-- Módulo FAQ (Preguntas Frecuentes), según especificación funcional:
-- categoria es texto libre autocompletable (RN-FAQ-02: sin ABM separado),
-- disponible_web/disponible_ia son independientes (RN-FAQ-03), estado es
-- borrador/activo/inactivo (RN-FAQ-04), y se audita creación/edición con
-- usuario y fecha (RN-FAQ-10).
BEGIN;

CREATE TABLE public.faq (
    id serial PRIMARY KEY,
    pregunta text NOT NULL,
    respuesta text NOT NULL,
    categoria varchar(150) NOT NULL,
    disponible_web boolean NOT NULL DEFAULT false,
    disponible_ia boolean NOT NULL DEFAULT false,
    estado varchar(20) NOT NULL DEFAULT 'borrador',
    creado_por_id integer REFERENCES public.usuario(id) ON DELETE SET NULL,
    actualizado_por_id integer REFERENCES public.usuario(id) ON DELETE SET NULL,
    created_at timestamp NOT NULL DEFAULT now(),
    updated_at timestamp NOT NULL DEFAULT now(),
    CONSTRAINT chk_faq_estado CHECK (estado IN ('borrador', 'activo', 'inactivo'))
);

CREATE INDEX idx_faq_categoria ON public.faq (categoria);

COMMIT;
