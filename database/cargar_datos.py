import pandas as pd
from sqlalchemy import create_engine, text

# ---------------------------------------------------------
# 1. CONFIGURACIÓN Y CONEXIÓN
# ---------------------------------------------------------
DB_URL = "postgresql://postgres:postgres@localhost:5432/britlab"
EXCEL_FILE = "estudios.xlsx"

engine = create_engine(DB_URL)

def ejecutar_migracion_completa():
    xls = pd.ExcelFile(EXCEL_FILE)
    hojas_omitir = ['GENERAL', 'Hoja 1', '(O)']
    hojas_derivantes = [s for s in xls.sheet_names if s not in hojas_omitir]

    with engine.begin() as conn:
        print("=== STEP 1: Cargar / Actualizar Lista de Derivantes desde Pestañas ===")
        
        # Mapeo de nombre de pestaña a Nombre/Razón Social del Derivante
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

        # 1. Crear los derivantes en la base de datos
        for sheet_name, (cod_ext, razon_social) in mapeo_hojas_derivantes.items():
            conn.execute(
                text("""
                    INSERT INTO derivantes (codigo_externo, razon_social, activo)
                    VALUES (:cod, :nombre, TRUE)
                    ON CONFLICT (codigo_externo) DO UPDATE 
                    SET razon_social = EXCLUDED.razon_social;
                """),
                {"cod": cod_ext, "nombre": razon_social}
            )

        # Mapear IDs de derivantes por su código externo
        res_devs = conn.execute(text("SELECT id, codigo_externo FROM derivantes;")).fetchall()
        mapa_derivantes = {row[1]: row[0] for row in res_devs}

        print("\n=== STEP 2: Asignar Estudios Autorizados a cada Derivante ===")

        total_relaciones = 0

        for sheet_name in hojas_derivantes:
            if sheet_name not in mapeo_hojas_derivantes:
                continue

            cod_externo_derivante = mapeo_hojas_derivantes[sheet_name][0]
            derivante_id = mapa_derivantes.get(cod_externo_derivante)

            df_sheet = pd.read_excel(EXCEL_FILE, sheet_name=sheet_name)

            # Buscar la fila donde está la cabecera real (donde dice 'CODIGO HEXALIS')
            header_row_idx = None
            for idx, row in df_sheet.iterrows():
                if 'CODIGO HEXALIS' in row.values:
                    header_row_idx = idx
                    break

            if header_row_idx is None:
                continue

            # Reestructurar la hoja usando la fila correcta como encabezado
            df_data = pd.read_excel(EXCEL_FILE, sheet_name=sheet_name, skiprows=header_row_idx + 1)
            raw_cols = df_sheet.iloc[header_row_idx].values
            df_data.columns = [str(c).strip() for c in raw_cols]

            # Detectar si la pestaña tiene alguna columna de código propia (ej. CODIGO LABMED)
            col_codigo_propio = None
            for col in df_data.columns:
                if 'CODIGO' in col and col != 'CODIGO HEXALIS':
                    col_codigo_propio = col
                    break

            # Iterar registros de la pestaña
            for _, row in df_data.iterrows():
                cod_hexalis = str(row.get('CODIGO HEXALIS', '')).strip()
                
                # Ignorar filas vacías o inválidas
                if not cod_hexalis or cod_hexalis.lower() == 'nan':
                    continue

                # Obtener el código interno que le da el derivante a ese estudio (si existe)
                cod_propio = None
                if col_codigo_propio and pd.notna(row.get(col_codigo_propio)):
                    cod_propio = str(row.get(col_codigo_propio)).strip()

                # Obtener el ID del estudio en PostgreSQL a partir de su CODIGO HEXALIS
                res_est = conn.execute(
                    text("SELECT id FROM estudios WHERE codigo_hexalis = :cod;"),
                    {"cod": cod_hexalis}
                ).fetchone()

                if res_est:
                    estudio_id = res_est[0]

                    # Insertar o actualizar la relación M:N
                    conn.execute(
                        text("""
                            INSERT INTO derivante_estudios_permitidos 
                                (derivante_id, estudio_id, permitido, codigo_estudio_propio)
                            VALUES 
                                (:d_id, :e_id, TRUE, :cod_propio)
                            ON CONFLICT (derivante_id, estudio_id) 
                            DO UPDATE SET 
                                permitido = TRUE,
                                codigo_estudio_propio = EXCLUDED.codigo_estudio_propio;
                        """),
                        {
                            "d_id": derivante_id,
                            "e_id": estudio_id,
                            "cod_propio": cod_propio
                        }
                    )
                    total_relaciones += 1

            print(f"-> Procesada pestaña '{sheet_name}' para {mapeo_hojas_derivantes[sheet_name][1]}")

        print(f"\n¡Éxito! Se vincularon {total_relaciones} relaciones de estudios permitidos por derivante.")

if __name__ == "__main__":
    ejecutar_migracion_completa()