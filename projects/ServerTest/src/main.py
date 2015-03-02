#!/user/bin/env python
#*-*- coding:utf-8 -*-
from BaseHTTPServer import HTTPServer,BaseHTTPRequestHandler
from json.decoder import JSONDecoder
from json.encoder import JSONEncoder
import xxtea
class RequestHandler(BaseHTTPRequestHandler):
    def _writeHeader(self):
        self.send_response(200,"ok")
#         self.send_header("Access-Control-Allow-Origin", "*")
#         self.send_header("Access-Control-Allow-Methods", "GET,POST,OPTIONS")
#         self.send_header("Access-Control-Allow-Headers", "X-Request-With")
#         self.send_header("Content-type", "text/html")
        self.end_headers()
    def do_HEAD(self):
        self._writeHeader()
    def do_GET(self):
        self._writeHeader()
        self.wfile.write("It is OK.")
    def do_POST(self):
        content_len = int(self.headers["Content-Length"])
        post_data = self.rfile.read(content_len)
#         post_data = xxtea.decrypt(post_data, "################")
#         print post_data[28] == '\0' ,unicode(post_data[28])
        
#         while post_data.index("\0") != -1:
#             post_data = post_data.strip("\0")
# #             print post_data.index("\0")
# #             print len(post_data)
        decoder = JSONDecoder()
        resultObj = decoder.decode(post_data)
        self._writeHeader()
        self.wfile.write("Recieve Operation " + resultObj["data"])
    def do_OPTIONS(self):
        self._writeHeader()
        self.wfile.write("It is OK.")
        
    def parse(self,param):
        decoder = JSONDecoder()
        return decoder.decode(param)
        
server_address = ("168.168.8.105",8765)
server = HTTPServer(server_address, RequestHandler)
server.serve_forever()
