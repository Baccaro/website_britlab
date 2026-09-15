-- Nuevo esquema de roles y permisos por módulo (Consultor / Administrador /
-- SuperAdmin), reemplazando el "admin"/"user" global anterior:
--   - SuperAdmin: acceso total, incluida la administración de usuarios.
--     Los 3 usuarios seed (permisos "full" del pedido original) pasan de
--     rol='admin' a rol='superadmin'.
--   - 'user' sigue siendo el rol de base en la tabla; su nivel real de acceso
--     ahora se define POR MÓDULO en permisos.modulos (ver app/auth.py), no en
--     esta columna: {"modulos": {"estudios": "consultor"|"administrador", ...}}.
--     Un módulo ausente de permisos.modulos = sin acceso a ese módulo (antes
--     era al revés: sin restricciones = veía todo).
BEGIN;

ALTER TABLE public.usuario DROP CONSTRAINT chk_usuario_rol;
UPDATE public.usuario SET rol = 'superadmin' WHERE rol = 'admin';
ALTER TABLE public.usuario ADD CONSTRAINT chk_usuario_rol CHECK (rol IN ('superadmin', 'user'));

COMMIT;
