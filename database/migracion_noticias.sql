-- Tabla "noticia": contenido de "Noticias" (Web BritLab), administrado desde
-- el panel pero de lectura pública (lo consume la web sin login, ver
-- app/routes/noticias.py y el CORS para GET en app/__init__.py). La imagen
-- se guarda en disco bajo Config.FILES_DIR, igual que estudio_colega_modelo
-- y cv; "imagen_ruta" guarda el nombre de archivo, no la ruta absoluta.
BEGIN;

CREATE TABLE public.noticia (
    id serial4 NOT NULL,
    titulo varchar(255) NOT NULL,
    descripcion text NOT NULL,
    cuerpo text NOT NULL,
    categoria varchar(150) NOT NULL,
    fecha date NOT NULL,
    imagen_nombre_archivo varchar(255),
    imagen_ruta varchar(500),
    creado_por_id int4,
    actualizado_por_id int4,
    created_at timestamptz DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamptz DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT noticia_pkey PRIMARY KEY (id),
    CONSTRAINT noticia_creado_por_id_fkey FOREIGN KEY (creado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL,
    CONSTRAINT noticia_actualizado_por_id_fkey FOREIGN KEY (actualizado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL
);

COMMIT;
