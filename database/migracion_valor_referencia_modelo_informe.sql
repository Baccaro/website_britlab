-- Nuevo campo de texto libre "Valor de Referencia", al lado de las
-- Observaciones del dropdown "Modelo de Informe" (antes "Modelo Derivante")
-- en el formulario de Estudio x Laboratorio Procesante. Mismo nombre de
-- columna con el prefijo "modelo_derivante_" que su par existente
-- (modelo_derivante_observaciones): la sección se renombró en la UI, pero
-- no hace falta renombrar también las columnas ya existentes.
BEGIN;
ALTER TABLE public.estudio_colega ADD COLUMN modelo_derivante_valor_referencia text NULL;
COMMIT;
