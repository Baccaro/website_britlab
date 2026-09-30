"""Migra los PDF de estudio_colega_modelo, guardados hasta ahora como bytea
en la BD, a archivos en disco bajo Config.FILES_DIR (ver app/config.py y el
"volumes:" del docker-compose correspondiente).

Corre DESPUÉS de database/migracion_pdfs_a_disco_paso1.sql (agrega la columna
"ruta_archivo", todavía nullable) y ANTES de
database/migracion_pdfs_a_disco_paso2.sql (la vuelve NOT NULL y borra
"contenido"). Se puede correr más de una vez sin problema: salta las filas
que ya tengan ruta_archivo cargada.

Uso (desde adentro del contenedor "web"):
    docker exec flask_lab_api python migrar_pdfs_a_disco.py
"""
import os
from sqlalchemy import text

from app import create_app
from app.database import db

app = create_app()

with app.app_context():
    files_dir = app.config['FILES_DIR']
    carpeta = os.path.join(files_dir, 'estudio_colega_modelos')
    os.makedirs(carpeta, exist_ok=True)

    filas = db.session.execute(text(
        "SELECT id, contenido FROM public.estudio_colega_modelo "
        "WHERE ruta_archivo IS NULL OR ruta_archivo = ''"
    )).fetchall()

    print(f"Encontradas {len(filas)} fila(s) para migrar a {carpeta}")

    migradas = 0
    for fila in filas:
        id_, contenido = fila.id, fila.contenido
        if contenido is None:
            print(f"  fila {id_}: sin contenido, se salta")
            continue
        ruta_relativa = f'estudio_colega_modelos/{id_}.pdf'
        ruta_absoluta = os.path.join(files_dir, ruta_relativa)
        with open(ruta_absoluta, 'wb') as f:
            f.write(bytes(contenido))
        db.session.execute(
            text("UPDATE public.estudio_colega_modelo SET ruta_archivo = :ruta WHERE id = :id"),
            {'ruta': ruta_relativa, 'id': id_},
        )
        migradas += 1
        print(f"  fila {id_}: OK ({len(contenido)} bytes) -> {ruta_absoluta}")

    db.session.commit()
    print(f"Listo: {migradas} archivo(s) escritos a disco y {migradas} fila(s) actualizadas.")

    pendientes = db.session.execute(text(
        "SELECT count(*) FROM public.estudio_colega_modelo WHERE ruta_archivo IS NULL OR ruta_archivo = ''"
    )).scalar()
    if pendientes:
        print(f"ATENCIÓN: quedan {pendientes} fila(s) sin ruta_archivo (revisar antes del paso2.sql).")
    else:
        print("Todas las filas tienen ruta_archivo: ya se puede correr migracion_pdfs_a_disco_paso2.sql.")
