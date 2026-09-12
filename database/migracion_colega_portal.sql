-- Alta de colega: datos de portal externo (link + credenciales) y observaciones.
-- portal_usuario/portal_password son sensibles: sólo los ve un admin, o un
-- usuario 'user' al que un admin se lo habilite explícitamente por
-- permisos.ver_credenciales_colegas (ver app/crud.py _redact_sensitive y
-- app/routes/colegas.py). A diferencia de "pantallas"/"columnas_ocultas_estudios"
-- (que son opt-out: por defecto se ve todo), este permiso es opt-in: por
-- defecto NADIE que no sea admin ve estas credenciales, aunque tenga
-- permisos=null. No se guardan hasheadas ni cifradas: son credenciales de un
-- portal externo que el admin necesita poder leer tal cual, no una
-- contraseña de acceso a este sistema.
BEGIN;

ALTER TABLE public.colega
    ADD COLUMN portal_url text,
    ADD COLUMN portal_usuario varchar(150),
    ADD COLUMN portal_password varchar(255),
    ADD COLUMN observaciones text;

COMMIT;
