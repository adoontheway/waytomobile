#!/user/bin/env python
#*-*- coding:utf-8 -*-
from BaseHTTPServer import HTTPServer,BaseHTTPRequestHandler
class RequestHandler(BaseHTTPRequestHandler):
    def _writeHeader(self):
        self.send_response(200,"ok")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "GET,POST,OPTIONS")
        self.send_header("Access-Control-Allow-Headers", "X-Request-With")
        self.send_header("Content-type", "text/html")
        self.end_headers()
    def do_HEAD(self):
        self._writeHeader()
    def do_GET(self):
        self._writeHeader()
        self.wfile.write("It is OK.")
    def do_POST(self):
        self._writeHeader()
        self.wfile.write("It is OK.")
    def do_OPTIONS(self):
        self._writeHeader()
        self.wfile.write("It is OK.")
        
server_address = ("168.168.8.105",8765)
server = HTTPServer(server_address, RequestHandler)
server.serve_forever()
