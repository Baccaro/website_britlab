-- Login del sistema: tabla de usuarios con rol ('admin' full, 'user' de sólo
-- lectura) y permisos opt-out (permisos NULL/vacío = puede ver todo; el admin
-- lo va acotando por pantalla/columna desde el panel de usuarios), más la
-- tabla de tokens de un solo uso para "olvidé mi contraseña". Se seedean acá
-- mismo los 3 usuarios admin iniciales con la contraseña 'admin123' ya
-- hasheada (werkzeug generate_password_hash, scrypt) — hay que iniciar sesión
-- y cambiarla cuanto antes desde el panel.
BEGIN;

CREATE TABLE public.usuario (
    id serial PRIMARY KEY,
    username varchar(50) NOT NULL UNIQUE,
    nombre_completo varchar(150),
    email varchar(255) UNIQUE,
    password_hash varchar(255) NOT NULL,
    rol varchar(20) NOT NULL DEFAULT 'user',
    activo boolean NOT NULL DEFAULT true,
    permisos jsonb,
    created_at timestamp NOT NULL DEFAULT now(),
    CONSTRAINT chk_usuario_rol CHECK (rol IN ('admin', 'user'))
);

CREATE TABLE public.password_reset_token (
    id serial PRIMARY KEY,
    id_usuario integer NOT NULL REFERENCES public.usuario(id) ON DELETE CASCADE,
    token varchar(255) NOT NULL UNIQUE,
    expira timestamp NOT NULL,
    usado boolean NOT NULL DEFAULT false,
    created_at timestamp NOT NULL DEFAULT now()
);

CREATE INDEX idx_password_reset_token_usuario ON public.password_reset_token(id_usuario);

-- Usuarios admin iniciales. Password para los 3: admin123
INSERT INTO public.usuario (username, nombre_completo, rol, activo, password_hash) VALUES
    ('nbojanich', 'nbojanich', 'admin', true, 'scrypt:32768:8:1$U8dn7aspZMVGEXvT$bfe6e06e30e5c772b95f6bb0ff0b8011de6d236193fcb8432f00a72d13f9a23081e21fe353e70ad53965d4e1074a455b62ac459c003470b7c22c19589f04ef9c'),
    ('ccarletti', 'ccarletti', 'admin', true, 'scrypt:32768:8:1$hTlXxdD77lNvONAD$5a96c5333c760db74d941d8a8222ec0a3ba9cb90a357eeec9521b3453e12b9433c129f158a57f1a701ea71785bcced7e1b471889d2bebc0c75ab701e2005a288'),
    ('rbaccaro', 'rbaccaro', 'admin', true, 'scrypt:32768:8:1$xKmP2lSFVdj38lIm$245e98e6fb6d0fd60c79d2d62736dce3dde38a95feea071d9dc5b7ee6c48f5dead2f55ceca368cdff1068b7b8d884bd4587a5d84a4e329384ca918aeafdf5986');

COMMIT;
