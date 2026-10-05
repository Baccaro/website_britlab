-- public.colega definition

-- Drop table

-- DROP TABLE public.colega;

CREATE TABLE public.colega (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	descripcion varchar(255) NOT NULL,
	es_propio bool NOT NULL DEFAULT false,
	habilitado bool NOT NULL DEFAULT true,
	portal_url text NULL,
	-- portal_usuario/portal_password: credenciales del portal externo del
	-- colega. Sensibles: la API las redacta salvo admin o un 'user' con
	-- permisos.ver_credenciales_colegas habilitado explícitamente (opt-in,
	-- al revés que el resto de los permisos). Van en texto plano a propósito:
	-- son credenciales de un sistema externo que el admin necesita leer tal
	-- cual, no una contraseña de acceso a esta aplicación.
	portal_usuario varchar(150) NULL,
	portal_password varchar(255) NULL,
	observaciones text NULL,
	CONSTRAINT colega_pkey PRIMARY KEY (id),
	CONSTRAINT uq_colega_descripcion UNIQUE (descripcion)
);


-- public.estudio definition

-- Drop table

-- DROP TABLE public.estudio;

CREATE TABLE public.estudio (
	id serial4 NOT NULL,
	codigo_hexalis varchar(50) NOT NULL,
	descripcion text NOT NULL,
	CONSTRAINT estudio_codigo_hexalis_key UNIQUE (codigo_hexalis),
	CONSTRAINT estudio_pkey PRIMARY KEY (id)
);


-- public.metodo definition

-- Drop table

-- DROP TABLE public.metodo;

CREATE TABLE public.metodo (
	id serial4 NOT NULL,
	nombre varchar(100) NOT NULL,
	descripcion text NULL,
	CONSTRAINT metodo_nombre_key UNIQUE (nombre),
	CONSTRAINT metodo_pkey PRIMARY KEY (id)
);


-- public.muestra definition

-- Drop table

-- DROP TABLE public.muestra;

CREATE TABLE public.muestra (
	id serial4 NOT NULL,
	nombre varchar(150) NOT NULL,
	observacion text NULL,
	CONSTRAINT muestra_nombre_key UNIQUE (nombre),
	CONSTRAINT muestra_pkey PRIMARY KEY (id)
);


-- public.sector definition

-- Drop table

-- DROP TABLE public.sector;

CREATE TABLE public.sector (
	id serial4 NOT NULL,
	nombre varchar(150) NOT NULL,
	CONSTRAINT sector_pkey PRIMARY KEY (id),
	CONSTRAINT sector_nombre_key UNIQUE (nombre)
);


-- public.valor_estudio_sector definition

-- Drop table

-- DROP TABLE public.valor_estudio_sector;

CREATE TABLE public.valor_estudio_sector (
	id serial4 NOT NULL,
	id_estudio int4 NOT NULL,
	id_sector int4 NOT NULL,
	posicion_informe int4 NOT NULL,
	rango varchar(100) NULL,
	CONSTRAINT valor_estudio_sector_pkey PRIMARY KEY (id),
	CONSTRAINT uq_estudio_sector_posicion UNIQUE (id_estudio, id_sector, posicion_informe),
	CONSTRAINT valor_estudio_sector_id_estudio_fkey FOREIGN KEY (id_estudio) REFERENCES public.estudio(id) ON DELETE CASCADE,
	CONSTRAINT valor_estudio_sector_id_sector_fkey FOREIGN KEY (id_sector) REFERENCES public.sector(id)
);


-- public.estudio_colega definition

-- Drop table

-- DROP TABLE public.estudio_colega;

CREATE TABLE public.estudio_colega (
	id serial4 NOT NULL,
	nemonico_datatech varchar(50) NOT NULL,
	-- Paridad Sí/No (antes un enum de 5 valores: se convirtió a texto libre
	-- para el nuevo desplegable "Paridad" de Paridad y Publicación).
	paridad_datatech_hexalis varchar(20) DEFAULT 'No'::varchar NOT NULL,
	id_estudio int4 NOT NULL,
	id_metodo int4 NULL,
	id_muestra int4 NULL,
	id_sector_laboratorio int4 NULL,
	-- indicaciones_pacientes: texto del dropdown "Indicaciones Pacientes"
	-- (ya no admite subida de PDF nuevos, sólo descripción). indicaciones_colega:
	-- texto del dropdown "Indicaciones al Profesional/Derivante".
	-- preanalitico_descripcion: texto propio del dropdown "Preanalítico" (ya no
	-- hay catálogo id_preanalitico: se eliminó junto con la tabla preanalitico
	-- y con valor_referencia). modelo_derivante_observaciones: texto propio del
	-- dropdown "Modelo Derivante".
	indicaciones_pacientes text NULL,
	indicaciones_colega text NULL,
	preanalitico_descripcion text NULL,
	modelo_derivante_observaciones text NULL,
	dias_demora int4 DEFAULT 0 NULL,
	estado public.estado_registro_enum DEFAULT 'pendiente'::estado_registro_enum NOT NULL,
	codigo_laboratorio varchar(50) DEFAULT NULL::character varying NULL,
	-- codigo_ams: reemplaza al placeholder "Tharsis" (nunca persistido).
	-- habilitar_web/habilitar_ia: antes sólo placeholders visuales, ahora
	-- persistidos de verdad (columna "Disponibilidad" del listado).
	codigo_ams varchar(100) NULL,
	habilitar_web bool DEFAULT false NOT NULL,
	habilitar_ia bool DEFAULT false NOT NULL,
	"version" int4 DEFAULT 1 NOT NULL,
	revisor varchar(100) NOT NULL,
	observacion text NULL,
	-- Auditoría de creación/edición (mismo patrón que public.faq).
	creado_por_id int4 NULL,
	actualizado_por_id int4 NULL,
	created_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
	colega_id int4 NOT NULL,
	CONSTRAINT estudio_colega_pkey PRIMARY KEY (id),
	CONSTRAINT estudio_colega_id_estudio_fkey FOREIGN KEY (id_estudio) REFERENCES public.estudio(id) ON DELETE RESTRICT,
	CONSTRAINT estudio_colega_id_metodo_fkey FOREIGN KEY (id_metodo) REFERENCES public.metodo(id) ON DELETE SET NULL,
	CONSTRAINT estudio_colega_id_muestra_fkey FOREIGN KEY (id_muestra) REFERENCES public.muestra(id) ON DELETE SET NULL,
	CONSTRAINT estudio_colega_id_sector_laboratorio_fkey FOREIGN KEY (id_sector_laboratorio) REFERENCES public.valor_estudio_sector(id) ON DELETE SET NULL,
	CONSTRAINT estudio_colega_creado_por_id_fkey FOREIGN KEY (creado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL,
	CONSTRAINT estudio_colega_actualizado_por_id_fkey FOREIGN KEY (actualizado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL,
	CONSTRAINT fk_estudio_colega_colega FOREIGN KEY (colega_id) REFERENCES public.colega(id) ON DELETE RESTRICT ON UPDATE CASCADE
);


-- Muestras estructuradas (1..N por estudio_colega). Es aditivo: no
-- reemplaza a 'muestra' / 'estudio_colega.id_muestra', que se mantienen.

CREATE TABLE public.tipo_muestra (
	id serial4 NOT NULL,
	nombre varchar(150) NOT NULL,
	CONSTRAINT tipo_muestra_pkey PRIMARY KEY (id),
	CONSTRAINT tipo_muestra_nombre_key UNIQUE (nombre)
);

CREATE TABLE public.aditivo (
	id serial4 NOT NULL,
	nombre varchar(100) NOT NULL,
	CONSTRAINT aditivo_pkey PRIMARY KEY (id),
	CONSTRAINT aditivo_nombre_key UNIQUE (nombre)
);

CREATE TABLE public.unidad_medida (
	id serial4 NOT NULL,
	nombre varchar(50) NOT NULL,
	CONSTRAINT unidad_medida_pkey PRIMARY KEY (id),
	CONSTRAINT unidad_medida_nombre_key UNIQUE (nombre)
);

CREATE TABLE public.recipiente (
	id serial4 NOT NULL,
	nombre varchar(100) NOT NULL,
	CONSTRAINT recipiente_pkey PRIMARY KEY (id),
	CONSTRAINT recipiente_nombre_key UNIQUE (nombre)
);

CREATE TABLE public.modalidad_recoleccion (
	id serial4 NOT NULL,
	nombre varchar(150) NOT NULL,
	CONSTRAINT modalidad_recoleccion_pkey PRIMARY KEY (id),
	CONSTRAINT modalidad_recoleccion_nombre_key UNIQUE (nombre)
);

CREATE TABLE public.tecnica_recoleccion (
	id serial4 NOT NULL,
	nombre varchar(150) NOT NULL,
	CONSTRAINT tecnica_recoleccion_pkey PRIMARY KEY (id),
	CONSTRAINT tecnica_recoleccion_nombre_key UNIQUE (nombre)
);

CREATE TABLE public.conservacion (
	id serial4 NOT NULL,
	nombre varchar(100) NOT NULL,
	CONSTRAINT conservacion_pkey PRIMARY KEY (id),
	CONSTRAINT conservacion_nombre_key UNIQUE (nombre)
);

CREATE TABLE public.condicion_especial (
	id serial4 NOT NULL,
	nombre varchar(100) NOT NULL,
	CONSTRAINT condicion_especial_pkey PRIMARY KEY (id),
	CONSTRAINT condicion_especial_nombre_key UNIQUE (nombre)
);

CREATE TABLE public.prioridad_envio (
	id serial4 NOT NULL,
	nombre varchar(100) NOT NULL,
	CONSTRAINT prioridad_envio_pkey PRIMARY KEY (id),
	CONSTRAINT prioridad_envio_nombre_key UNIQUE (nombre)
);

CREATE TABLE public.estudio_colega_muestra (
	id serial4 NOT NULL,
	id_estudio_colega int4 NOT NULL,
	id_tipo_muestra int4 NOT NULL,
	id_aditivo int4 NULL,
	volumen numeric(10,2) NULL,
	id_unidad_medida int4 NULL,
	id_recipiente int4 NULL,
	id_modalidad_recoleccion int4 NULL,
	id_tecnica_recoleccion int4 NULL,
	id_conservacion int4 NULL,
	id_condicion_especial int4 NULL,
	id_prioridad_envio int4 NULL,
	orden int4 DEFAULT 1 NOT NULL,
	observacion text NULL,
	created_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT estudio_colega_muestra_pkey PRIMARY KEY (id),
	CONSTRAINT edm_id_estudio_colega_fkey FOREIGN KEY (id_estudio_colega) REFERENCES public.estudio_colega(id) ON DELETE CASCADE,
	CONSTRAINT edm_id_tipo_muestra_fkey FOREIGN KEY (id_tipo_muestra) REFERENCES public.tipo_muestra(id),
	CONSTRAINT edm_id_aditivo_fkey FOREIGN KEY (id_aditivo) REFERENCES public.aditivo(id) ON DELETE SET NULL,
	CONSTRAINT edm_id_unidad_medida_fkey FOREIGN KEY (id_unidad_medida) REFERENCES public.unidad_medida(id) ON DELETE SET NULL,
	CONSTRAINT edm_id_recipiente_fkey FOREIGN KEY (id_recipiente) REFERENCES public.recipiente(id) ON DELETE SET NULL,
	CONSTRAINT edm_id_modalidad_recoleccion_fkey FOREIGN KEY (id_modalidad_recoleccion) REFERENCES public.modalidad_recoleccion(id) ON DELETE SET NULL,
	CONSTRAINT edm_id_tecnica_recoleccion_fkey FOREIGN KEY (id_tecnica_recoleccion) REFERENCES public.tecnica_recoleccion(id) ON DELETE SET NULL,
	CONSTRAINT edm_id_conservacion_fkey FOREIGN KEY (id_conservacion) REFERENCES public.conservacion(id) ON DELETE SET NULL,
	CONSTRAINT edm_id_condicion_especial_fkey FOREIGN KEY (id_condicion_especial) REFERENCES public.condicion_especial(id) ON DELETE SET NULL,
	CONSTRAINT edm_id_prioridad_envio_fkey FOREIGN KEY (id_prioridad_envio) REFERENCES public.prioridad_envio(id) ON DELETE SET NULL
);

-- Alternativas de una muestra puntual (no del estudio_colega directamente):
-- un estudio tiene N muestras, y cada muestra puede tener N alternativas.

CREATE TABLE public.estudio_colega_muestra_alternativa (
	id serial4 NOT NULL,
	id_estudio_colega_muestra int4 NOT NULL,
	id_tipo_muestra int4 NOT NULL,
	id_aditivo int4 NULL,
	volumen numeric(10,2) NULL,
	id_unidad_medida int4 NULL,
	id_recipiente int4 NULL,
	id_modalidad_recoleccion int4 NULL,
	id_tecnica_recoleccion int4 NULL,
	id_conservacion int4 NULL,
	id_condicion_especial int4 NULL,
	id_prioridad_envio int4 NULL,
	orden int4 DEFAULT 1 NOT NULL,
	observacion text NULL,
	created_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT estudio_colega_muestra_alternativa_pkey PRIMARY KEY (id),
	CONSTRAINT ecma_id_estudio_colega_muestra_fkey FOREIGN KEY (id_estudio_colega_muestra) REFERENCES public.estudio_colega_muestra(id) ON DELETE CASCADE,
	CONSTRAINT ecma_id_tipo_muestra_fkey FOREIGN KEY (id_tipo_muestra) REFERENCES public.tipo_muestra(id),
	CONSTRAINT ecma_id_aditivo_fkey FOREIGN KEY (id_aditivo) REFERENCES public.aditivo(id) ON DELETE SET NULL,
	CONSTRAINT ecma_id_unidad_medida_fkey FOREIGN KEY (id_unidad_medida) REFERENCES public.unidad_medida(id) ON DELETE SET NULL,
	CONSTRAINT ecma_id_recipiente_fkey FOREIGN KEY (id_recipiente) REFERENCES public.recipiente(id) ON DELETE SET NULL,
	CONSTRAINT ecma_id_modalidad_recoleccion_fkey FOREIGN KEY (id_modalidad_recoleccion) REFERENCES public.modalidad_recoleccion(id) ON DELETE SET NULL,
	CONSTRAINT ecma_id_tecnica_recoleccion_fkey FOREIGN KEY (id_tecnica_recoleccion) REFERENCES public.tecnica_recoleccion(id) ON DELETE SET NULL,
	CONSTRAINT ecma_id_conservacion_fkey FOREIGN KEY (id_conservacion) REFERENCES public.conservacion(id) ON DELETE SET NULL,
	CONSTRAINT ecma_id_condicion_especial_fkey FOREIGN KEY (id_condicion_especial) REFERENCES public.condicion_especial(id) ON DELETE SET NULL,
	CONSTRAINT ecma_id_prioridad_envio_fkey FOREIGN KEY (id_prioridad_envio) REFERENCES public.prioridad_envio(id) ON DELETE SET NULL
);


-- public.estudio_colega_modelo definition
-- Modelos de informe (PDF) del colega para un Estudio x Colega: 1..N por
-- registro, guardados como bytea en la BD.

CREATE TABLE public.estudio_colega_modelo (
	id serial4 NOT NULL,
	id_estudio_colega int4 NOT NULL,
	nombre_archivo varchar(255) NOT NULL,
	-- El PDF ya NO se guarda acá (era "contenido bytea"): vive en disco, bajo
	-- Config.FILES_DIR (ver app/config.py) directamente, sin subcarpeta. Esta
	-- columna guarda el nombre de archivo: CODIGOHEXALIS_LABORATORIO_pre|md_N.pdf
	-- (N correlativo por Estudio+Laboratorio+categoría, ver
	-- app/routes/estudio_colega_modelo.py: _nombre_archivo_disco). Qué carpeta
	-- del host es FILES_DIR en cada entorno lo decide el "volumes:" del
	-- docker-compose correspondiente (migracion_pdfs_a_disco_paso1/2.sql).
	ruta_archivo varchar(500) NOT NULL,
	tamanio_bytes int4 NOT NULL,
	-- categoria: a qué dropdown pertenece este PDF ('preanalitico', 'paciente'
	-- o 'colega'/Modelo Derivante). descripcion: comentario propio del archivo
	-- (sólo se edita desde "Modelo Derivante", pero cualquier categoría lo acepta).
	categoria varchar(20) DEFAULT 'colega'::character varying NOT NULL,
	descripcion text NULL,
	created_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT estudio_colega_modelo_pkey PRIMARY KEY (id),
	CONSTRAINT chk_ecm_categoria CHECK (categoria IN ('preanalitico', 'paciente', 'colega')),
	CONSTRAINT ecm_id_estudio_colega_fkey FOREIGN KEY (id_estudio_colega) REFERENCES public.estudio_colega(id) ON DELETE CASCADE
);
CREATE INDEX idx_ecm_id_estudio_colega ON public.estudio_colega_modelo (id_estudio_colega);

-- public.cv definition
-- Postulaciones recibidas desde "Trabajá con Nosotros" en la web pública:
-- alta SIN login (único endpoint público de toda la API, ver app/routes/cv.py
-- y el CORS acotado a esa ruta en app/__init__.py). El PDF se guarda en disco
-- bajo Config.FILES_DIR, igual que estudio_colega_modelo.
CREATE TABLE public.cv (
	id serial4 NOT NULL,
	nombre_completo varchar(255) NOT NULL,
	email varchar(255) NOT NULL,
	nombre_archivo varchar(255) NOT NULL,
	ruta_archivo varchar(500) NOT NULL,
	tamanio_bytes int4 NOT NULL,
	created_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT cv_pkey PRIMARY KEY (id)
);

-- public.usuario definition
-- Cuentas de acceso al sistema. rol 'superadmin' = administración íntegra
-- (todos los módulos + administración de usuarios/roles/permisos); rol
-- 'user' = su nivel real de acceso se define POR MÓDULO en
-- permisos.modulos ({"estudios": "consultor"|"administrador", ...}) — un
-- módulo ausente de ahí es SIN acceso (opt-in, a diferencia de
-- columnas_ocultas_estudios/ver_credenciales_colegas, que siguen siendo
-- restricciones opt-out/opt-in puntuales dentro del módulo Estudios).

CREATE TABLE public.usuario (
	id serial4 NOT NULL,
	username varchar(50) NOT NULL,
	nombre_completo varchar(150) NULL,
	email varchar(255) NULL,
	password_hash varchar(255) NOT NULL,
	rol varchar(20) DEFAULT 'user' NOT NULL,
	activo bool DEFAULT true NOT NULL,
	permisos jsonb NULL,
	created_at timestamp DEFAULT now() NOT NULL,
	CONSTRAINT usuario_pkey PRIMARY KEY (id),
	CONSTRAINT usuario_username_key UNIQUE (username),
	CONSTRAINT usuario_email_key UNIQUE (email),
	CONSTRAINT chk_usuario_rol CHECK (rol IN ('superadmin', 'user'))
);

-- Seed inicial: nbojanich, ccarletti, rbaccaro (rol superadmin, contraseña
-- admin123 hasheada con werkzeug generate_password_hash/scrypt) — ver
-- migracion_usuarios.sql para los INSERT con los hashes (rol seedeado
-- originalmente como 'admin'; migracion_roles_modulos.sql lo renombra a
-- 'superadmin').


-- public.password_reset_token definition
-- Token de un solo uso para "olvidé mi contraseña". Sin servicio de email
-- configurado todavía, el link con este token se muestra en pantalla en vez
-- de enviarse (ver app/routes/auth.py).

CREATE TABLE public.password_reset_token (
	id serial4 NOT NULL,
	id_usuario int4 NOT NULL,
	token varchar(255) NOT NULL,
	expira timestamp NOT NULL,
	usado bool DEFAULT false NOT NULL,
	created_at timestamp DEFAULT now() NOT NULL,
	CONSTRAINT password_reset_token_pkey PRIMARY KEY (id),
	CONSTRAINT password_reset_token_token_key UNIQUE (token),
	CONSTRAINT prt_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id) ON DELETE CASCADE
);
CREATE INDEX idx_password_reset_token_usuario ON public.password_reset_token (id_usuario);


-- public.faq definition
-- Módulo FAQ (Preguntas Frecuentes). categoria es texto libre autocompletable,
-- sin ABM separado (RN-FAQ-02). estado gobierna visibilidad pública
-- (borrador/inactivo no son públicas, RN-FAQ-05/06); disponible_web/
-- disponible_ia son independientes entre sí (RN-FAQ-03). Se audita creación
-- y última edición con usuario y fecha (RN-FAQ-10).

CREATE TABLE public.faq (
	id serial4 NOT NULL,
	pregunta text NOT NULL,
	respuesta text NOT NULL,
	categoria varchar(150) NOT NULL,
	disponible_web bool DEFAULT false NOT NULL,
	disponible_ia bool DEFAULT false NOT NULL,
	estado varchar(20) DEFAULT 'borrador' NOT NULL,
	creado_por_id int4 NULL,
	actualizado_por_id int4 NULL,
	created_at timestamp DEFAULT now() NOT NULL,
	updated_at timestamp DEFAULT now() NOT NULL,
	CONSTRAINT faq_pkey PRIMARY KEY (id),
	CONSTRAINT chk_faq_estado CHECK (estado IN ('borrador', 'activo', 'inactivo')),
	CONSTRAINT faq_creado_por_id_fkey FOREIGN KEY (creado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL,
	CONSTRAINT faq_actualizado_por_id_fkey FOREIGN KEY (actualizado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL
);
CREATE INDEX idx_faq_categoria ON public.faq (categoria);


-- public.tarifario / tarifario_item / tarifario_item_periodo definition
-- Módulo Tarifarios (dropdown "Obras Sociales" del navbar, RBAC del módulo
-- 'obras_sociales'). Un tarifario/convenio tiene N ítems (un Estudio con
-- precio); cada ítem tiene N períodos: actualizar un precio agrega un
-- período nuevo (uq_tarifario_item_periodo obliga a que sea distinto), nunca
-- pisa el anterior. El precio "vigente" de un ítem es el de su período con
-- created_at más reciente. La auditoría de cada período (usuario/fecha de
-- creación y edición) sólo la ve SuperAdmin (ver app/routes/tarifarios.py).

CREATE TABLE public.tarifario (
	id serial4 NOT NULL,
	nombre varchar(255) NOT NULL,
	tipo varchar(20) DEFAULT 'TARIFARIO' NOT NULL,
	tipo_relacionado varchar(50) DEFAULT 'Laboratorio / Procesador externo' NOT NULL,
	entidad varchar(255) NULL,
	moneda varchar(10) DEFAULT 'ARS' NOT NULL,
	estado varchar(20) DEFAULT 'activo' NOT NULL,
	observaciones text NULL,
	creado_por_id int4 NULL,
	actualizado_por_id int4 NULL,
	created_at timestamp DEFAULT now() NOT NULL,
	updated_at timestamp DEFAULT now() NOT NULL,
	CONSTRAINT tarifario_pkey PRIMARY KEY (id),
	CONSTRAINT chk_tarifario_tipo CHECK (tipo IN ('TARIFARIO', 'CONVENIO', 'DERIVACION', 'LISTA', 'ANEXO')),
	CONSTRAINT chk_tarifario_estado CHECK (estado IN ('activo', 'inactivo')),
	CONSTRAINT tarifario_creado_por_id_fkey FOREIGN KEY (creado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL,
	CONSTRAINT tarifario_actualizado_por_id_fkey FOREIGN KEY (actualizado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL
);

CREATE TABLE public.tarifario_item (
	id serial4 NOT NULL,
	id_tarifario int4 NOT NULL,
	id_estudio int4 NOT NULL,
	nemonico varchar(50) NULL,
	codigo varchar(50) NULL,
	estado varchar(20) DEFAULT 'Activo' NOT NULL,
	nota text NULL,
	created_at timestamp DEFAULT now() NOT NULL,
	CONSTRAINT tarifario_item_pkey PRIMARY KEY (id),
	CONSTRAINT chk_tarifario_item_estado CHECK (estado IN ('Activo', 'Inactivo')),
	CONSTRAINT tarifario_item_id_tarifario_fkey FOREIGN KEY (id_tarifario) REFERENCES public.tarifario(id) ON DELETE CASCADE,
	CONSTRAINT tarifario_item_id_estudio_fkey FOREIGN KEY (id_estudio) REFERENCES public.estudio(id) ON DELETE RESTRICT
);
CREATE INDEX idx_tarifario_item_tarifario ON public.tarifario_item (id_tarifario);

CREATE TABLE public.tarifario_item_periodo (
	id serial4 NOT NULL,
	id_tarifario_item int4 NOT NULL,
	periodo varchar(100) NOT NULL,
	precio numeric(14, 2) NOT NULL,
	creado_por_id int4 NULL,
	actualizado_por_id int4 NULL,
	created_at timestamp DEFAULT now() NOT NULL,
	updated_at timestamp DEFAULT now() NOT NULL,
	CONSTRAINT tarifario_item_periodo_pkey PRIMARY KEY (id),
	CONSTRAINT uq_tarifario_item_periodo UNIQUE (id_tarifario_item, periodo),
	CONSTRAINT tarifario_item_periodo_id_tarifario_item_fkey FOREIGN KEY (id_tarifario_item) REFERENCES public.tarifario_item(id) ON DELETE CASCADE,
	CONSTRAINT tarifario_item_periodo_creado_por_id_fkey FOREIGN KEY (creado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL,
	CONSTRAINT tarifario_item_periodo_actualizado_por_id_fkey FOREIGN KEY (actualizado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL
);
CREATE INDEX idx_tarifario_item_periodo_item ON public.tarifario_item_periodo (id_tarifario_item, created_at);

-- public.noticia definition
-- Contenido de "Noticias" (Web BritLab, módulo 'web'): alta/edición sólo
-- desde el panel, pero de LECTURA PÚBLICA (la consume la web sin login, ver
-- app/routes/noticias.py y el CORS para GET en app/__init__.py). La imagen
-- se guarda en disco bajo Config.FILES_DIR, igual que estudio_colega_modelo
-- y cv. "categoria" es texto libre autocompletable, mismo criterio que
-- Faq.categoria (sin ABM separado).
CREATE TABLE public.noticia (
	id serial4 NOT NULL,
	titulo varchar(255) NOT NULL,
	descripcion text NOT NULL,
	cuerpo text NOT NULL,
	categoria varchar(150) NOT NULL,
	fecha date NOT NULL,
	imagen_nombre_archivo varchar(255) NULL,
	imagen_ruta varchar(500) NULL,
	creado_por_id int4 NULL,
	actualizado_por_id int4 NULL,
	created_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT noticia_pkey PRIMARY KEY (id),
	CONSTRAINT noticia_creado_por_id_fkey FOREIGN KEY (creado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL,
	CONSTRAINT noticia_actualizado_por_id_fkey FOREIGN KEY (actualizado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL
);


-- public.nomenclador / autorizador / obra_social* definition
-- Módulo Obras Sociales (dropdown "Obras Sociales" del navbar, RBAC del
-- módulo 'obras_sociales'). Nomenclador y Autorizador son ABMs propios y
-- reutilizables entre Obras Sociales (no se borran, sólo se inactivan).
-- Obra Social tiene N Planes, N Contactos, un historial de cambios de
-- estado (propio o de un Plan puntual) y relaciones M2M con Nomenclador y
-- Autorizador — ésta última con credenciales propias de la relación
-- (usuario/password), redactadas salvo SuperAdmin o el permiso puntual
-- ver_credenciales_autorizadores (ver app/routes/obras_sociales.py).
-- Reglas/excepciones por práctica quedan para una etapa posterior.

CREATE TABLE public.nomenclador (
	id serial4 NOT NULL,
	nombre varchar(255) NOT NULL,
	tipo varchar(30) DEFAULT 'NBU' NOT NULL,
	version_o_fecha varchar(100) NULL,
	vigencia varchar(100) NULL,
	link text NULL,
	observacion text NULL,
	estado varchar(20) DEFAULT 'activo' NOT NULL,
	creado_por_id int4 NULL,
	actualizado_por_id int4 NULL,
	created_at timestamp DEFAULT now() NOT NULL,
	updated_at timestamp DEFAULT now() NOT NULL,
	CONSTRAINT nomenclador_pkey PRIMARY KEY (id),
	CONSTRAINT chk_nomenclador_tipo CHECK (tipo IN ('NBU', 'especial', 'convenio_particular', 'listado_anexo')),
	CONSTRAINT chk_nomenclador_estado CHECK (estado IN ('activo', 'inactivo')),
	CONSTRAINT nomenclador_creado_por_id_fkey FOREIGN KEY (creado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL,
	CONSTRAINT nomenclador_actualizado_por_id_fkey FOREIGN KEY (actualizado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL
);

CREATE TABLE public.autorizador (
	id serial4 NOT NULL,
	nombre varchar(255) NOT NULL,
	tipo varchar(30) DEFAULT 'Portal externo' NOT NULL,
	link text NULL,
	instructivo text NULL,
	observacion text NULL,
	estado varchar(20) DEFAULT 'activo' NOT NULL,
	creado_por_id int4 NULL,
	actualizado_por_id int4 NULL,
	created_at timestamp DEFAULT now() NOT NULL,
	updated_at timestamp DEFAULT now() NOT NULL,
	CONSTRAINT autorizador_pkey PRIMARY KEY (id),
	CONSTRAINT chk_autorizador_tipo CHECK (tipo IN ('Portal externo', 'Sistema interno')),
	CONSTRAINT chk_autorizador_estado CHECK (estado IN ('activo', 'inactivo')),
	CONSTRAINT autorizador_creado_por_id_fkey FOREIGN KEY (creado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL,
	CONSTRAINT autorizador_actualizado_por_id_fkey FOREIGN KEY (actualizado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL
);

CREATE TABLE public.obra_social (
	id serial4 NOT NULL,
	nombre varchar(255) NOT NULL,
	estado varchar(20) DEFAULT 'activo' NOT NULL,
	estado_informacion varchar(20) DEFAULT 'borrador' NOT NULL,
	mostrar_web bool DEFAULT false NOT NULL,
	habilitar_ia bool DEFAULT false NOT NULL,
	modalidad_autorizacion varchar(50) NULL,
	observacion_general text NULL,
	informacion_publica text NULL,
	fecha_ultima_validacion timestamp NULL,
	validado_por_id int4 NULL,
	creado_por_id int4 NULL,
	actualizado_por_id int4 NULL,
	created_at timestamp DEFAULT now() NOT NULL,
	updated_at timestamp DEFAULT now() NOT NULL,
	CONSTRAINT obra_social_pkey PRIMARY KEY (id),
	CONSTRAINT chk_obra_social_estado CHECK (estado IN ('activo', 'limitada', 'suspendida', 'sin_atencion')),
	CONSTRAINT chk_obra_social_estado_info CHECK (estado_informacion IN ('borrador', 'validada')),
	CONSTRAINT obra_social_validado_por_id_fkey FOREIGN KEY (validado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL,
	CONSTRAINT obra_social_creado_por_id_fkey FOREIGN KEY (creado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL,
	CONSTRAINT obra_social_actualizado_por_id_fkey FOREIGN KEY (actualizado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL
);

CREATE TABLE public.obra_social_alias (
	id serial4 NOT NULL,
	id_obra_social int4 NOT NULL,
	alias varchar(150) NOT NULL,
	CONSTRAINT obra_social_alias_pkey PRIMARY KEY (id),
	CONSTRAINT obra_social_alias_id_obra_social_fkey FOREIGN KEY (id_obra_social) REFERENCES public.obra_social(id) ON DELETE CASCADE
);
CREATE INDEX idx_obra_social_alias_obra_social ON public.obra_social_alias (id_obra_social);

CREATE TABLE public.obra_social_plan (
	id serial4 NOT NULL,
	id_obra_social int4 NOT NULL,
	nombre varchar(150) NOT NULL,
	codigo_datatech_gravado varchar(50) NULL,
	codigo_datatech_exento varchar(50) NULL,
	estado varchar(20) DEFAULT 'activo' NOT NULL,
	observacion text NULL,
	created_at timestamp DEFAULT now() NOT NULL,
	updated_at timestamp DEFAULT now() NOT NULL,
	CONSTRAINT obra_social_plan_pkey PRIMARY KEY (id),
	CONSTRAINT chk_obra_social_plan_estado CHECK (estado IN ('activo', 'limitada', 'suspendida', 'sin_atencion')),
	CONSTRAINT obra_social_plan_id_obra_social_fkey FOREIGN KEY (id_obra_social) REFERENCES public.obra_social(id) ON DELETE CASCADE
);
-- "alcance" (Todos los planes/Plan específico/Resto de los planes) se quitó
-- (migracion_quitar_alcance_plan.sql): ya no se usa.
CREATE INDEX idx_obra_social_plan_obra_social ON public.obra_social_plan (id_obra_social);

CREATE TABLE public.obra_social_historial_estado (
	id serial4 NOT NULL,
	id_obra_social int4 NOT NULL,
	id_plan int4 NULL,
	estado_anterior varchar(20) NULL,
	estado_nuevo varchar(20) NOT NULL,
	comunicado_por varchar(150) NULL,
	motivo text NULL,
	creado_por_id int4 NULL,
	created_at timestamp DEFAULT now() NOT NULL,
	CONSTRAINT obra_social_historial_estado_pkey PRIMARY KEY (id),
	CONSTRAINT obra_social_historial_estado_id_obra_social_fkey FOREIGN KEY (id_obra_social) REFERENCES public.obra_social(id) ON DELETE CASCADE,
	CONSTRAINT obra_social_historial_estado_id_plan_fkey FOREIGN KEY (id_plan) REFERENCES public.obra_social_plan(id) ON DELETE CASCADE,
	CONSTRAINT obra_social_historial_estado_creado_por_id_fkey FOREIGN KEY (creado_por_id) REFERENCES public.usuario(id) ON DELETE SET NULL
);
CREATE INDEX idx_obra_social_historial_obra_social ON public.obra_social_historial_estado (id_obra_social, created_at);

CREATE TABLE public.obra_social_contacto (
	id serial4 NOT NULL,
	id_obra_social int4 NOT NULL,
	tipo varchar(30) DEFAULT 'General' NOT NULL,
	nombre varchar(150) NULL,
	telefono varchar(50) NULL,
	whatsapp varchar(50) NULL,
	email varchar(150) NULL,
	observacion text NULL,
	CONSTRAINT obra_social_contacto_pkey PRIMARY KEY (id),
	CONSTRAINT chk_obra_social_contacto_tipo CHECK (tipo IN ('General', 'Autorizaciones', 'Auditoría', 'Convenios', 'Facturación', 'Otro')),
	CONSTRAINT obra_social_contacto_id_obra_social_fkey FOREIGN KEY (id_obra_social) REFERENCES public.obra_social(id) ON DELETE CASCADE
);
CREATE INDEX idx_obra_social_contacto_obra_social ON public.obra_social_contacto (id_obra_social);

CREATE TABLE public.obra_social_nomenclador (
	id serial4 NOT NULL,
	id_obra_social int4 NOT NULL,
	id_nomenclador int4 NOT NULL,
	CONSTRAINT obra_social_nomenclador_pkey PRIMARY KEY (id),
	CONSTRAINT uq_obra_social_nomenclador UNIQUE (id_obra_social, id_nomenclador),
	CONSTRAINT obra_social_nomenclador_id_obra_social_fkey FOREIGN KEY (id_obra_social) REFERENCES public.obra_social(id) ON DELETE CASCADE,
	CONSTRAINT obra_social_nomenclador_id_nomenclador_fkey FOREIGN KEY (id_nomenclador) REFERENCES public.nomenclador(id) ON DELETE RESTRICT
);

CREATE TABLE public.obra_social_autorizador (
	id serial4 NOT NULL,
	id_obra_social int4 NOT NULL,
	id_autorizador int4 NOT NULL,
	prioridad varchar(20) DEFAULT 'principal' NOT NULL,
	usuario varchar(150) NULL,
	password varchar(255) NULL,
	observacion text NULL,
	CONSTRAINT obra_social_autorizador_pkey PRIMARY KEY (id),
	CONSTRAINT chk_obra_social_autorizador_prioridad CHECK (prioridad IN ('principal', 'alternativo')),
	CONSTRAINT uq_obra_social_autorizador UNIQUE (id_obra_social, id_autorizador),
	CONSTRAINT obra_social_autorizador_id_obra_social_fkey FOREIGN KEY (id_obra_social) REFERENCES public.obra_social(id) ON DELETE CASCADE,
	CONSTRAINT obra_social_autorizador_id_autorizador_fkey FOREIGN KEY (id_autorizador) REFERENCES public.autorizador(id) ON DELETE RESTRICT
);
