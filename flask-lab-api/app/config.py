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
