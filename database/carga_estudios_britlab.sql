-- Script generado a partir de britlab.csv (LISTADO DE ESTUDIOS LOCALES Y DERIVADOS)
-- Campos extraidos: nemonico, paridad, codigo hexalis, estudio, status, metodo, dias
-- Colega destino: BRITLAB (colega_id = 49, es_propio = true)
-- Es un UPSERT: no duplica datos ya cargados, sincroniza valores si cambiaron en el CSV.
BEGIN;

-- 1) Asegurar que exista el estudio (catalogo codigo_hexalis + descripcion)
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660352', 'ACIDO FOLICO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660592', 'ACIDO LACTICO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('662367', 'ACIDOS BILIARES SERICOS')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660007', 'ADDIS, RECUENTO DE')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660015', 'ALBUMINA SERICA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660020', 'ALFA FETO PROTEINA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660422A', 'AMILASA EN LIQUIDO BIOLOGICO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660022', 'AMILASA SERICA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660031', 'AMONEMIA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('662709', 'ANTICOAGULANTE LUPICO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660051', 'ANTIESTREPTOLISINAS "O"')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661000', 'ANTIGENO PROSTATICO ESPECIFICO TOTAL')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('AEP', 'ANTIGENO PROSTATICO ESPECIFICO TOTAL - PSAt')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661000A', 'ANTIGENO PROSTATICO ESPECIFICO TOTAL Y LIBRE')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('662734', 'ANTIGENO PROSTATICO ESPECIFICO TOTAL Y LIBRE')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('662803', 'ANTITROMBINA III, ACTIVIDAD FUNCIONAL')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('662811', 'APOLIPOPROTEINA A')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('662811B', 'APOLIPOPROTEINA B')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('668315', 'ATPO - PEROXIDASA TIROIDEA, AC. ANTI')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('667503', 'BETA 2 MICROGLOBULINA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660004', 'BICARBONATO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660110', 'BILIRRUBINEMIA TOTAL, DIRECTA E INDIRECTA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661115', 'CA 125, MARCADOR TUMORAL de OVARIO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('CA15-3', 'CA 15-3, MARCADOR TUMORAL de MAMA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661125', 'CA 19-9, MARCADOR TUMORAL de COLON')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661125B', 'CA 19-9, MARCADOR TUMORAL de COLON')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660136B', 'CALCIO EN ORINA AISLADA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660134', 'CALCIO IONICO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660133', 'CALCIO TOTAL')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660136', 'CALCIO URINARIO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660138', 'CALCULO URINARIO, ESTUDIO CRISTALOGRAFICO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('663375', 'CARBOXIHEMOGLOBINA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660144', 'CEA - ANTIGENO CARCINOEMBRIOGENICO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660151', 'CERULOPLASMINA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('050', 'CETONEMIA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('051', 'CETONURIA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660242', 'CHAGAS, DETECCION POR EIA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660241', 'CHAGAS, DETECCION POR HAI')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661025', 'CITOMEGALOVIRUS, Ac. IgG ANTI')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661030', 'CITOMEGALOVIRUS, Ac. IgM ANTI')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661030A', 'CITOMEGALOVIRUS, Ac. IgM ANTI')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660170', 'COAGULO, RETRACCION DEL')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('300', 'COAGULOGRAMA COMPLETO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661035', 'COLESTEROL HDL')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661040', 'COLESTEROL LDL')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660174', 'COLESTEROL TOTAL')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('669918', 'COLESTEROL VLDL')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('669918A', 'COLESTEROL VLDL')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661040B', 'COLESTEROL-LDL')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660772', 'COLINESTERASA SERICA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660180', 'COMPLEMENTO C3')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660180A', 'COMPLEMENTO C4')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660179', 'COMPLEMENTO, ACTIVIDAD TOTAL - 50% DE LISIS (CH50)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660189', 'CORTISOL 8h')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660189P', 'CORTISOL BASAL (8h) Y VESPERTINO (18h)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660189D', 'CORTISOL, POST-ESTIMULO CON DEXAMETASONA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660190', 'CREATINAFOSFOQUINASA - CPK')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660190B', 'CREATINAFOSFOQUINASA, ISOENZIMA MB (CPKMB masa)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660192D', 'CREATININA EN LIQUIDO BIOLOGICO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660192B', 'CREATININA EN ORINA AISLADA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660192', 'CREATININA SERICA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660192A', 'CREATININA URINARIA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('193', 'CREATININA, CLEARENCE DE DEPURACION')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660195A', 'CRIOAGLUTININAS')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660195', 'CRIOGLOBULINAS')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660262', 'DHEA-S DEHIDROEPIANDROSTERONA, SULFATO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661135E', 'DIFENILHIDANTOINA, MONITOREO de FARMACOS para ENF. CRONICAS')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('664419A', 'DIMERO-D')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661050A', 'DROGAS DE ABUSO, SCREENING')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661055', 'EPSTEIN BARR, Ac. IgG ANTI-CAPSIDE VIRAL')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661060', 'EPSTEIN BARR, Ac. IgM ANTI-CAPSIDE VIRAL')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660297', 'ERITROSEDIMENTACION')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660005', 'ESTADO ACIDO BASE CON OXIMETRIA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('66005A', 'ESTADO ACIDO BASE CON OXIMETRIA E IONOGRAMA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660300', 'ESTRADIOL SERICO - E2')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('665050', 'EUGLOBULINAS, LISIS DE (POST-ISQUEMIA)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('665050A', 'EUGLOBULINAS, LISIS DE (PRE-ISQUEMIA)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660598', 'FACTOR REUMATOIDEO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660343', 'FERREMIA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('665230', 'FERRITINA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660345', 'FIBRINOGENO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660354A', 'FORMULA LEUCOCITARIA ABSOLUTA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660357', 'FOSFATASA ALCALINA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660362', 'FOSFATEMIA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660363', 'FOSFATURIA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660363A', 'FOSFATURIA EN ORINA AISLADA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660367A', 'FOSFORO, REABSORCION TUBULAR')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661065', 'FRUCTOSAMINA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660370', 'FSH - HORMONA FOLICULO ESTIMULANTE')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660420', 'GAMA GLUTAMIL TRANSPEPTIDASA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('665632', 'GLOBULINA LIGADORA DE ANDROGENOS Y ESTROGENOS - GLAE - SHBG')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660409', 'GLOBULOS BLANCOS, RECUENTO DE')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660410', 'GLOBULOS ROJOS, RECUENTO DE')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660412', 'GLUCEMIA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660412A', 'GLUCEMIA INTRA CIRUGÍA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660506', 'GLUCEMIA POST PRANDIAL 75 g')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660504', 'GLUCEMIA, 120 minutos post 75 g de glucosa')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660505', 'GLUCEMIA, 180 minutos post 75 g de glucosa')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660501', 'GLUCEMIA, 30 minutos post 75 g de glucosa')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660502', 'GLUCEMIA, 60 minutos post 75 g de glucosa')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660503', 'GLUCEMIA, 90 minutos post 75 g de glucosa')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660412C', 'GLUCOSURIA EN ORINA AISLADA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660007A', 'HAMBURGER, RECUENTO DE')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('665734', 'HAPTOGLOBINA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('668627', 'HE4 - PROTEINA DEL EPIDIDIMO HUMANO 4')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('HU', 'HEMATIES URINARIOS, EVALUACION MORFOLOGICA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660466', 'HEMATOCRITO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661070', 'HEMOGLOBINA GLICOSILADA - HbA1c')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660470', 'HEMOGLOBINA, DOSAJE DE')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660475', 'HEMOGRAMA CON RECUENTO DE PLAQUETAS')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660475B', 'HEMOGRAMA SIN RECUENTO DE PLAQUETAS')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('665871', 'HEPARINA DE BAJO PESO MOLECULAR, ACTIVIDAD ANTI Xa')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('665888', 'HEPATITIS A, Ac. IgG ANTI (HVA IgG)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661075', 'HEPATITIS A, Ac. IgM ANTI (HVA IgM)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('665905', 'HEPATITIS B, Ac. ANTI-CORE IgM (HBc-IgM)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661080', 'HEPATITIS B, Ac. ANTI-CORE TOTALES (HBc-Ac. TOTALES)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661086', 'HEPATITIS B, Ac. DE SUPERFICIE ANTI - HBsAc')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661090', 'HEPATITIS B, ANTIGENO DE SUPERFICIE - HBsAg')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661095', 'HEPATITIS C, Ac. IgG ANTI (HCV Ac IgG)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660481', 'HEPATOGRAMA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('666042', 'HERPES SIMPLEX 1, Ac. IgG ANTI')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('666067', 'HERPES SIMPLEX 2, Ac. IgG ANTI')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660063', 'HIV, Ac. ANTI-HIV1 y 2 - p24 (Combo)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660063A', 'HIV, TEST RAPIDO (Ac. ANTI-HIV-1 Y ANTI-HIV-2)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('666708', 'HOMA - HOMEOSTATIC MODEL ASSESSMENT')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('666452', 'HOMOCISTEINA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('666537', 'HTLV-I/II, Ac. ANTI')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660494', 'HUDLESSON, REACCION DE')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660537', 'INMUNOGLOBULINA A (IgA)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('666589', 'INMUNOGLOBULINA A SECRETORIA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660539', 'INMUNOGLOBULINA E (IgE)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660540', 'INMUNOGLOBULINA G (IgG)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660541', 'INMUNOGLOBULINA M (IgM)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660543', 'INSULINA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660543A', 'INSULINA POST PRANDIAL')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660543E', 'INSULINA, 120 min POST ESTIMULO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660543H', 'INSULINA, 180 min POST ESTIMULO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660543A2', 'INSULINA, 30 min POST ESTIMULO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660543B', 'INSULINA, 60 min POST ESTIMULO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660543C', 'INSULINA, 90 min POST ESTIMULO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660547A', 'IONOGRAMA EN ORINA AISLADA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660546', 'IONOGRAMA PLASMATICO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660547', 'IONOGRAMA URINARIO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660887', 'KPTT')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('663994', 'KPTT, CORRECCION CON PLASMA NORMAL')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660597', 'LACTICO DEHIDROGENASA - LDH')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660603', 'LAZO, PRUEBA DEL')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('5291', 'LEUCOCITOS EN MATERIA FECAL')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660612', 'LH - HORMONA LUTEINIZANTE')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660313', 'LIPASA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('667187', 'LIPOPROTEINA a - Lp(a)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660619', 'LIQUIDO CEFALORRAQUIDEO, EXAMEN FISICOQUIMICO-CITOLOGICO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660619A', 'LIQUIDO DE PUNCION, EXAMEN FISICOQUIMICO-CITOLOGICO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660653', 'MAGNESIO SERICO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660654', 'MAGNESIO URINARIO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660656', 'MANTOUX, INTRADERMO-REACCION DE (PPD)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('666711', 'MDRD-4, FILTRADO GLOMERULAR ESTIMADO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('667409', 'METAHEMOGLOBINA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('667486', 'METOTREXATO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661130', 'MICROALBUMINURIA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661130A', 'MICROALBUMINURIA/CREATININURIA, RELACION')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660668', 'MOCO NASAL, pH Y CITOLOGICO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660669', 'MONONUCLEOSIS (AGLUTINACION - MONOTEST)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('NOTA', 'NOTA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660711', 'ORINA COMPLETA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('667926', 'OSMOLALIDAD URINARIA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660739', 'PARATHORMONA - PTH (MOLECULA BIOINTACTA)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660739A', 'PARATHORMONA INTRAOPERATORIA (BASAL)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660739B', 'PARATHORMONA INTRAOPERATORIA (MOVILIZACION)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660739C', 'PARATHORMONA INTRAOPERATORIA (POST-EXCERESIS)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('668284', 'PEPTIDO CITRULINADO CICLICO, Ac. IgG ANTI')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('663094', 'PEPTIDO NATRIURETICO TIPO B - BNP')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660005B', 'pH EN LIQUIDO BIOLOGICO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660746', 'PLAQUETAS, RECUENTO DE')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('668563', 'PROCALCITONINA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660758', 'PROGESTERONA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660759', 'PROLACTINA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660759D', 'PROLACTINA, POOL DE 3 MUESTRAS')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660761', 'PROTEINA C REACTIVA ULTRASENSIBLE - PCR')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('668614', 'PROTEINA C, ACTIVIDAD FUNCIONAL')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660764A', 'PROTEINAS FRACCIONADAS')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660763', 'PROTEINAS TOTALES')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660767', 'PROTEINURIA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660767A', 'PROTEINURIA EN ORINA AISLADA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('000003', 'PRUEBA DE EJERCICIO CON ISQUEMIA EN ANTEBRAZO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('668802', 'RECEPTOR TSH, Ac. ANTI (TRAb)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('668828', 'RESISTENCIA A LA PROTEINA C ACTIVADA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660818', 'RETICULOCITOS, RECUENTO DE')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660820', 'ROSSE-RAGAN, PRUEBA DE')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661145', 'RUBEOLA, Ac. IgG ANTI')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661150', 'RUBEOLA, Ac. IgM ANTI')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('5290', 'SANGRE OCULTA EN MATERIA FECAL')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660169', 'SANGRIA Y HOWELL, TIEMPOS')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661175', 'SUBUNIDAD BETA DE hCG')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661170', 'SUBUNIDAD BETA DE hCG, TEST RAPIDO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661170A', 'SUBUNIDAD BETA DE hCG, TEST RAPIDO EN ORINA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('665298', 'TACROLIMUS FK 506')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660863', 'TESTOSTERONA (To)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('661185', 'TESTOSTERONA BIODISPONIBLE')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('669375', 'TESTOSTERONA LIBRE (To-L)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660771', 'TIEMPO DE PROTROMBINA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660880', 'TIEMPO DE TROMBINA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('669443', 'TIROGLOBULINA (TGs)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('669460', 'TIROGLOBULINA, Ac. ANTI (ATG)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660865', 'TIROTROFINA - TSH')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660865E', 'TIROTROFINA, 30 min POST TRH')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660865G', 'TIROTROFINA, 60 min POST TRH')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660867', 'TIROXINA LIBRE - T4L')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660866', 'TIROXINA TOTAL - T4')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('TDM', 'TOMA DE MUESTRA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('1057A', 'TOXOPLASMOSIS, Ac. IgG ANTI')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('1056A', 'TOXOPLASMOSIS, Ac. IgM ANTI')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('663996', 'TP, CORRECCION CON PLASMA NORMAL')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660873', 'TRANSAMINASA GLUTAMICO OXALACETICA (GOT/AST)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660874', 'TRANSAMINASA GLUTAMICO PIRUVICA (GPT/AGT)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660875', 'TRANSFERRINA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660875A', 'TRANSFERRINA, CAPACIDAD DE SATURACION (SIDEROFILINA)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660933', 'TREPONEMA PALLIDUM, Ac. ANTI (SIFILIS)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660876', 'TRIGLICERIDOS')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('669661', 'TRIIODOTIRONINA LIBRE - T3L')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660878', 'TRIIODOTIRONINA TOTAL - T3')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('669735', 'TROPONINA I - TnI')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('69759', 'UREA EN LIQUIDO BIOLOGICO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660902B', 'UREA EN ORINA AISLADA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660902A', 'UREA EN ORINA DE 24h')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660902', 'UREA SERICA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660902P', 'UREA SERICA PRE y POST DIALISIS')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660901', 'UREA, CLEARENCE DE')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660904', 'URICEMIA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660905', 'URICOSURIA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('1229', 'V.D.R.L. CUANTITATIVA en LCR')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660934', 'V.D.R.L. CUANTITATIVA en SUERO')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('669793', 'VANCOMICINA')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660938', 'VITAMINA B12')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('669913', 'VITAMINA D3 (25-HIDROXICALCIFEROL)')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;
INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES ('660953', 'WIDAL, REACCION DE')
  ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion;

-- 2) Asegurar que exista el metodo (si la fila tiene metodo)
INSERT INTO public.metodo (nombre) VALUES ('CMIA')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Enzimático amperimétrico')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Enzimático colorimétrico')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Recuento en cámara')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Colorimétrico con BCF')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Enzimático con GLDH')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Coagulométrico automatizado')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Turbidimétrico')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Cromogénico cinético a 405 nm')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Inmunoturbidimetría')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Fórmula de Astrup')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Reacción diazo')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Arsenazo III')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Ión-electrodo selectivo')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Placa para manchas')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Espectrométrico')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Inmunodifusión radial')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Nitroprusiato')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('HAI')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Deterg. acelerador especifico')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Deterg. selectivo líquido')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Enzimático CHOD-PAP')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Enzimático')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Butirilcolina segun DGKC 37ºC')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Hemólisis al 50% (Grimberg)')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Cinetico UV a 37ªC con NAC')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Picrato alcalino cinético')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Inmunoensayo turbidimétrico')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Inmunocromatografía')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Westergreen')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Electrométrico')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Compleximétrico')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Coagulométrico, Clauss modificado')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Recuento automatizado')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Cinét.405 nm a 37ªC con p-NPP')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Fosfomolibdato')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Varios')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Colorimetría con NBT/formazán')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Colorimétrico enzimático')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Enzimático hexocinasa/G6PDH')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Enzimático (GOD)-amperimétrico')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Microscopía óptica')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Cinético cromogénico a 405 nm')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Cinético, reacción diazo.')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Inmunoanálisis cualitativo')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Aglutinación en placa')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Inmundifusión radial')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Turbidimetría')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Ión selectivo')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Cinético UV a 37ªC (IFCC)')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Rumpel-Leede')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Inmunoturbidimétrico')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('SCLAVO-TEST-PPD: 2 UI/0.1 ml')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Calculado')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Inmunoturbidimetría, cinético')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Tira react., microscop. optica')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Osmolalidad por cálculo')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Cromogénico cinético a  405 nm')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Colorimetría')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Biuret')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Coagulométrico')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Aglutinación directa')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Lee-Whyte y Duke')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Inmunocromatrografía')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Formula de Vermeulen')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Cinético U.V. a 37·C')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Inmunoturbidimetria')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Ferene')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Enzimático GPO-PAP')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Enzimático UV')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Enz.URICASA-PAP')
  ON CONFLICT (nombre) DO NOTHING;
INSERT INTO public.metodo (nombre) VALUES ('Floculación')
  ON CONFLICT (nombre) DO NOTHING;

-- 3) Upsert de estudio_colega para el colega BRITLAB (id 49)
--    Si ya existe una fila con ese nemonico para este colega, se actualiza.
--    Si no existe, se inserta (con revisor/colega_id obligatorios por defecto).
INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'FOLICO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660352'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'FOLICO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'FOLICO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'ACLAC', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático amperimétrico'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660592'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ACLAC'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático amperimétrico')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ACLAC';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'AC.BILIA', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático colorimétrico'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '662367'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AC.BILIA'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático colorimétrico')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AC.BILIA';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'ADD', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Recuento en cámara'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660007'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ADD'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Recuento en cámara')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ADD';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'ALB', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Colorimétrico con BCF'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660015'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ALB'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Colorimétrico con BCF')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ALB';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'AFP', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660020'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AFP'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AFP';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'AMLB', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático colorimétrico'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660422A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AMLB'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático colorimétrico')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AMLB';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'AM', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático colorimétrico'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660022'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AM'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático colorimétrico')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AM';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'AMONIO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático con GLDH'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660031'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AMONIO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático con GLDH')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AMONIO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'LUPICO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Coagulométrico automatizado'), 2, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '662709'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'LUPICO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 2,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Coagulométrico automatizado')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'LUPICO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'ASO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Turbidimétrico'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660051'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ASO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Turbidimétrico')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ASO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'AEP-NBU', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661000'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AEP-NBU'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AEP-NBU';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'AEP', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = 'AEP'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AEP'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AEP';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'AEP-LNBU', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661000A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AEP-LNBU'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AEP-LNBU';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'AEPL', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '662734'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AEPL'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AEPL';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'ATIII', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Cromogénico cinético a 405 nm'), 2, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '662803'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ATIII'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 2,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Cromogénico cinético a 405 nm')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ATIII';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'APOA', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '662811'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'APOA'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'APOA';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'APOB', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '662811B'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'APOB'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'APOB';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'ATPO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '668315'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ATPO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ATPO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'BETA-2', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '667503'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'BETA-2'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'BETA-2';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'BICAR/SU', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Fórmula de Astrup'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660004'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'BICAR/SU'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Fórmula de Astrup')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'BICAR/SU';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'BT', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Reacción diazo'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660110'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'BT'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Reacción diazo')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'BT';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CA-125', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661115'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CA-125'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CA-125';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CA15-3NB', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = 'CA15-3'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CA15-3NB'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CA15-3NB';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CA19-9', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661125'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CA19-9'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CA19-9';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CA19-9NB', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661125B'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CA19-9NB'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CA19-9NB';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CAO1', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Arsenazo III'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660136B'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CAO1'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Arsenazo III')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CAO1';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CAI', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Ión-electrodo selectivo'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660134'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CAI'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Ión-electrodo selectivo')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CAI';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CA', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Arsenazo III'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660133'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CA'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Arsenazo III')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CA';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CAO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Arsenazo III'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660136'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CAO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Arsenazo III')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CAO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CAUR', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Placa para manchas'), 8, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660138'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CAUR'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 8,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Placa para manchas')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CAUR';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CARBO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Espectrométrico'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '663375'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CARBO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Espectrométrico')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CARBO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CEA', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660144'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CEA'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CEA';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CERU', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunodifusión radial'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660151'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CERU'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunodifusión radial')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CERU';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CETONE', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Nitroprusiato'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '050'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CETONE'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Nitroprusiato')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CETONE';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CETONU', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Nitroprusiato'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '051'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CETONU'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Nitroprusiato')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CETONU';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CHAEIA', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660242'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CHAEIA'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CHAEIA';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CHAHAI', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'HAI'), 2, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660241'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CHAHAI'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 2,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'HAI')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CHAHAI';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'ACITOG', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661025'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ACITOG'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ACITOG';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'ACITOM-N', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661030'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ACITOM-N'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ACITOM-N';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'ACITOM', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661030A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ACITOM'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ACITOM';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'RCO', 'listo'::estado_paridad_enum, est.id, NULL, 2, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660170'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'RCO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 2,
  estado = 'listo'::estado_registro_enum,
  id_metodo = NULL
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'RCO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'COAGU', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Coagulométrico automatizado'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '300'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'COAGU'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Coagulométrico automatizado')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'COAGU';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HDL', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Deterg. acelerador especifico'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661035'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HDL'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Deterg. acelerador especifico')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HDL';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'LDL', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Deterg. selectivo líquido'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661040'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'LDL'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Deterg. selectivo líquido')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'LDL';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'C', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático CHOD-PAP'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660174'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'C'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático CHOD-PAP')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'C';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'VLDL', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '669918'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'VLDL'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'VLDL';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'VLDL-NBU', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '669918A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'VLDL-NBU'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'VLDL-NBU';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'LDL-NBU', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Deterg. selectivo líquido'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661040B'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'LDL-NBU'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Deterg. selectivo líquido')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'LDL-NBU';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CHE', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Butirilcolina segun DGKC 37ºC'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660772'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CHE'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Butirilcolina segun DGKC 37ºC')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CHE';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'C3', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660180'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'C3'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'C3';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'C4', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660180A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'C4'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'C4';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TH50', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Hemólisis al 50% (Grimberg)'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660179'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TH50'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Hemólisis al 50% (Grimberg)')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TH50';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'COR', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660189'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'COR'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'COR';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'COR-18', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660189P'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'COR-18'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'COR-18';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'COR-ES', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660189D'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'COR-ES'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'COR-ES';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CPK', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Cinetico UV a 37ªC con NAC'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660190'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CPK'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Cinetico UV a 37ªC con NAC')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CPK';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CKMBMASA', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660190B'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CKMBMASA'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CKMBMASA';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CRLB', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Picrato alcalino cinético'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660192D'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CRLB'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Picrato alcalino cinético')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CRLB';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CRO1', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Picrato alcalino cinético'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660192B'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CRO1'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Picrato alcalino cinético')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CRO1';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CR', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Picrato alcalino cinético'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660192'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CR'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Picrato alcalino cinético')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CR';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CRO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Picrato alcalino cinético'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660192A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CRO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Picrato alcalino cinético')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CRO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'DCE', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Picrato alcalino cinético'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '193'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'DCE'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Picrato alcalino cinético')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'DCE';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CRIO', 'listo'::estado_paridad_enum, est.id, NULL, 2, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660195A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CRIO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 2,
  estado = 'listo'::estado_registro_enum,
  id_metodo = NULL
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CRIO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CRIOGLO', 'listo'::estado_paridad_enum, est.id, NULL, 2, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660195'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CRIOGLO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 2,
  estado = 'listo'::estado_registro_enum,
  id_metodo = NULL
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CRIOGLO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'DHEA', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660262'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'DHEA'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'DHEA';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TD-DIF', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661135E'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TD-DIF'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TD-DIF';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'DIMERO D', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunoensayo turbidimétrico'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '664419A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'DIMERO D'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunoensayo turbidimétrico')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'DIMERO D';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'DROGAS', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunocromatografía'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661050A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'DROGAS'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunocromatografía')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'DROGAS';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'AE-B', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661055'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AE-B'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AE-B';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'AEBCM', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661060'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AEBCM'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AEBCM';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'E', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Westergreen'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660297'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'E'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Westergreen')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'E';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'EAB', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Electrométrico'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660005'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'EAB'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Electrométrico')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'EAB';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'EABI', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Electrométrico'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '66005A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'EABI'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Electrométrico')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'EABI';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'E2', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660300'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'E2'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'E2';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TLE2', 'listo'::estado_paridad_enum, est.id, NULL, 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '665050'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TLE2'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = NULL
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TLE2';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TLE1', 'listo'::estado_paridad_enum, est.id, NULL, 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '665050A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TLE1'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = NULL
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TLE1';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'FR', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660598'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'FR'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'FR';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'FE', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Compleximétrico'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660343'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'FE'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Compleximétrico')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'FE';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'FERR', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '665230'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'FERR'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'FERR';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'FIB', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Coagulométrico, Clauss modificado'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660345'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'FIB'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Coagulométrico, Clauss modificado')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'FIB';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'FLA', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Recuento automatizado'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660354A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'FLA'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Recuento automatizado')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'FLA';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'FOH', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Cinét.405 nm a 37ªC con p-NPP'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660357'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'FOH'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Cinét.405 nm a 37ªC con p-NPP')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'FOH';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'P', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Fosfomolibdato'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660362'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'P'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Fosfomolibdato')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'P';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'PO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Fosfomolibdato'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660363'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Fosfomolibdato')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'PO1', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Fosfomolibdato'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660363A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PO1'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Fosfomolibdato')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PO1';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'RTP', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Varios'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660367A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'RTP'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Varios')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'RTP';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'FRUCTO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Colorimetría con NBT/formazán'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661065'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'FRUCTO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Colorimetría con NBT/formazán')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'FRUCTO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'FSH', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660370'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'FSH'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'FSH';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'GGT', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Colorimétrico enzimático'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660420'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GGT'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Colorimétrico enzimático')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GGT';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'GLOBTRAN', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '665632'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GLOBTRAN'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GLOBTRAN';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'GB', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Recuento automatizado'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660409'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GB'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Recuento automatizado')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GB';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'GR', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Recuento automatizado'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660410'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GR'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Recuento automatizado')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GR';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'G', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático hexocinasa/G6PDH'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660412'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'G'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático hexocinasa/G6PDH')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'G';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'GCIR', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático (GOD)-amperimétrico'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660412A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GCIR'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático (GOD)-amperimétrico')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GCIR';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'GPP', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático hexocinasa/G6PDH'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660506'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GPP'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático hexocinasa/G6PDH')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GPP';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'GP120MIN', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático hexocinasa/G6PDH'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660504'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GP120MIN'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático hexocinasa/G6PDH')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GP120MIN';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'GP180MIN', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático hexocinasa/G6PDH'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660505'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GP180MIN'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático hexocinasa/G6PDH')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GP180MIN';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'GP 30MIN', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático hexocinasa/G6PDH'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660501'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GP 30MIN'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático hexocinasa/G6PDH')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GP 30MIN';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'GP 60MIN', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático hexocinasa/G6PDH'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660502'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GP 60MIN'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático hexocinasa/G6PDH')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GP 60MIN';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'GP 90MIN', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático hexocinasa/G6PDH'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660503'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GP 90MIN'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático hexocinasa/G6PDH')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GP 90MIN';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'GLU', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático hexocinasa/G6PDH'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660412C'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GLU'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático hexocinasa/G6PDH')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GLU';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HAM', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Recuento en cámara'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660007A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HAM'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Recuento en cámara')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HAM';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HAP', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '665734'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HAP'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HAP';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HE4', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '668627'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HE4'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HE4';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HU', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Microscopía óptica'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = 'HU'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HU'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Microscopía óptica')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HU';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HTO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Recuento automatizado'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660466'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HTO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Recuento automatizado')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HTO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HGL1', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661070'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HGL1'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HGL1';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HB', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Recuento automatizado'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660470'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HB'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Recuento automatizado')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HB';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HC', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Recuento automatizado'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660475'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HC'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Recuento automatizado')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HC';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HS', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Recuento automatizado'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660475B'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HS'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Recuento automatizado')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HS';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HEP', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Cinético cromogénico a 405 nm'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '665871'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HEP'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Cinético cromogénico a 405 nm')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HEP';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HEPAG', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '665888'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HEPAG'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HEPAG';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HEPAM', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661075'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HEPAM'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HEPAM';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HEPBCM', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '665905'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HEPBCM'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HEPBCM';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HEPBCTO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661080'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HEPBCTO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HEPBCTO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HEPBSAC', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661086'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HEPBSAC'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HEPBSAC';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HEPBSAG', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661090'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HEPBSAG'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HEPBSAG';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HEPCAC', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661095'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HEPCAC'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HEPCAC';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HEC1', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Cinético, reacción diazo.'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660481'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HEC1'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Cinético, reacción diazo.')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HEC1';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HERP1G', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '666042'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HERP1G'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HERP1G';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HERP2G', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '666067'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HERP2G'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HERP2G';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HIVEIA', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660063'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HIVEIA'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HIVEIA';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TEST-HIV', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunoanálisis cualitativo'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660063A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TEST-HIV'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunoanálisis cualitativo')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TEST-HIV';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HOMA', 'listo'::estado_paridad_enum, est.id, NULL, 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '666708'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HOMA'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = NULL
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HOMA';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HOMOC', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '666452'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HOMOC'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HOMOC';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HTLV I', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '666537'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HTLV I'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HTLV I';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'HUD', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Aglutinación en placa'), 2, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660494'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HUD'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 2,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Aglutinación en placa')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'HUD';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'IGA', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660537'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'IGA'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'IGA';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'IGAS', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmundifusión radial'), 5, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '666589'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'IGAS'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 5,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmundifusión radial')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'IGAS';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'IGE', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Turbidimetría'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660539'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'IGE'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Turbidimetría')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'IGE';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'IGG', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660540'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'IGG'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'IGG';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'IGM', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660541'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'IGM'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'IGM';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'INS', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660543'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'INS'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'INS';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'INSPP', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660543A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'INSPP'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'INSPP';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'INSPP120', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660543E'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'INSPP120'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'INSPP120';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'INSPP180', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660543H'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'INSPP180'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'INSPP180';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'INS PP30', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660543A2'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'INS PP30'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'INS PP30';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'INS PP60', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660543B'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'INS PP60'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'INS PP60';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'INS PP90', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660543C'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'INS PP90'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'INS PP90';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'I/OA', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Ión selectivo'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660547A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'I/OA'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Ión selectivo')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'I/OA';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'I', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Ión selectivo'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660546'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'I'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Ión selectivo')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'I';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'IOO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Ión selectivo'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660547'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'IOO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Ión selectivo')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'IOO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'KPTT', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Coagulométrico automatizado'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660887'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'KPTT'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Coagulométrico automatizado')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'KPTT';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CORRKPTT', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Coagulométrico automatizado'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '663994'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CORRKPTT'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Coagulométrico automatizado')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CORRKPTT';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'LDH', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Cinético UV a 37ªC (IFCC)'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660597'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'LDH'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Cinético UV a 37ªC (IFCC)')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'LDH';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'LAZO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Rumpel-Leede'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660603'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'LAZO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Rumpel-Leede')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'LAZO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'LEUCMF', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Microscopía óptica'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '5291'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'LEUCMF'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Microscopía óptica')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'LEUCMF';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'LH', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660612'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'LH'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'LH';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'LIP', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático colorimétrico'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660313'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'LIP'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático colorimétrico')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'LIP';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'LIPO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimétrico'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '667187'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'LIPO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimétrico')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'LIPO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'L.C.R.', 'listo'::estado_paridad_enum, est.id, NULL, 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660619'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'L.C.R.'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = NULL
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'L.C.R.';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'PUNCION', 'listo'::estado_paridad_enum, est.id, NULL, 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660619A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PUNCION'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = NULL
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PUNCION';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'MGS', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660653'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'MGS'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'MGS';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'MGO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660654'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'MGO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'MGO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'PPD', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'SCLAVO-TEST-PPD: 2 UI/0.1 ml'), 4, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660656'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PPD'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 4,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'SCLAVO-TEST-PPD: 2 UI/0.1 ml')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PPD';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'MDRD-4', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Calculado'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '666711'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'MDRD-4'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Calculado')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'MDRD-4';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'META', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Electrométrico'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '667409'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'META'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Electrométrico')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'META';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'METO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '667486'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'METO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'METO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'MICRO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661130'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'MICRO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'MICRO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'A/C', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría, cinético'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661130A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'A/C'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría, cinético')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'A/C';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'MOC', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Microscopía óptica'), 4, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660668'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'MOC'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 4,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Microscopía óptica')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'MOC';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'MON', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Aglutinación en placa'), 2, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660669'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'MON'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 2,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Aglutinación en placa')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'MON';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'NOTA', 'listo'::estado_paridad_enum, est.id, NULL, 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = 'NOTA'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'NOTA'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = NULL
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'NOTA';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'O', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Tira react., microscop. optica'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660711'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'O'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Tira react., microscop. optica')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'O';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'OSMO/O', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Osmolalidad por cálculo'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '667926'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'OSMO/O'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Osmolalidad por cálculo')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'OSMO/O';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'PTH', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660739'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PTH'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PTH';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'PTH-B', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660739A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PTH-B'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PTH-B';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'PTH-M', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660739B'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PTH-M'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PTH-M';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'PTH-PE', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660739C'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PTH-PE'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PTH-PE';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'ANTI-CCP', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '668284'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ANTI-CCP'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ANTI-CCP';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'BNP', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '663094'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'BNP'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'BNP';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'PH LIQ', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Electrométrico'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660005B'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PH LIQ'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Electrométrico')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PH LIQ';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'PQ', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Recuento automatizado'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660746'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PQ'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Recuento automatizado')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PQ';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'PROCALCI', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '668563'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PROCALCI'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PROCALCI';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'PRG', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660758'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PRG'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PRG';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'PRL', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660759'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PRL'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PRL';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'POOL PRL', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660759D'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'POOL PRL'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'POOL PRL';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'PCR', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660761'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PCR'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetría')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PCR';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'PC', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Cromogénico cinético a  405 nm'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '668614'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PC'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Cromogénico cinético a  405 nm')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PC';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'A/G', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Colorimetría'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660764A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'A/G'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Colorimetría')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'A/G';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'PT', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Biuret'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660763'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PT'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Biuret')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PT';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'PTO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Turbidimetría'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660767'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PTO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Turbidimetría')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PTO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'PRO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Turbidimetría'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660767A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PRO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Turbidimetría')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'PRO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'FIET', 'listo'::estado_paridad_enum, est.id, NULL, 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '000003'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'FIET'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = NULL
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'FIET';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'REC TSH', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '668802'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'REC TSH'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'REC TSH';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'RPCA', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Coagulométrico'), 2, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '668828'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'RPCA'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 2,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Coagulométrico')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'RPCA';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'RET', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Recuento automatizado'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660818'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'RET'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Recuento automatizado')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'RET';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'RR', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Aglutinación directa'), 2, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660820'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'RR'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 2,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Aglutinación directa')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'RR';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'AARIGG', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661145'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AARIGG'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AARIGG';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'AARIGM', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661150'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AARIGM'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AARIGM';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'SOMF', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunocromatografía'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '5290'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'SOMF'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunocromatografía')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'SOMF';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TC', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Lee-Whyte y Duke'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660169'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TC'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Lee-Whyte y Duke')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TC';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'SUB', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661175'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'SUB'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'SUB';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'DAP', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunocromatrografía'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661170'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'DAP'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunocromatrografía')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'DAP';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'GRAVI', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunocromatrografía'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661170A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GRAVI'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunocromatrografía')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'GRAVI';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TACRO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '665298'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TACRO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TACRO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TES', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660863'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TES'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TES';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TES-BIO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Formula de Vermeulen'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '661185'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TES-BIO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Formula de Vermeulen')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TES-BIO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TESL', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Formula de Vermeulen'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '669375'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TESL'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Formula de Vermeulen')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TESL';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TP', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Coagulométrico automatizado'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660771'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TP'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Coagulométrico automatizado')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TP';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TT', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Coagulométrico automatizado'), 2, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660880'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TT'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 2,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Coagulométrico automatizado')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TT';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TIROGLO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '669443'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TIROGLO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TIROGLO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'ANTI-TG', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '669460'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ANTI-TG'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'ANTI-TG';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TSH', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660865'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TSH'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TSH';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TSH30', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660865E'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TSH30'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TSH30';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TSH60', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660865G'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TSH60'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TSH60';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'T4L', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660867'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'T4L'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'T4L';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'T4', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660866'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'T4'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'T4';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TDM', 'listo'::estado_paridad_enum, est.id, NULL, NULL, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = 'TDM'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TDM'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = NULL,
  estado = 'listo'::estado_registro_enum,
  id_metodo = NULL
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TDM';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TOXIGG', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '1057A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TOXIGG'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TOXIGG';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TOXIGM', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '1056A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TOXIGM'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TOXIGM';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CORRTP', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Coagulométrico automatizado'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '663996'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CORRTP'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Coagulométrico automatizado')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CORRTP';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TGO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Cinético U.V. a 37·C'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660873'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TGO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Cinético U.V. a 37·C')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TGO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TGP', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Cinético U.V. a 37·C'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660874'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TGP'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Cinético U.V. a 37·C')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TGP';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TRA', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetria'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660875'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TRA'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Inmunoturbidimetria')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TRA';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'SAT', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Ferene'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660875A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'SAT'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Ferene')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'SAT';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'SYPHILIS', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660933'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'SYPHILIS'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'SYPHILIS';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TGL', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático GPO-PAP'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660876'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TGL'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático GPO-PAP')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TGL';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'T3LIBRE', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '669661'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'T3LIBRE'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'T3LIBRE';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'T3', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660878'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'T3'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'T3';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'TPA', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '669735'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TPA'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'TPA';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'UREA', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático UV'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '69759'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'UREA'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático UV')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'UREA';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'U/OA', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático UV'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660902B'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'U/OA'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático UV')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'U/OA';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'UO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático UV'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660902A'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'UO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático UV')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'UO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'U', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático UV'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660902'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'U'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático UV')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'U';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'UES', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático UV'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660902P'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'UES'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático UV')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'UES';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'CLU', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enzimático UV'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660901'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CLU'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enzimático UV')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'CLU';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'AU', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enz.URICASA-PAP'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660904'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AU'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enz.URICASA-PAP')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AU';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'AUO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Enz.URICASA-PAP'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660905'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AUO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Enz.URICASA-PAP')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'AUO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'VD/LCR', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Floculación'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '1229'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'VD/LCR'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Floculación')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'VD/LCR';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'VD', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Floculación'), 2, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660934'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'VD'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 2,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Floculación')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'VD';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'VANCO', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '669793'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'VANCO'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'VANCO';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'VIT B12', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660938'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'VIT B12'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'VIT B12';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'VIT-D3', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'CMIA'), 1, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '669913'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'VIT-D3'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 1,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'CMIA')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'VIT-D3';

INSERT INTO public.estudio_colega (nemonico_datatech, paridad_datatech_hexalis, id_estudio, id_metodo, dias_demora, estado, revisor, colega_id)
SELECT 'WID', 'listo'::estado_paridad_enum, est.id, (SELECT id FROM public.metodo WHERE nombre = 'Aglutinación en placa'), 2, 'listo'::estado_registro_enum, 'Laboratorio SBLab', 49
FROM public.estudio est
WHERE est.codigo_hexalis = '660953'
  AND NOT EXISTS (
    SELECT 1 FROM public.estudio_colega ec
    WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'WID'
  );

UPDATE public.estudio_colega ec SET
  paridad_datatech_hexalis = 'listo'::estado_paridad_enum,
  dias_demora = 2,
  estado = 'listo'::estado_registro_enum,
  id_metodo = (SELECT id FROM public.metodo WHERE nombre = 'Aglutinación en placa')
WHERE ec.colega_id = 49 AND ec.nemonico_datatech = 'WID';

COMMIT;
