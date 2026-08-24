import pandas as pd
from sqlalchemy import create_engine, text

# Conexión a la base de datos
DATABASE_URL = "postgresql://postgres:postgres@localhost:5432/britlab"

engine = create_engine(DATABASE_URL)

file_path = "estudios.xlsx"
xls = pd.ExcelFile(file_path)

# Tu diccionario de mapeo
mapeo_hojas_derivantes = {
    '(A)': ('DEV-A', 'Laboratorio IICTLABS / Genética'),
    '(B)': ('DEV-LABMED', 'Laboratorio LABMEDICINA'),
    '(C)': ('DEV-TURNER', 'Laboratorio TURNER'),
    '(D)': ('DEV-SEMIR', 'Laboratorio SEMIR'),
    '(E)': ('DEV-CIBIC', 'Laboratorio CIBIC'),
    '(F)': ('DEV-IBC', 'Instituto Bioquímico Clínico (IBC)'),
    '(G)': ('DEV-G', 'Derivaciones Externas G'),
    '(H)': ('DEV-H', 'Servicio de Hemoterapia Externalizado'),
    '(I)': ('DEV-I', 'Laboratorio Infectología Especial'),
    '(K)': ('DEV-K', 'Laboratorio Citogenética'),
    '(L)': ('DEV-L', 'Laboratorio Coagulación Especial'),
    'FBA': ('DEV-FBA', 'Fundación Bioquímica Argentina (FBA)'),
    '(M)': ('DEV-M', 'Biología Molecular Especialized'),
    '(J)': ('DEV-J', 'Micología Especial')
}

records_estudios_update = []
records_permitidos = []

for sheet_name in xls.sheet_names:
    clean_sheet = sheet_name.strip()
    
    # Verificar si la hoja está en nuestro mapeo
    if clean_sheet not in mapeo_hojas_derivantes:
        continue
    
    codigo_derivante_db, nombre_derivante = mapeo_hojas_derivantes[clean_sheet]

    df_raw = pd.read_excel(xls, sheet_name=sheet_name, header=None)
    
    # Detección dinámica de la fila de encabezados
    header_idx = None
    for idx, row in df_raw.iterrows():
        row_str = " ".join([str(val).upper() for val in row.values if pd.notna(val)])
        if "NEMONICO" in row_str or ("HEXALIS" in row_str and "ESTUDIO" in row_str):
            header_idx = idx
            break
            
    if header_idx is None:
        continue

    df = pd.read_excel(xls, sheet_name=sheet_name, header=header_idx)
    df.columns = [str(c).strip().upper() for c in df.columns]

    # Detección de columnas
    col_hexalis = next((c for c in df.columns if 'HEXALIS' in c), None)
    col_nemonico = next((c for c in df.columns if 'NEMONICO' in c or 'NEMÓNICO' in c), None)
    col_estado = next((c for c in df.columns if 'PARIDAD' in c or 'ESTADO' in c), None)
    col_codigo_propio = next((c for c in df.columns if 'INTERNO' in c or 'TURNER' in c or 'LABMED' in c or 'SEMIR' in c or 'CIBIC' in c or 'FBA' in c), None)

    if not col_hexalis:
        continue

    for _, row in df.iterrows():
        raw_hexalis = str(row[col_hexalis]).strip() if pd.notna(row[col_hexalis]) else None
        
        # Ignorar vacíos o textos del encabezado
        if not raw_hexalis or raw_hexalis.upper() in ['NAN', 'NONE', 'CODIGO HEXALIS']:
            continue

        codigo_hexalis = raw_hexalis.upper()
        nemonico = str(row[col_nemonico]).strip() if col_nemonico and pd.notna(row[col_nemonico]) else None
        estado_paridad = str(row[col_estado]).strip() if col_estado and pd.notna(row[col_estado]) else 'NO APLICA'
        
        raw_codigo_propio = str(row[col_codigo_propio]).strip() if col_codigo_propio and pd.notna(row[col_codigo_propio]) else None
        codigo_propio = raw_codigo_propio if raw_codigo_propio and raw_codigo_propio.upper() != 'NAN' else None

        records_estudios_update.append({
            'codigo_hexalis': codigo_hexalis,
            'nemonico_datatech': nemonico,
            'estado_paridad': estado_paridad
        })

        records_permitidos.append({
            'codigo_derivante': codigo_derivante_db,
            'codigo_hexalis': codigo_hexalis,
            'codigo_estudio_propio': codigo_propio
        })

# --- CONSULTAS DE BASE DE DATOS ---

query_update_estudios = text("""
    UPDATE public.estudios
    SET 
        nemonico_datatech = COALESCE(:nemonico_datatech, nemonico_datatech),
        estado_paridad = :estado_paridad,
        fecha_actualizacion = CURRENT_TIMESTAMP
    WHERE UPPER(codigo_hexalis) = UPPER(:codigo_hexalis)
    RETURNING id, codigo_hexalis, nemonico_datatech, estado_paridad;
""")

query_upsert_permitidos = text("""
    INSERT INTO public.derivante_estudios_permitidos (derivante_id, estudio_id, codigo_estudio_propio, permitido)
    SELECT d.id, e.id, :codigo_estudio_propio, true
    FROM public.derivantes d
    JOIN public.estudios e ON UPPER(e.codigo_hexalis) = UPPER(:codigo_hexalis)
    WHERE d.codigo_externo = :codigo_derivante
    ON CONFLICT (derivante_id, estudio_id) 
    DO UPDATE SET 
        codigo_estudio_propio = EXCLUDED.codigo_estudio_propio,
        permitido = true,
        fecha_asignacion = CURRENT_TIMESTAMP
    RETURNING id, derivante_id, estudio_id, codigo_estudio_propio, (xmax = 0) AS es_insercion;
""")

estudios_actualizados = 0
permitidos_insertados = 0
permitidos_actualizados = 0
omitidos = []

with engine.begin() as conn:
    print("=== PROCESANDO ACTUALIZACIÓN E INSERCIÓN ===")
    
    # 1. Actualización general en 'estudios'
    for record in records_estudios_update:
        res = conn.execute(query_update_estudios, record).fetchone()
        if res:
            estudios_actualizados += 1

    # 2. Asignación de permisos en 'derivante_estudios_permitidos'
    for record in records_permitidos:
        res = conn.execute(query_upsert_permitidos, record).fetchone()
        if res:
            if res.es_insercion:
                permitidos_insertados += 1
                accion = "INSERTADO"
            else:
                permitidos_actualizados += 1
                accion = "ACTUALIZADO"
            print(f"[{accion}] Derivante: {record['codigo_derivante']} | Hexalis: {record['codigo_hexalis']} | Cod. Propio: {res.codigo_estudio_propio}")
        else:
            omitidos.append(f"Derivante: {record['codigo_derivante']} | Hexalis: {record['codigo_hexalis']}")
            print(f"❌ [OMITIDO] Derivante: {record['codigo_derivante']} | Hexalis: {record['codigo_hexalis']} (Estudio Hexalis no existe en la BD)")

# --- RESUMEN FINAL ---
print("\n" + "="*60)
print("📊 RESUMEN FINAL DEL PASAJE DE DATOS")
print("="*60)
print(f" Total estudios actualizados en 'estudios': {estudios_actualizados}")
print(f" Total permisos INSERTADOS en 'derivante_estudios_permitidos': {permitidos_insertados}")
print(f" Total permisos ACTUALIZADOS en 'derivante_estudios_permitidos': {permitidos_actualizados}")
print(f" Total OMITIDOS (Estudio Hexalis no cargado previamente): {len(omitidos)}")
print("="*60)