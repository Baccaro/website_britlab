#!/usr/bin/env bash
# Crea (si no existe) la base indicada y carga el esquema + los datos desde
# britlab_test_dump.sql. Pensado para pasarle la base a otra persona/entorno
# sin tener que correr de nuevo el ETL del Excel.
#
# Uso:
#   ./restaurar_britlab_test.sh [nombre_db] [host] [usuario] [puerto]
#
# Variables de entorno opcionales:
#   PGPASSWORD  - si no se define, psql la va a pedir por consola.
#
# Ejemplos:
#   ./restaurar_britlab_test.sh
#   ./restaurar_britlab_test.sh britlab_test localhost postgres 5432
#   PGPASSWORD=miclave ./restaurar_britlab_test.sh britlab_test 192.168.1.10 postgres

set -euo pipefail

DB_NAME="${1:-britlab_test}"
DB_HOST="${2:-localhost}"
DB_USER="${3:-postgres}"
DB_PORT="${4:-5432}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DUMP_FILE="$SCRIPT_DIR/britlab_test_dump.sql"

if [ ! -f "$DUMP_FILE" ]; then
  echo "No se encontró $DUMP_FILE" >&2
  exit 1
fi

echo "Verificando/creando la base '$DB_NAME' en $DB_HOST:$DB_PORT (usuario: $DB_USER)..."
EXISTE=$(psql -h "$DB_HOST" -U "$DB_USER" -p "$DB_PORT" -d postgres -tAc \
  "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME';")

if [ "$EXISTE" != "1" ]; then
  createdb -h "$DB_HOST" -U "$DB_USER" -p "$DB_PORT" "$DB_NAME"
  echo "Base '$DB_NAME' creada."
else
  echo "La base '$DB_NAME' ya existe: se van a recrear las tablas (DROP + CREATE) y recargar los datos."
fi

echo "Restaurando esquema y datos desde $DUMP_FILE..."
psql -h "$DB_HOST" -U "$DB_USER" -p "$DB_PORT" -d "$DB_NAME" -f "$DUMP_FILE"

echo "Listo. Verificando conteos por tabla:"
psql -h "$DB_HOST" -U "$DB_USER" -p "$DB_PORT" -d "$DB_NAME" -c "
SELECT 'derivante' AS tabla, COUNT(*) FROM public.derivante
UNION ALL SELECT 'estudio', COUNT(*) FROM public.estudio
UNION ALL SELECT 'metodo', COUNT(*) FROM public.metodo
UNION ALL SELECT 'muestra', COUNT(*) FROM public.muestra
UNION ALL SELECT 'preanalitico', COUNT(*) FROM public.preanalitico
UNION ALL SELECT 'sector_laboratorio', COUNT(*) FROM public.sector_laboratorio
UNION ALL SELECT 'estudio_derivante', COUNT(*) FROM public.estudio_derivante;
"
