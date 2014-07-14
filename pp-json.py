#!/usr/bin/env python
# -*- coding: utf-8 -*-
###############################################################################
# Copyright (c) 2014, Gianluca Fiore
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
###############################################################################

__author__ = "Gianluca Fiore"
__version__ = "1.0"

import sys
import json

# Pretty-print a json file

def main():
    with open(sys.argv[1], 'r') as f:
        j = json.load(f)
        print(json.dumps(j, separators=[',', ': '], indent=4))

if __name__ == '__main__':
    status = main()
    sys.exit(status)
