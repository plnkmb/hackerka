import json
import os
from datetime import datetime
from http.server import BaseHTTPRequestHandler, HTTPServer

PORT = int(os.getenv("BACKEND_PORT", "8000")) #взять порт из переменной окружения BACKEND_PORT, а если её нет — использовать 8000.


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        print(f"{datetime.now()} request: {self.path}", flush=True)

        if self.path == "/api/health":
            response = {
                "status": "ok",
                "service": "backend",
                "message": "Backend is alive",
                "time": datetime.now().isoformat()
            }

            body = json.dumps(response).encode("utf-8")

            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)
            return

        body = b"Not found\n"
        self.send_response(404)
        self.send_header("Content-Type", "text/plain")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)


print(f"Backend started on 0.0.0.0:{PORT}", flush=True)

server = HTTPServer(("0.0.0.0", PORT), Handler) #0.0.0.0 значит: слушать все сетевые интерфейсы внутри контейнера.
server.serve_forever()
