-- Corrige la jerarquía de muestras: un estudio_colega tiene N muestras
-- (estudio_colega_muestra, ya existente); cada una de esas muestras puede
-- tener N alternativas propias, que ahora viven en esta tabla nueva,
-- referenciando a SU muestra (no al estudio_colega directamente).

BEGIN;

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
    orden int4 NOT NULL DEFAULT 1,
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

COMMIT;
