import pandas as pd
import numpy as np
from datetime import datetime
from sqlalchemy import create_engine, text

# 1. Configuración de conexión a PostgreSQL
DB_URL = "postgresql://postgres:postgres@localhost:5432/britlab"
engine = create_engine(DB_URL)

FILE_PATH = "estudios.xlsx"

def cargar_excel_a_postgres():
    print("⏳ Leyendo archivo Excel...")
    
    # ----------------------------------------------------
    # A. Cargar datos de la Hoja General
    # ----------------------------------------------------
    df_general = pd.read_excel(FILE_PATH, sheet_name='GENERAL')
    df_general['CODIGO HEXALIS'] = df_general['CODIGO HEXALIS'].astype(str).str.strip()
    
    # ----------------------------------------------------
    # B. Cargar Mapeo de Secciones desde la Hoja (O)
    # ----------------------------------------------------
    df_o = pd.read_excel(FILE_PATH, sheet_name='(O)', header=None)
    secciones_map = {}
    for _, row in df_o.iterrows():
        code = str(row[0]).strip()
        sec = str(row[2]).strip() if pd.notna(row[2]) else None
        rango = str(row[5]).strip() if pd.notna(row[5]) else None
        if code and code != 'nan' and sec and sec != 'nan':
            # Corregir pequeños errores ortográficos del Excel si los hay
            if sec == 'Endocrinlogía':
                sec = 'Endocrinología'
            secciones_map[code] = {'seccion': sec, 'rango': rango}

    # ----------------------------------------------------
    # C. Cargar Nemónicos y Status desde las Hojas Por Letra
    # ----------------------------------------------------
    datatech_info = {}
    sheets_letras = ['B', '(A)', '(C)', '(B)', '(D)', '(E)', '(F)', '(G)', '(H)', '(I)', '(K)', '(L)', 'FBA', '(M)', '(J)']
    
    for s in sheets_letras:
        try:
            df_temp = pd.read_excel(FILE_PATH, sheet_name=s)
            header_idx = None
            for i, r in df_temp.iterrows():
                if 'CODIGO HEXALIS' in r.values:
                    header_idx = i
                    break
            if header_idx is not None:
                df_data = pd.read_excel(FILE_PATH, sheet_name=s, skiprows=header_idx)
                for _, row in df_data.iterrows():
                    code = str(row.get('CODIGO HEXALIS', '')).strip()
                    if code and code != 'nan' and code != 'CODIGO HEXALIS':
                        nemonico = str(row.get('NEMONICO DATATECH', '')).strip()
                        paridad = str(row.get('PARIDAD DATATECH- HEXALIS', '')).strip()
                        datatech_info[code] = {
                            'nemonico': nemonico if nemonico != 'nan' else None,
                            'paridad': paridad if paridad != 'nan' else 'NO APLICA'
                        }
        except Exception:
            pass

    # ----------------------------------------------------
    # D. Insertar Tablas Maestras (Normalización)
    # ----------------------------------------------------
    print("📦 Poblando Tablas Maestras...")
    with engine.begin() as conn:
        # 1. Secciones
        unique_secciones = set(v['seccion'] for v in secciones_map.values() if v['seccion'])
        for sec in unique_secciones:
            rango = next((v['rango'] for v in secciones_map.values() if v['seccion'] == sec), None)
            conn.execute(
                text("INSERT INTO secciones_laboratorio (nombre, codigo_rango) VALUES (:nombre, :rango) ON CONFLICT (nombre) DO NOTHING;"),
                {"nombre": sec, "rango": rango}
            )
            
        # 2. Métodos
        unique_metodos = df_general['METODO'].dropna().astype(str).str.strip().unique()
        for met in unique_metodos:
            if met:
                conn.execute(
                    text("INSERT INTO metodos_analisis (nombre) VALUES (:nombre) ON CONFLICT (nombre) DO NOTHING;"),
                    {"nombre": met}
                )

        # 3. Tipos de Muestra
        unique_muestras = df_general['MUESTRA'].dropna().astype(str).str.strip().unique()
        for mue in unique_muestras:
            if mue:
                conn.execute(
                    text("INSERT INTO tipos_muestra (descripcion) VALUES (:descripcion) ON CONFLICT (descripcion) DO NOTHING;"),
                    {"descripcion": mue}
                )

    # ----------------------------------------------------
    # E. Obtener Mapas de IDs Generados
    # ----------------------------------------------------
    seccion_ids = pd.read_sql("SELECT id, nombre FROM secciones_laboratorio;", engine).set_index('nombre')['id'].to_dict()
    metodo_ids = pd.read_sql("SELECT id, nombre FROM metodos_analisis;", engine).set_index('nombre')['id'].to_dict()
    muestra_ids = pd.read_sql("SELECT id, descripcion FROM tipos_muestra;", engine).set_index('descripcion')['id'].to_dict()

    # ----------------------------------------------------
    # F. Poblar Tabla Principal de Estudios
    # ----------------------------------------------------
    print("🚀 Cargando Listado de Estudios...")
    estudios_cargados = 0

    with engine.begin() as conn:
        for _, row in df_general.iterrows():
            code = str(row['CODIGO HEXALIS']).strip()
            nombre = str(row['ESTUDIO']).strip() if pd.notna(row['ESTUDIO']) else "SIN NOMBRE"
            metodo = str(row['METODO']).strip() if pd.notna(row['METODO']) else None
            muestra = str(row['MUESTRA']).strip() if pd.notna(row['MUESTRA']) else None
            
            preanalitico = str(row['RESULTADO PREANALITICO']).strip() if pd.notna(row['RESULTADO PREANALITICO']) else None
            indicaciones = str(row['INDICACIONES']).strip() if pd.notna(row['INDICACIONES']) else None
            val_ref = str(row['VALORES DE REFERENCIA']).strip() if pd.notna(row['VALORES DE REFERENCIA']) else None
            
            try:
                demora = float(row['DEMORA (DIAS HABILES)']) if pd.notna(row['DEMORA (DIAS HABILES)']) else None
            except:
                demora = None

            # Modelo de informe icono/check
            req_informe = pd.notna(row['MODELO DE INFORME']) and str(row['MODELO DE INFORME']).strip() != ''

            # Versión / Fecha
            ver_fecha = None
            if pd.notna(row['VERSION']):
                if isinstance(row['VERSION'], datetime):
                    ver_fecha = row['VERSION'].date()
                else:
                    try:
                        ver_fecha = pd.to_datetime(row['VERSION']).date()
                    except:
                        ver_fecha = None

            # Obtener datos complementarios de los mapas
            sec_nombre = secciones_map.get(code, {}).get('seccion')
            sec_id = seccion_ids.get(sec_nombre)
            met_id = metodo_ids.get(metodo)
            mue_id = muestra_ids.get(muestra)
            
            nemonico = datatech_info.get(code, {}).get('nemonico')
            paridad = datatech_info.get(code, {}).get('paridad', 'NO APLICA')

            # Query de inserción
            insert_query = text("""
                INSERT INTO estudios (
                    codigo_hexalis, nemonico_datatech, nombre, seccion_id, metodo_id, muestra_id,
                    resultado_preanalitico, indicaciones, valores_referencia, demora_dias_habiles,
                    requiere_modelo_informe, estado_paridad, version_fecha
                ) VALUES (
                    :codigo_hexalis, :nemonico_datatech, :nombre, :seccion_id, :metodo_id, :muestra_id,
                    :resultado_preanalitico, :indicaciones, :valores_referencia, :demora_dias_habiles,
                    :requiere_modelo_informe, :estado_paridad, :version_fecha
                )
                ON CONFLICT (codigo_hexalis) DO UPDATE SET
                    nombre = EXCLUDED.nombre,
                    seccion_id = EXCLUDED.seccion_id,
                    metodo_id = EXCLUDED.metodo_id,
                    muestra_id = EXCLUDED.muestra_id,
                    indicaciones = EXCLUDED.indicaciones,
                    valores_referencia = EXCLUDED.valores_referencia,
                    fecha_actualizacion = CURRENT_TIMESTAMP;
            """)

            conn.execute(insert_query, {
                "codigo_hexalis": code,
                "nemonico_datatech": nemonico,
                "nombre": nombre,
                "seccion_id": sec_id,
                "metodo_id": met_id,
                "muestra_id": mue_id,
                "resultado_preanalitico": preanalitico,
                "indicaciones": indicaciones,
                "valores_referencia": val_ref,
                "demora_dias_habiles": demora,
                "requiere_modelo_informe": req_informe,
                "estado_paridad": paridad,
                "version_fecha": ver_fecha
            })
            estudios_cargados += 1

    print(f"✅ Se cargaron exitosamente {estudios_cargados} estudios en la base de datos.")

if __name__ == "__main__":
    cargar_excel_a_postgres()
