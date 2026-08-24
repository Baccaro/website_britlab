"""
Servidor de desarrollo local (sin Docker): sirve frontend/ como estático en '/'
y reenvía '/api/' hacia el backend Flask (por defecto en localhost:5000),
igual que hace nginx.conf en el contenedor de frontend.

Uso:
    python3 dev_proxy.py [puerto]   # default 8090
"""
import http.server
import sys
import urllib.error
import urllib.request
import os

FRONTEND_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "frontend")
BACKEND = "http://localhost:5000"
PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 8090

os.chdir(FRONTEND_DIR)


class Handler(http.server.SimpleHTTPRequestHandler):
    def _proxy(self, method):
        url = BACKEND + self.path
        body = None
        if method in ("POST", "PUT", "DELETE"):
            length = int(self.headers.get("Content-Length", 0) or 0)
            body = self.rfile.read(length) if length else None
        req = urllib.request.Request(url, data=body, method=method)
        if body:
            req.add_header("Content-Type", "application/json")
        try:
            with urllib.request.urlopen(req) as resp:
                self.send_response(resp.status)
                self.send_header("Content-Type", resp.headers.get("Content-Type", "application/json"))
                self.end_headers()
                self.wfile.write(resp.read())
        except urllib.error.HTTPError as e:
            self.send_response(e.code)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(e.read())

    def do_GET(self):
        if self.path.startswith("/api/"):
            self._proxy("GET")
        else:
            super().do_GET()

    def do_POST(self):
        self._proxy("POST")

    def do_PUT(self):
        self._proxy("PUT")

    def do_DELETE(self):
        self._proxy("DELETE")

    def log_message(self, format, *args):
        pass  # silencioso; quitar esta línea para ver el log de requests


if __name__ == "__main__":
    print(f"Frontend + proxy /api -> {BACKEND}  en  http://localhost:{PORT}")
    http.server.ThreadingHTTPServer(("127.0.0.1", PORT), Handler).serve_forever()
