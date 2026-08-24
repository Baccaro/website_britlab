-- 1. Tablas Maestras (Tablas de soporte para Dropdowns / Selects en los ABMs)

CREATE TABLE secciones_laboratorio (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    codigo_rango VARCHAR(50), -- Ej: '901 A 1300'
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE metodos_analisis (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE tipos_muestra (
    id SERIAL PRIMARY KEY,
    descripcion TEXT NOT NULL UNIQUE -- Ej: 'SUERO (1 ml) REFRIGERADO'
);

CREATE TABLE estados_obra_social (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE, -- 'ACTIVO', 'LIMITADA', 'SUSPENDIDA', 'SIN_ATENCION'
    descripcion VARCHAR(100) NOT NULL,
    significado TEXT NOT NULL
);

-- 2. Tabla Principal de Estudios / Análisis de Laboratorio

CREATE TABLE estudios (
    id SERIAL PRIMARY KEY,
    codigo_hexalis VARCHAR(20) NOT NULL UNIQUE,
    nemonico_datatech VARCHAR(20),
    nombre VARCHAR(255) NOT NULL,
    seccion_id INT REFERENCES secciones_laboratorio(id) ON DELETE SET NULL,
    metodo_id INT REFERENCES metodos_analisis(id) ON DELETE SET NULL,
    muestra_id INT REFERENCES tipos_muestra(id) ON DELETE SET NULL,
    
    resultado_preanalitico VARCHAR(255), -- Datos solicitados al paciente (FUM, Edad, etc.)
    indicaciones TEXT,                   -- Instrucciones previas al estudio
    valores_referencia TEXT,             -- Rangos normales / Texto descriptivo
    demora_dias_habiles NUMERIC(4, 1),   -- Ej: 5.0 días
    
    requiere_modelo_informe BOOLEAN DEFAULT FALSE,
    estado_paridad VARCHAR(50) DEFAULT 'NO APLICA', -- Status paridad Hexalis-Datatech
    
    version_fecha DATE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE
);

-- Índices para búsquedas ultra rápidas en el Backoffice y la Intranet
CREATE INDEX idx_estudios_codigo_hexalis ON estudios(codigo_hexalis);
CREATE INDEX idx_estudios_nombre ON estudios(nombre);
CREATE INDEX idx_estudios_seccion ON estudios(seccion_id);
