import os
from http.server import BaseHTTPRequestHandler, HTTPServer

PORT = int(os.getenv("APP_PORT", "9090"))
MESSAGE_FILE = os.getenv("MESSAGE_FILE", "/opt/app/data/message.txt")

with open(MESSAGE_FILE, "r", encoding="utf-8") as f:
    MESSAGE = f.read().strip()

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        body = (MESSAGE + "\n").encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, fmt, *args):
        print(fmt % args, flush=True)

print(f"Starting on port {PORT}, message file: {MESSAGE_FILE}", flush=True)
HTTPServer(("0.0.0.0", PORT), Handler).serve_forever()