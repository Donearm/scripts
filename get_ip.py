#!/usr/bin/env python
# -*- coding: utf-8 -*-
###############################################################################
# Copyright (c) 2012-2013, Gianluca Fiore
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
###############################################################################

__author__ = "Gianluca Fiore"
__license__ = "GPLv3"
__version__ = "1.0"
__mantainer__ = "Gianluca Fiore"
__date__ = "20110303"
__email__ = "forod.g@gmail.com"
__status__ = "stable"

import sys
import urllib.request
import json

JSONIP = 'http://jsonip.com/'

def main():
    f = urllib.request.urlopen(JSONIP)
    ip = json.loads(f.read().decode('utf-8'))
    print("Your current IP is: %s" % ip['ip'])

if __name__ == '__main__':
    status = main()
    sys.exit(status)
