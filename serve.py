#!/usr/bin/env python
# -*- coding: utf-8 -*-
###############################################################################
# Copyright (c) 2012-2014, Gianluca Fiore
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
###############################################################################

__author__ = "Gianluca Fiore"
__license__ = "GPL"
__version__ = "0.1"

import sys
import http.server
import socketserver
import socket

PORT = 8001
HOST = '127.0.0.1'

def main():
    handler = http.server.SimpleHTTPRequestHandler

    try:
        daemon = socketserver.TCPServer((HOST, PORT), handler)
    except socket.error as e:
        if e.errno == 98:
            print("Another process is using port %s, please close it or change port number" % PORT)
            return 1

    print("Http server running on %s at %s port" % (HOST, PORT))

    daemon.serve_forever()


if __name__ == '__main__':
    status = main()
    sys.exit(status)

