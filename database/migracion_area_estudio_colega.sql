-- El campo "Área" del alta de Estudio x Laboratorio Procesante
-- (estudio_colega.id_sector_laboratorio) apuntaba a valor_estudio_sector
-- (Estudio + Sector + Posición en informe + Rango), no al área en sí: por
-- eso el desplegable mostraba nombres de ESTUDIOS ("... - Posición Informe:
-- N") en vez de simplemente el nombre del área (Hematología, Química, ...).
--
-- Se cambia para que apunte directo a sector, preservando el vínculo de
-- cada fila ya cargada: se toma el sector de su valor_estudio_sector actual
-- antes de borrar esa referencia.
BEGIN;

ALTER TABLE public.estudio_colega DROP CONSTRAINT estudio_colega_id_sector_laboratorio_fkey;

UPDATE public.estudio_colega ec
SET id_sector_laboratorio = ves.id_sector
FROM public.valor_estudio_sector ves
WHERE ec.id_sector_laboratorio = ves.id;

ALTER TABLE public.estudio_colega
  ADD CONSTRAINT estudio_colega_id_sector_laboratorio_fkey
  FOREIGN KEY (id_sector_laboratorio) REFERENCES public.sector(id) ON DELETE SET NULL;

COMMIT;
