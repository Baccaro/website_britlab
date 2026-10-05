import os
import secrets

class Config:
    # "+psycopg2" explícito a propósito: sin esto, SQLAlchemy 2.1+ resuelve un
    # "postgresql://" sin driver al paquete "psycopg" (v3, no instalado acá)
    # en vez de psycopg2-binary (el que sí está en requirements.txt), y el
    # proceso ni arranca (ModuleNotFoundError: No module named 'psycopg').
    SQLALCHEMY_DATABASE_URI = os.getenv(
        "DATABASE_URL",
        "postgresql+psycopg2://flask_user:flask_password@db:5432/lab_db"
    )
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    # Firma los tokens JWT de sesión. En producción hay que fijar SECRET_KEY
    # por variable de entorno: si no, cada reinicio del proceso invalida todas
    # las sesiones activas (se genera una clave nueva al azar).
    SECRET_KEY = os.getenv("SECRET_KEY") or secrets.token_hex(32)
    # Carpeta donde se guardan los PDF adjuntos (estudio_colega_modelo, cv), SIEMPRE
    # la misma ruta DENTRO del contenedor: lo que cambia entre entornos es a qué
    # carpeta del host la mapea el "volumes:" del docker-compose (producción:
    # /srv/britlab/files, dev: una carpeta dentro de flask-lab-api), no esto.
    FILES_DIR = os.getenv("FILES_DIR", "/app/files")
    # Orígenes permitidos para el único endpoint público sin login (POST
    # /api/cv, el formulario de "Trabajá con Nosotros" de la web pública):
    # lista separada por comas. En producción hay que poner acá el dominio
    # real de la web pública (p.ej. "https://public.britlab.com.ar"); en dev,
    # el default ya cubre los puertos típicos de Vite.
    CORS_ORIGINS = os.getenv(
        "CORS_ORIGINS",
        "http://localhost:5173,http://localhost:5174,http://localhost:5175"
    )
