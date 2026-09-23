-- Se quita "alcance" (Todos los planes/Plan específico/Resto de los planes)
-- de obra_social_plan: pedido explícito del usuario, ya no se usa.
BEGIN;

ALTER TABLE public.obra_social_plan DROP CONSTRAINT IF EXISTS chk_obra_social_plan_alcance;
ALTER TABLE public.obra_social_plan DROP COLUMN IF EXISTS alcance;

COMMIT;
