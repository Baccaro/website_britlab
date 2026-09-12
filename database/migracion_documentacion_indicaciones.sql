-- Separa "Pre-analítico e Indicaciones" en dropdowns propios y le suma
-- documentación (PDF) a Preanalítico e Indicaciones Paciente (antes sólo
-- tenía PDFs "Modelo Colega"). También agrega Observaciones + PDFs con
-- descripción propia a un dropdown nuevo, "Modelo Derivante", separado de
-- las Indicaciones al Profesional/Derivante (que quedan sólo como texto).
BEGIN;

ALTER TABLE public.estudio_colega
    ADD COLUMN preanalitico_descripcion text,
    ADD COLUMN modelo_derivante_observaciones text;

-- 'categoria' distingue a qué dropdown pertenece cada PDF adjunto (antes todos
-- eran "modelo del colega"); 'descripcion' es el comentario propio de cada
-- archivo (sólo se usa desde "Modelo Derivante", pero no hace daño tenerlo
-- disponible para las demás categorías).
ALTER TABLE public.estudio_colega_modelo
    ADD COLUMN categoria varchar(20) NOT NULL DEFAULT 'colega',
    ADD COLUMN descripcion text,
    ADD CONSTRAINT chk_ecm_categoria CHECK (categoria IN ('preanalitico', 'paciente', 'colega'));

COMMIT;
