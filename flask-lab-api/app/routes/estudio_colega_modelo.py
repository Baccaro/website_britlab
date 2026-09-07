from flask import Blueprint, request, jsonify, Response
from app.crud import _commit_or_400
from app.database import db
from app.models import EstudioColegaModelo, EstudioColega

bp = Blueprint('estudio_colega_modelo', __name__, url_prefix='/api/estudio-colega-modelo')

MAX_BYTES = 15 * 1024 * 1024  # 15 MB por archivo


def _serialize(m):
    return {
        'id': m.id,
        'id_estudio_colega': m.id_estudio_colega,
        'nombre_archivo': m.nombre_archivo,
        'tamanio_bytes': m.tamanio_bytes,
        'created_at': m.created_at.isoformat() if m.created_at else None,
    }


@bp.route('/estudio-colega/<int:id_estudio_colega>', methods=['GET'])
def list_por_estudio_colega(id_estudio_colega):
    items = (
        EstudioColegaModelo.query
        .filter_by(id_estudio_colega=id_estudio_colega)
        .order_by(EstudioColegaModelo.created_at.asc(), EstudioColegaModelo.id.asc())
        .all()
    )
    return jsonify([_serialize(m) for m in items]), 200


@bp.route('', methods=['POST'])
def upload():
    id_estudio_colega = request.form.get('id_estudio_colega', type=int)
    archivo = request.files.get('archivo')
    if not id_estudio_colega or not archivo:
        return jsonify({'error': 'Faltan datos: id_estudio_colega y archivo son obligatorios'}), 400

    EstudioColega.query.get_or_404(id_estudio_colega)

    nombre = archivo.filename or 'documento.pdf'
    if not nombre.lower().endswith('.pdf'):
        return jsonify({'error': 'Sólo se aceptan archivos PDF'}), 400

    contenido = archivo.read()
    if not contenido:
        return jsonify({'error': 'El archivo está vacío'}), 400
    if len(contenido) > MAX_BYTES:
        return jsonify({'error': f'El archivo supera el máximo permitido ({MAX_BYTES // (1024 * 1024)} MB)'}), 400

    nuevo = EstudioColegaModelo(
        id_estudio_colega=id_estudio_colega,
        nombre_archivo=nombre,
        contenido=contenido,
        tamanio_bytes=len(contenido),
    )
    db.session.add(nuevo)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify(_serialize(nuevo)), 201


@bp.route('/<int:id>/descargar', methods=['GET'])
def descargar(id):
    m = EstudioColegaModelo.query.get_or_404(id)
    return Response(
        m.contenido,
        mimetype='application/pdf',
        headers={'Content-Disposition': f'inline; filename="{m.nombre_archivo}"'}
    )


@bp.route('/<int:id>', methods=['DELETE'])
def delete(id):
    m = EstudioColegaModelo.query.get_or_404(id)
    db.session.delete(m)
    error_response = _commit_or_400()
    if error_response:
        return error_response
    return jsonify({'message': f'Registro {id} eliminado correctamente'}), 200
