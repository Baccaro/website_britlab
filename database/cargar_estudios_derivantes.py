"""
ETL: estudios.xlsx -> base de datos britlab_test (esquema definido en britlab_test.sql)

Estructura del Excel:
  - Hoja 'GENERAL'  : catálogo maestro de estudios (codigo_hexalis + nombre)      -> tabla `estudio`
  - Hoja 'ORDEN'    : sector/posición/rango de cada estudio en el informe         -> tablas `sector` y
                      `valor_estudio_sector`
  - Resto de hojas  : una por laboratorio derivante (incluye 'BRITLAB', el propio -> tablas `derivante` y
                      laboratorio local, y 'MICROBIOLOGIA')                         `estudio_derivante`

Regla para el campo `indicaciones` de `estudio_derivante` (pedido explícito del usuario):
  1) Si la celda de la columna "MODELO DE INFORME" tiene un hipervínculo, se usa esa URL.
  2) Si no tiene hipervínculo, se usa el texto de la nota/comentario de Excel adjunto a la
     celda de la columna "INDICACIONES" de esa misma fila (el valor visible de esa columna
     suele estar vacío o ser "SI"; la información real vive en el comentario).
  3) Si no hay ni hipervínculo ni nota, `indicaciones` queda NULL.

Uso:
    python cargar_estudios_derivantes.py [--file estudios.xlsx] [--db-url postgresql://...] [--dry-run]
"""

import argparse
import re
import sys

import openpyxl
from sqlalchemy import create_engine, text

DEFAULT_DB_URL = "postgresql://postgres:postgres@localhost:5432/britlab_test"
DEFAULT_FILE = "estudios.xlsx"

HOJAS_NO_DERIVANTE = {"GENERAL", "ORDEN"}

# Excel (mayúsculas) -> valor del enum estado_registro_enum (listo, pendiente, revisar, verificado)
STATUS_MAP = {
    "LISTO": "listo",
    "PENDIENTE": "pendiente",
    "REVISAR": "revisar",
    "VERIFICADO": "verificado",
}

# Excel (mayúsculas) -> valor del enum estado_paridad_enum (listo, pendiente, revisar, inactivo, discontinuado)
PARIDAD_MAP = {
    "LISTO": "listo",
    "PENDIENTE": "pendiente",
    "REVISAR": "revisar",
    "INACTIVO": "inactivo",
    "DISCONTINUADO": "discontinuado",
    # 'NO APLICA' no tiene equivalente en el enum -> se omite y queda el default ('pendiente')
}

REVISOR_DEFAULT = "SIN ASIGNAR"


def norm(v):
    if v is None:
        return None
    s = str(v).strip()
    return s if s else None


def clean_codigo(v):
    """Normaliza CODIGO HEXALIS.

    En varias hojas el código aparece como número flotante ("668580.0") por estar
    tipeado como número en Excel, y algunas filas de estudios discontinuados/inactivos
    llevan un "-" delante ("-668580.0", "- 661135G") a modo de marca visual del
    laboratorio. Ese signo no forma parte del código real (el mismo código existe sin
    el signo en la hoja GENERAL), así que se quita.
    """
    if v is None:
        return None
    if isinstance(v, (int, float)):
        v = abs(v)
        if isinstance(v, float) and v.is_integer():
            v = int(v)
        s = str(v)
    else:
        s = str(v).strip()
        if s.startswith("-"):
            s = s[1:].strip()
    s = s.strip()
    return s.upper() if s else None


def clean_comment(text_):
    if not text_:
        return None
    # Excel agrega un separador "======" (y a veces el autor) al final del comentario.
    cleaned = re.sub(r"\n?=+\s*$", "", text_.strip()).strip()
    return cleaned or None


def find_header_row(ws, max_scan=20):
    for r in range(1, max_scan + 1):
        for c in range(1, ws.max_column + 1):
            v = ws.cell(row=r, column=c).value
            if isinstance(v, str) and "CODIGO HEXALIS" in v.upper():
                return r
    return None


def build_colmap(ws, header_row):
    colmap = {}
    for c in range(1, ws.max_column + 1):
        v = ws.cell(row=header_row, column=c).value
        if isinstance(v, str) and v.strip():
            colmap[v.strip().upper()] = c
    return colmap


def resolve_col(colmap, *, exact=None, startswith=None, contains=None, exclude=()):
    if exact:
        for name in exact:
            if name in colmap:
                return colmap[name]
    for header, idx in colmap.items():
        if any(ex in header for ex in exclude):
            continue
        if startswith and header.startswith(startswith):
            return idx
        if contains and contains in header:
            return idx
    return None


def get_indicaciones(ws, row, col_modelo, col_indic):
    if col_modelo:
        cell = ws.cell(row=row, column=col_modelo)
        if cell.hyperlink and cell.hyperlink.target:
            return cell.hyperlink.target.strip()
    if col_indic:
        cell = ws.cell(row=row, column=col_indic)
        if cell.comment:
            texto = clean_comment(cell.comment.text)
            if texto:
                return texto
    return None


def parse_int(v, default=0):
    if v is None:
        return default
    try:
        return int(round(float(v)))
    except (TypeError, ValueError):
        return default


class MasterCache:
    """Cache + get-or-create para tablas maestras simples (id, nombre[, ...])."""

    def __init__(self, conn, table, name_col="nombre"):
        self.conn = conn
        self.table = table
        self.name_col = name_col
        self.cache = {}
        rows = conn.execute(text(f"SELECT id, {name_col} FROM public.{table}")).fetchall()
        for r in rows:
            self.cache[r[1]] = r[0]

    def get_or_create(self, nombre):
        nombre = norm(nombre)
        if nombre is None:
            return None
        if nombre in self.cache:
            return self.cache[nombre]
        row = self.conn.execute(
            text(
                f"INSERT INTO public.{self.table} ({self.name_col}) VALUES (:v) "
                f"ON CONFLICT ({self.name_col}) DO UPDATE SET {self.name_col} = EXCLUDED.{self.name_col} "
                f"RETURNING id"
            ),
            {"v": nombre},
        ).fetchone()
        self.cache[nombre] = row[0]
        return row[0]


def cargar_general(conn, wb, warnings):
    ws = wb["GENERAL"]
    header_row = find_header_row(ws)
    colmap = build_colmap(ws, header_row)
    col_cod = resolve_col(colmap, exact=["CODIGO HEXALIS"])
    col_est = resolve_col(colmap, exact=["ESTUDIO", "ESTUDIOS", "ANALISIS"])

    estudio_cache = {}
    n = 0
    for r in range(header_row + 1, ws.max_row + 1):
        codigo = clean_codigo(ws.cell(row=r, column=col_cod).value)
        if not codigo:
            continue
        descripcion = norm(ws.cell(row=r, column=col_est).value) if col_est else None
        if not descripcion:
            # Filas basura (p.ej. fórmulas de totales al pie de la tabla) traen un
            # código sin nombre de estudio real: se descartan en vez de cargarlas.
            warnings.append(f"GENERAL fila {r}: código '{codigo}' sin nombre de estudio, se omite.")
            continue

        row = conn.execute(
            text(
                "INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES (:cod, :desc) "
                "ON CONFLICT (codigo_hexalis) DO UPDATE SET descripcion = EXCLUDED.descripcion "
                "RETURNING id"
            ),
            {"cod": codigo, "desc": descripcion},
        ).fetchone()
        estudio_cache[codigo] = row[0]
        n += 1
    print(f"[GENERAL] {n} estudios cargados/actualizados en 'estudio'.")
    return estudio_cache


def cargar_orden(conn, wb, estudio_cache, warnings):
    ws = wb["ORDEN"]
    sector_ids = {}  # nombre de sector -> id (tabla maestra 'sector')
    sector_cache = {}  # id_estudio -> id de 'valor_estudio_sector'
    n = 0
    omitidos = 0
    for r in range(1, ws.max_row + 1):
        codigo = clean_codigo(ws.cell(row=r, column=1).value)
        if not codigo:
            continue
        sector = norm(ws.cell(row=r, column=3).value)
        posicion = ws.cell(row=r, column=4).value
        rango = norm(ws.cell(row=r, column=6).value)

        id_estudio = estudio_cache.get(codigo)
        if id_estudio is None or sector is None or posicion is None:
            omitidos += 1
            continue

        id_sector = sector_ids.get(sector)
        if id_sector is None:
            row = conn.execute(
                text(
                    "INSERT INTO public.sector (nombre) VALUES (:nombre) "
                    "ON CONFLICT (nombre) DO UPDATE SET nombre = EXCLUDED.nombre RETURNING id"
                ),
                {"nombre": sector},
            ).fetchone()
            id_sector = row[0]
            sector_ids[sector] = id_sector

        row = conn.execute(
            text(
                """
                INSERT INTO public.valor_estudio_sector (id_estudio, id_sector, posicion_informe, rango)
                VALUES (:id_estudio, :id_sector, :posicion, :rango)
                ON CONFLICT (id_estudio, id_sector, posicion_informe)
                DO UPDATE SET rango = EXCLUDED.rango
                RETURNING id
                """
            ),
            {
                "id_estudio": id_estudio,
                "id_sector": id_sector,
                "posicion": parse_int(posicion),
                "rango": rango,
            },
        ).fetchone()
        sector_cache[id_estudio] = row[0]
        n += 1
    print(f"[ORDEN] {n} valores cargados en 'valor_estudio_sector' ({omitidos} filas omitidas por datos incompletos).")
    return sector_cache


def get_or_create_derivante(conn, cache, nombre):
    if nombre in cache:
        return cache[nombre]
    row = conn.execute(
        text("SELECT id FROM public.derivante WHERE descripcion = :d"), {"d": nombre}
    ).fetchone()
    if row is None:
        row = conn.execute(
            text("INSERT INTO public.derivante (descripcion) VALUES (:d) RETURNING id"), {"d": nombre}
        ).fetchone()
    cache[nombre] = row[0]
    return row[0]


def upsert_estudio_derivante(conn, data):
    existing = conn.execute(
        text(
            "SELECT id FROM public.estudio_derivante WHERE derivante_id = :derivante_id AND id_estudio = :id_estudio"
        ),
        data,
    ).fetchone()
    if existing:
        data["id"] = existing[0]
        conn.execute(
            text(
                """
                UPDATE public.estudio_derivante SET
                    nemonico_datatech = :nemonico_datatech,
                    id_metodo = :id_metodo,
                    id_preanalitico = :id_preanalitico,
                    id_muestra = :id_muestra,
                    id_sector_laboratorio = :id_sector_laboratorio,
                    indicaciones = :indicaciones,
                    valor_referencia = :valor_referencia,
                    dias_demora = :dias_demora,
                    codigo_laboratorio = :codigo_laboratorio,
                    revisor = :revisor,
                    observacion = :observacion,
                    updated_at = CURRENT_TIMESTAMP
                    {paridad_set}
                    {estado_set}
                WHERE id = :id
                """.format(
                    paridad_set=", paridad_datatech_hexalis = :paridad_datatech_hexalis" if data.get("paridad_datatech_hexalis") else "",
                    estado_set=", estado = :estado" if data.get("estado") else "",
                )
            ),
            data,
        )
        return "updated"

    cols = [
        "nemonico_datatech", "id_estudio", "id_metodo", "id_preanalitico", "id_muestra",
        "id_sector_laboratorio", "indicaciones", "valor_referencia", "dias_demora",
        "codigo_laboratorio", "revisor", "observacion", "derivante_id",
    ]
    if data.get("paridad_datatech_hexalis"):
        cols.append("paridad_datatech_hexalis")
    if data.get("estado"):
        cols.append("estado")
    placeholders = ", ".join(f":{c}" for c in cols)
    conn.execute(
        text(f"INSERT INTO public.estudio_derivante ({', '.join(cols)}) VALUES ({placeholders})"),
        data,
    )
    return "inserted"


def cargar_derivantes(conn, wb, estudio_cache, sector_cache, warnings, stats):
    metodo_cache = MasterCache(conn, "metodo", "nombre")
    muestra_cache = MasterCache(conn, "muestra", "nombre")
    preanalitico_cache = MasterCache(conn, "preanalitico", "nombre")
    derivante_cache = {}

    for sheet_name in wb.sheetnames:
        if sheet_name in HOJAS_NO_DERIVANTE:
            continue
        ws = wb[sheet_name]
        header_row = find_header_row(ws)
        if header_row is None:
            warnings.append(f"Hoja '{sheet_name}': no se encontró fila de encabezado, se omite.")
            continue

        colmap = build_colmap(ws, header_row)
        col_cod = resolve_col(colmap, exact=["CODIGO HEXALIS"])
        col_est = resolve_col(colmap, exact=["ESTUDIO", "ESTUDIOS", "ANALISIS"])
        col_nem = resolve_col(colmap, exact=["NEMONICO DATATECH"])
        col_paridad = resolve_col(colmap, startswith="PARIDAD")
        col_metodo = resolve_col(colmap, exact=["METODO"])
        col_preanalitico = resolve_col(colmap, exact=["RESULTADO PREANALITICO"])
        col_muestra = resolve_col(colmap, exact=["MUESTRA"])
        col_indic = resolve_col(colmap, startswith="INDICACIONES")
        col_valref = resolve_col(colmap, startswith="VALOR")
        col_demora = resolve_col(colmap, startswith="DEMORA")
        col_status = resolve_col(colmap, exact=["STATUS"])
        col_codprop = resolve_col(colmap, contains="CODIGO", exclude=["CODIGO HEXALIS"]) \
            or resolve_col(colmap, contains="SIGLA")
        col_modelo = resolve_col(colmap, exact=["MODELO DE INFORME"])
        col_reviso = resolve_col(colmap, exact=["REVISO"])
        col_obs = resolve_col(colmap, exact=["OBSERVACIONES"])

        derivante_id = get_or_create_derivante(conn, derivante_cache, sheet_name)

        n_ins = n_upd = 0
        for r in range(header_row + 1, ws.max_row + 1):
            codigo = clean_codigo(ws.cell(row=r, column=col_cod).value) if col_cod else None
            if not codigo:
                continue

            id_estudio = estudio_cache.get(codigo)
            if id_estudio is None:
                descripcion = norm(ws.cell(row=r, column=col_est).value) if col_est else None
                row = conn.execute(
                    text(
                        "INSERT INTO public.estudio (codigo_hexalis, descripcion) VALUES (:cod, :desc) "
                        "ON CONFLICT (codigo_hexalis) DO NOTHING RETURNING id"
                    ),
                    {"cod": codigo, "desc": descripcion or codigo},
                ).fetchone()
                if row is None:
                    row = conn.execute(
                        text("SELECT id FROM public.estudio WHERE codigo_hexalis = :cod"), {"cod": codigo}
                    ).fetchone()
                id_estudio = row[0]
                estudio_cache[codigo] = id_estudio
                warnings.append(
                    f"[{sheet_name}] fila {r}: código '{codigo}' no estaba en GENERAL, se creó automáticamente."
                )

            nemonico = norm(ws.cell(row=r, column=col_nem).value) if col_nem else None
            if not nemonico:
                nemonico = codigo
                warnings.append(f"[{sheet_name}] fila {r}: sin NEMONICO DATATECH, se usa el código '{codigo}'.")

            paridad_raw = norm(ws.cell(row=r, column=col_paridad).value) if col_paridad else None
            paridad = PARIDAD_MAP.get(paridad_raw.upper()) if paridad_raw else None
            if paridad_raw and paridad is None:
                warnings.append(f"[{sheet_name}] fila {r}: paridad '{paridad_raw}' sin mapeo, se usa el default.")

            status_raw = norm(ws.cell(row=r, column=col_status).value) if col_status else None
            estado = STATUS_MAP.get(status_raw.upper()) if status_raw else None
            if status_raw and estado is None:
                warnings.append(f"[{sheet_name}] fila {r}: status '{status_raw}' sin mapeo, se usa el default.")

            revisor = norm(ws.cell(row=r, column=col_reviso).value) if col_reviso else None
            if not revisor:
                revisor = REVISOR_DEFAULT
                warnings.append(f"[{sheet_name}] fila {r}: sin REVISO, se usa '{REVISOR_DEFAULT}'.")

            indicaciones = get_indicaciones(ws, r, col_modelo, col_indic)
            if indicaciones is None:
                stats["sin_indicaciones"] += 1

            data = {
                "nemonico_datatech": nemonico,
                "id_estudio": id_estudio,
                "id_metodo": metodo_cache.get_or_create(ws.cell(row=r, column=col_metodo).value) if col_metodo else None,
                "id_preanalitico": preanalitico_cache.get_or_create(ws.cell(row=r, column=col_preanalitico).value) if col_preanalitico else None,
                "id_muestra": muestra_cache.get_or_create(ws.cell(row=r, column=col_muestra).value) if col_muestra else None,
                "id_sector_laboratorio": sector_cache.get(id_estudio),
                "indicaciones": indicaciones,
                "valor_referencia": norm(ws.cell(row=r, column=col_valref).value) if col_valref else None,
                "dias_demora": parse_int(ws.cell(row=r, column=col_demora).value if col_demora else None),
                "estado": estado,
                "codigo_laboratorio": norm(ws.cell(row=r, column=col_codprop).value) if col_codprop else None,
                "revisor": revisor,
                "observacion": norm(ws.cell(row=r, column=col_obs).value) if col_obs else None,
                "derivante_id": derivante_id,
                "paridad_datatech_hexalis": paridad,
            }

            accion = upsert_estudio_derivante(conn, data)
            if accion == "inserted":
                n_ins += 1
            else:
                n_upd += 1

        print(f"[{sheet_name}] {n_ins} insertados, {n_upd} actualizados.")
        stats["insertados"] += n_ins
        stats["actualizados"] += n_upd


def main():
    parser = argparse.ArgumentParser(description="Carga estudios.xlsx en la base de datos britlab_test")
    parser.add_argument("--file", default=DEFAULT_FILE, help="Ruta al archivo estudios.xlsx")
    parser.add_argument("--db-url", default=DEFAULT_DB_URL, help="URL de conexión SQLAlchemy a PostgreSQL")
    parser.add_argument("--dry-run", action="store_true", help="No confirma la transacción (rollback al final)")
    args = parser.parse_args()

    print("Leyendo archivo Excel (puede tardar unos segundos)...")
    # data_only=True: usar el valor cacheado de las fórmulas (p.ej. VLOOKUP en la hoja
    # GENERAL) en lugar del texto de la fórmula. Los hipervínculos y comentarios de Excel
    # siguen disponibles igual con esta opción.
    wb = openpyxl.load_workbook(args.file, data_only=True, read_only=False)

    engine = create_engine(args.db_url)
    warnings = []
    stats = {"insertados": 0, "actualizados": 0, "sin_indicaciones": 0}

    if args.dry_run:
        print("*** MODO DRY-RUN: no se confirmarán los cambios en la base de datos ***")

    with engine.connect() as conn:
        trans = conn.begin()
        try:
            estudio_cache = cargar_general(conn, wb, warnings)
            sector_cache = cargar_orden(conn, wb, estudio_cache, warnings)
            cargar_derivantes(conn, wb, estudio_cache, sector_cache, warnings, stats)
        except Exception:
            trans.rollback()
            raise

        if args.dry_run:
            trans.rollback()
            print("Dry-run finalizado, no se guardó nada.")
        else:
            trans.commit()

    print("\n" + "=" * 70)
    print(f"Total estudio_derivante insertados: {stats['insertados']}")
    print(f"Total estudio_derivante actualizados: {stats['actualizados']}")
    print(f"Filas sin indicaciones (ni link ni nota): {stats['sin_indicaciones']}")
    print(f"Advertencias: {len(warnings)}")
    print("=" * 70)
    if warnings:
        print("\nDetalle de advertencias:")
        for w in warnings:
            print(" -", w)


if __name__ == "__main__":
    sys.exit(main())
