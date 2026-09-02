-- Agrega soporte para que un estudio_derivante tenga 1..N muestras, cada una
-- descripta con 9 dimensiones estructuradas (tipo, aditivo, volumen, unidad,
-- recipiente, modalidad de recolección, técnica de recolección, conservación,
-- condición especial, prioridad de envío).
--
-- Es puramente aditivo: no toca 'muestra' ni 'estudio_derivante.id_muestra'
-- (736 de 744 registros ya tienen ese campo cargado); la tabla vieja sigue
-- funcionando como hasta ahora, esto es una capacidad nueva en paralelo.

BEGIN;

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

CREATE TABLE public.estudio_derivante_muestra (
    id serial4 NOT NULL,
    id_estudio_derivante int4 NOT NULL,
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
    created_at timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
    CONSTRAINT estudio_derivante_muestra_pkey PRIMARY KEY (id),
    CONSTRAINT edm_id_estudio_derivante_fkey FOREIGN KEY (id_estudio_derivante) REFERENCES public.estudio_derivante(id) ON DELETE CASCADE,
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

-- 1. Tipo de Muestra
INSERT INTO public.tipo_muestra (nombre) VALUES
('Biopsia'), ('Cálculo Urinario'), ('DNA Extraído'), ('Esputo'),
('Exudado Endocervical'), ('Exudado Uretral'), ('Flujo Urogenital'),
('Heces / Materia Fecal'), ('LCR (Líquido Cefalorraquídeo)'), ('Lesión'),
('Líquido Amniótico'), ('Líquido Biológico'), ('Líquido de Punción'),
('Moco Nasal'), ('Material de Aborto (Restos Ovulares)'), ('Médula Ósea'),
('Muestra Biológica (Genérica)'), ('Muestra Respiratoria (Genérica)'),
('Nódulo'), ('Orina'), ('Plasma'), ('Saliva'), ('Sangre / Sangre Entera'),
('Secreción Nasofaríngea'), ('Secreción Traqueal'), ('Semen'), ('Suero');

-- 2. Aditivo
INSERT INTO public.aditivo (nombre) VALUES
('Citrato de Sodio'), ('Citrato de Sodio (Pobre en Plaquetas - PP)'),
('EDTA'), ('Heparina'), ('Heparina Sódica');

-- 4. Unidad de Medida
INSERT INTO public.unidad_medida (nombre) VALUES
('µL'), ('mL'), ('mg'), ('g'), ('tubo completo'), ('unidad');

-- 5. Recipiente
INSERT INTO public.recipiente (nombre) VALUES
('Recipiente Estéril'), ('Soporte / Papel de Filtro (DBS)'),
('Tubo Opaco'), ('Tubo Estándar');

-- 7. Modalidad de Recolección
INSERT INTO public.modalidad_recoleccion (nombre) VALUES
('1º micción del dia'), ('3 Horas de Retención'),
('20 min / 40 min (Series Temporales)'), ('Post-Dexametasona'),
('Post-Dosis (4 horas)'), ('Post-Estímulo (30 min, 60 min)'),
('Post-HD (Post-Hemodiálisis)'), ('Post-Isquemia'), ('Post-Jornada Laboral'),
('Post-Sobrecarga (30 min, 60 min, 90 min, 120 min, 180 min)'),
('Muestras Simultáneas'), ('Pool de Orinas (5 muestras)'),
('Con Dieta Específica'), ('Recolección Multidía (Día 4, 5 y 6)'),
('retencion 3h'), ('retencion 12h'), ('retencion 24h'),
('Orina Aislada / Espontánea');

-- 8. Técnica de Recolección
INSERT INTO public.tecnica_recoleccion (nombre) VALUES
('AAF / PAAF (Aspiración con Aguja Fina)'), ('Aspirado'),
('Cepillado Cervical'), ('Extendido / Frotis'),
('Hisopado (Bucal, Nasal, Nasofaríngeo, Urogenital)'),
('Lavado Gastroduodenal'), ('MiniBAL'), ('Punción'),
('Sobrenadante (Post-Centrifugación de Punción)');

-- 9. Conservación / Temperatura
INSERT INTO public.conservacion (nombre) VALUES
('A Temperatura Ambiente'), ('Refrigerado / Refrigerada'), ('Congelado'),
('Fresca / En Seco'), ('Sin Refrigerar');

-- 10. Condiciones Especiales de Procesamiento
INSERT INTO public.condicion_especial (nombre) VALUES
('Acidificada'), ('Anaerobiosis'), ('Doble Centrifugación'), ('Estéril');

-- 11. Prioridad / Condición de Envío
INSERT INTO public.prioridad_envio (nombre) VALUES
('Envío Urgente'), ('Normal / Estándar'), ('Viable solo 24 horas');

COMMIT;
