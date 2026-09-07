-- Modelos de informe (PDF) del colega para un Estudio x Colega: 1..N por
-- registro, guardados como bytea en la BD (sin depender de un volumen de
-- archivos aparte, consistente con el resto del esquema).
BEGIN;

CREATE TABLE public.estudio_colega_modelo (
    id serial4 NOT NULL,
    id_estudio_colega int4 NOT NULL,
    nombre_archivo varchar(255) NOT NULL,
    contenido bytea NOT NULL,
    tamanio_bytes int4 NOT NULL,
    created_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
    CONSTRAINT estudio_colega_modelo_pkey PRIMARY KEY (id),
    CONSTRAINT ecm_id_estudio_colega_fkey FOREIGN KEY (id_estudio_colega)
        REFERENCES public.estudio_colega(id) ON DELETE CASCADE
);

CREATE INDEX idx_ecm_id_estudio_colega ON public.estudio_colega_modelo (id_estudio_colega);

COMMIT;
