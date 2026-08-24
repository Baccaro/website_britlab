from flask import Flask
from app.config import Config
from app.database import db

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    db.init_app(app)

    # Registrar Blueprints
    from app.routes.derivantes import bp as derivantes_bp
    from app.routes.estudios import bp as estudios_bp
    from app.routes.metodos import bp as metodos_bp
    from app.routes.muestras import bp as muestras_bp
    from app.routes.preanaliticos import bp as preanaliticos_bp
    from app.routes.sectores import bp as sectores_bp
    from app.routes.valores_estudio_sector import bp as valores_estudio_sector_bp
    from app.routes.estudio_derivante import bp as estudio_derivante_bp

    app.register_blueprint(derivantes_bp)
    app.register_blueprint(estudios_bp)
    app.register_blueprint(metodos_bp)
    app.register_blueprint(muestras_bp)
    app.register_blueprint(preanaliticos_bp)
    app.register_blueprint(sectores_bp)
    app.register_blueprint(valores_estudio_sector_bp)
    app.register_blueprint(estudio_derivante_bp)

    return app
