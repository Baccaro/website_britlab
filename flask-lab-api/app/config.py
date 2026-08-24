import os

class Config:
    SQLALCHEMY_DATABASE_URI = os.getenv(
        "DATABASE_URL", 
        "postgresql://flask_user:flask_password@db:5432/lab_db"
    )
    SQLALCHEMY_TRACK_MODIFICATIONS = False
