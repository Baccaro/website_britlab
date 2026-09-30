"""Renombra los PDF ya migrados a disco (ver migrar_pdfs_a_disco.py), que
quedaron como 'estudio_colega_modelos/<id>.pdf', al formato legible nuevo:
CODIGOHEXALIS_LABORATORIO_pre|md|<categoria>_N.pdf, directo en FILES_DIR (sin
subcarpeta). El "N" es correlativo por cada combinación de Estudio +
Laboratorio Procesante + categoría, en orden de creación.

Se puede correr más de una vez: las filas que ya tengan el nombre nuevo (no
empiezan con 'estudio_colega_modelos/') se saltean.

Uso: docker exec flask_lab_api python renombrar_pdfs_formato_legible.py
"""
import os
from collections import defaultdict

from app import create_app
from app.database import db
from app.models import EstudioColegaModelo, EstudioColega
from app.routes.estudio_colega_modelo import CATEGORIA_SUFIJO, _slug, _ruta_absoluta

app = create_app()

with app.app_context():
    filas = (
        db.session.query(EstudioColegaModelo, EstudioColega)
        .join(EstudioColega, EstudioColegaModelo.id_estudio_colega == EstudioColega.id)
        .order_by(EstudioColegaModelo.created_at.asc(), EstudioColegaModelo.id.asc())
        .all()
    )

    contador = defaultdict(int)  # (id_estudio, colega_id, categoria) -> próximo N
    renombradas = 0
    for m, ec in filas:
        if not m.ruta_archivo.startswith('estudio_colega_modelos/'):
            print(f"fila {m.id}: ya tiene formato nuevo ({m.ruta_archivo}), se salta")
            continue

        clave = (ec.id_estudio, ec.colega_id, m.categoria)
        contador[clave] += 1
        numero = contador[clave]

        codigo_hexalis = ec.estudio.codigo_hexalis if ec.estudio else 'sn'
        nombre_colega = ec.colega.descripcion if ec.colega else 'sn'
        sufijo = CATEGORIA_SUFIJO.get(m.categoria, m.categoria)
        nueva_relativa = f'{_slug(codigo_hexalis)}_{_slug(nombre_colega)}_{sufijo}_{numero}.pdf'

        vieja_absoluta = _ruta_absoluta(m.ruta_archivo)
        nueva_absoluta = _ruta_absoluta(nueva_relativa)
        os.rename(vieja_absoluta, nueva_absoluta)
        m.ruta_archivo = nueva_relativa
        db.session.commit()
        renombradas += 1
        print(f"fila {m.id}: {vieja_absoluta} -> {nueva_absoluta}")

    print(f"Listo: {renombradas} archivo(s) renombrados.")

    vieja_carpeta = os.path.join(app.config['FILES_DIR'], 'estudio_colega_modelos')
    if os.path.isdir(vieja_carpeta) and not os.listdir(vieja_carpeta):
        os.rmdir(vieja_carpeta)
        print(f"Carpeta vieja vacía, eliminada: {vieja_carpeta}")
    elif os.path.isdir(vieja_carpeta):
        print(f"ATENCIÓN: {vieja_carpeta} todavía tiene archivos, revisar.")
