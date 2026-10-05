-- Tabla "cv": postulaciones recibidas desde "Trabajá con Nosotros" en la web
-- pública (alta sin login, ver app/routes/cv.py). El PDF se guarda en disco
-- bajo Config.FILES_DIR, igual que estudio_colega_modelo; "ruta_archivo" es
-- el nombre de archivo relativo a esa carpeta, no la ruta absoluta.
BEGIN;

CREATE TABLE public.cv (
    id serial4 NOT NULL,
    nombre_completo varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    nombre_archivo varchar(255) NOT NULL,
    ruta_archivo varchar(500) NOT NULL,
    tamanio_bytes int4 NOT NULL,
    created_at timestamptz DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT cv_pkey PRIMARY KEY (id)
);

COMMIT;
