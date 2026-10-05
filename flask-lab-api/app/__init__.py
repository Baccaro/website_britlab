from flask import Flask
from flask_cors import CORS
from app.config import Config
from app.database import db

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    db.init_app(app)

    # CORS SOLO donde la web pública (otro dominio, ver Config.CORS_ORIGINS)
    # necesita pegarle a la API sin login: el alta de CV (POST /api/cv) y la
    # lectura de noticias (GET /api/noticias, para la lista, el detalle y la
    # imagen de cada una). El resto de la API no lo necesita: el panel admin
    # siempre llega vía el mismo origen (proxy de nginx), y todo lo demás
    # exige JWT igual.
    cors_origins = [o.strip() for o in app.config['CORS_ORIGINS'].split(',') if o.strip()]
    CORS(app, resources={
        r'^/api/cv$': {'origins': cors_origins, 'methods': ['POST']},
        r'^/api/noticias(/.*)?$': {'origins': cors_origins, 'methods': ['GET']},
    })

    # Registrar Blueprints
    from app.routes.colegas import bp as colegas_bp
    from app.routes.estudios import bp as estudios_bp
    from app.routes.metodos import bp as metodos_bp
    from app.routes.muestras import bp as muestras_bp
    from app.routes.sectores import bp as sectores_bp
    from app.routes.valores_estudio_sector import bp as valores_estudio_sector_bp
    from app.routes.estudio_colega import bp as estudio_colega_bp
    from app.routes.tipos_muestra_estructurada import ALL_BLUEPRINTS as muestra_estructurada_bps
    from app.routes.estudio_colega_muestra import bp as estudio_colega_muestra_bp
    from app.routes.estudio_colega_muestra_alternativa import bp as estudio_colega_muestra_alternativa_bp
    from app.routes.estudio_colega_modelo import bp as estudio_colega_modelo_bp
    from app.routes.auth import bp as auth_bp
    from app.routes.usuarios import bp as usuarios_bp
    from app.routes.faq import bp as faq_bp
    from app.routes.tarifarios import bp as tarifarios_bp
    from app.routes.nomencladores import bp as nomencladores_bp
    from app.routes.autorizadores import bp as autorizadores_bp
    from app.routes.obras_sociales import bp as obras_sociales_bp
    from app.routes.cv import bp as cv_bp
    from app.routes.noticias import bp as noticias_bp

    app.register_blueprint(colegas_bp)
    app.register_blueprint(estudios_bp)
    app.register_blueprint(metodos_bp)
    app.register_blueprint(muestras_bp)
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
    app.register_blueprint(faq_bp)
    app.register_blueprint(tarifarios_bp)
    app.register_blueprint(nomencladores_bp)
    app.register_blueprint(autorizadores_bp)
    app.register_blueprint(obras_sociales_bp)
    app.register_blueprint(cv_bp)
    app.register_blueprint(noticias_bp)

    return app
