import json
import os
from http.server import BaseHTTPRequestHandler, HTTPServer

PORT = int(os.getenv("APP_PORT", "7070"))
BANNER_FILE = os.getenv("BANNER_FILE", "/srv/app/config/banner.txt")

with open(BANNER_FILE, "r", encoding="utf-8") as f:
    banner = f.read().strip()

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        payload = {
            "status": "ok",
            "banner": banner,
            "port": PORT
        }
        body = (json.dumps(payload, ensure_ascii=False) + "\n").encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, fmt, *args):
        print(fmt % args, flush=True)

print(f"Starting API on port {PORT}, banner file: {BANNER_FILE}", flush=True)
HTTPServer(("0.0.0.0", PORT), Handler).serve_forever()