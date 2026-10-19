#!/usr/bin/env python3

import json
import logging
from datetime import datetime, timezone
from http.server import BaseHTTPRequestHandler, HTTPServer

HOST = "127.0.0.1"
PORT = 8080
LOG_FILE = "/srv/mini-linux-server/logs/app.log"

logging.basicConfig(
    filename=LOG_FILE,
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s",
)

class MiniServerHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path not in ("/", "/health"):
            self.send_json(404, {
                "status": "not_found",
                "path": self.path,
            })
            return

        self.send_json(200, {
            "service": "mini-linux-server",
            "status": "ok",
            "endpoint": self.path,
            "timestamp": datetime.now(timezone.utc).isoformat(),
        })

    def send_json(self, status_code, payload):
        body = json.dumps(payload, indent=2).encode("utf-8")

        self.send_response(status_code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

        logging.info(
            "client=%s method=%s path=%s status=%s",
            self.client_address[0],
            self.command,
            self.path,
            status_code,
        )

    def log_message(self, format_string, *args):
        # Gunakan file log aplikasi, bukan output HTTP standar.
        return

if __name__ == "__main__":
    server = HTTPServer((HOST, PORT), MiniServerHandler)
    logging.info("Server starting host=%s port=%s", HOST, PORT)

    try:
        server.serve_forever()
    except KeyboardInterrupt:
        logging.info("Server stopping")
    finally:
        server.server_close()
