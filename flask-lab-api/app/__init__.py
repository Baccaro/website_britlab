from flask import Flask
from app.config import Config
from app.database import db

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    db.init_app(app)

    # Registrar Blueprints
    from app.routes.colegas import bp as colegas_bp
    from app.routes.estudios import bp as estudios_bp
    from app.routes.metodos import bp as metodos_bp
    from app.routes.muestras import bp as muestras_bp
    from app.routes.preanaliticos import bp as preanaliticos_bp
    from app.routes.sectores import bp as sectores_bp
    from app.routes.valores_estudio_sector import bp as valores_estudio_sector_bp
    from app.routes.estudio_colega import bp as estudio_colega_bp
    from app.routes.tipos_muestra_estructurada import ALL_BLUEPRINTS as muestra_estructurada_bps
    from app.routes.estudio_colega_muestra import bp as estudio_colega_muestra_bp
    from app.routes.estudio_colega_muestra_alternativa import bp as estudio_colega_muestra_alternativa_bp
    from app.routes.estudio_colega_modelo import bp as estudio_colega_modelo_bp
    from app.routes.auth import bp as auth_bp
    from app.routes.usuarios import bp as usuarios_bp

    app.register_blueprint(colegas_bp)
    app.register_blueprint(estudios_bp)
    app.register_blueprint(metodos_bp)
    app.register_blueprint(muestras_bp)
    app.register_blueprint(preanaliticos_bp)
    app.register_blueprint(sectores_bp)
    app.register_blueprint(valores_estudio_sector_bp)
    app.register_blueprint(estudio_colega_bp)
    for muestra_bp in muestra_estructurada_bps:
        app.register_blueprint(muestra_bp)
    app.register_blueprint(estudio_colega_muestra_bp)
    app.register_blueprint(estudio_colega_muestra_alternativa_bp)
    app.register_blueprint(estudio_colega_modelo_bp)
    app.register_blueprint(auth_bp)
    app.register_blueprint(usuarios_bp)

    return app
