import os
import secrets

class Config:
    SQLALCHEMY_DATABASE_URI = os.getenv(
        "DATABASE_URL",
        "postgresql://flask_user:flask_password@db:5432/lab_db"
    )
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    # Firma los tokens JWT de sesión. En producción hay que fijar SECRET_KEY
    # por variable de entorno: si no, cada reinicio del proceso invalida todas
    # las sesiones activas (se genera una clave nueva al azar).
    SECRET_KEY = os.getenv("SECRET_KEY") or secrets.token_hex(32)
    # Carpeta donde se guardan los PDF adjuntos (estudio_colega_modelo), SIEMPRE
    # la misma ruta DENTRO del contenedor: lo que cambia entre entornos es a qué
    # carpeta del host la mapea el "volumes:" del docker-compose (producción:
    # /srv/britlab/files, dev: una carpeta dentro de flask-lab-api), no esto.
    FILES_DIR = os.getenv("FILES_DIR", "/app/files")
