// URL de la API de flask-lab-api: en dev apunta al backend local (ver
// flask-lab-api/docker-compose.yml, puerto 8080 del frontend que proxea
// /api/), en producción se fija en build time con VITE_API_BASE (ver
// website/website/.env.production).
export const API_BASE = import.meta.env.VITE_API_BASE || 'http://localhost:8080/api'
