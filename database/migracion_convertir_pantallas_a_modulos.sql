-- El esquema anterior (permisos.pantallas, opt-out por pantalla) queda
-- reemplazado por roles por módulo (permisos.modulos, opt-in). Sin esta
-- migración, un usuario 'user' real que ya tenía pantallas configuradas
-- (id=8 "test": estudios/tipos_muestra/colegas) perdería silenciosamente
-- todo acceso, porque el nuevo pantallaPermitida() ya no lee 'pantallas'.
--
-- Traducción: cualquier pantalla del viejo array que perteneciera al módulo
-- "estudios" (estudios, colegas, metodos, o cualquiera de los catálogos de
-- muestras) se traduce a modulos.estudios = 'consultor' — el rol 'user'
-- siempre fue de sólo lectura, así que 'consultor' (no 'administrador') es
-- la traducción fiel. Mismo criterio para obras_sociales/web/faq si algún
-- registro llegara a tenerlas (hoy ninguno las tiene). columnas_ocultas_estudios
-- y ver_credenciales_colegas se preservan tal cual: siguen existiendo en el
-- nuevo esquema.
BEGIN;

UPDATE public.usuario
SET permisos = (COALESCE(permisos, '{}'::jsonb) - 'pantallas') || jsonb_build_object(
    'modulos',
    (
        SELECT COALESCE(jsonb_object_agg(modulo, 'consultor'), '{}'::jsonb)
        FROM (
            SELECT DISTINCT CASE
                WHEN p.val IN ('estudios', 'colegas', 'metodos', 'tipos_muestra', 'aditivos',
                               'unidades_medida', 'recipientes', 'modalidades_recoleccion',
                               'tecnicas_recoleccion', 'conservaciones', 'condiciones_especiales',
                               'prioridades_envio') THEN 'estudios'
                WHEN p.val = 'obras_sociales' THEN 'obras_sociales'
                WHEN p.val = 'web_britlab' THEN 'web'
                WHEN p.val = 'faq' THEN 'faq'
            END AS modulo
            FROM jsonb_array_elements_text(permisos -> 'pantallas') AS p(val)
        ) modulos_detectados
        WHERE modulo IS NOT NULL
    )
)
WHERE rol = 'user' AND permisos ? 'pantallas';

-- ccarletti es superadmin: 'pantallas' ya no significa nada para ese rol
-- (acceso íntegro siempre), simplemente se limpia el resabio.
UPDATE public.usuario
SET permisos = COALESCE(permisos, '{}'::jsonb) - 'pantallas'
WHERE rol = 'superadmin' AND permisos ? 'pantallas';

-- Si a alguien le queda permisos = '{}' (nada más que el modulos vacío y sin
-- otras claves), mejor null: es equivalente y más limpio.
UPDATE public.usuario SET permisos = NULL WHERE permisos = '{}'::jsonb;
UPDATE public.usuario SET permisos = NULL WHERE permisos = '{"modulos": {}}'::jsonb;

COMMIT;
