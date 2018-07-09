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
__license__ = "GPLv3"
__version__ = "1.0"
__mantainer__ = "Gianluca Fiore"
__date__ = "20110303"
__email__ = "forod.g@gmail.com"
__status__ = "stable"

import sys
import urllib.request
import json

JSONIP4 = 'https://ipv4.jsonip.com/'
JSONIP6 = 'https://ipv6.jsonip.com/'

def main():
    f4 = urllib.request.urlopen(JSONIP4)
    f6 = urllib.request.urlopen(JSONIP6)
    ip4 = json.loads(f4.read().decode('utf-8'))
    ip6 = json.loads(f6.read().decode('utf-8'))
    print("Your current IPv4 is: %s" % ip4['ip'])
    print("Your current IPv6 is: %s" % ip6['ip'])

if __name__ == '__main__':
    status = main()
    sys.exit(status)
