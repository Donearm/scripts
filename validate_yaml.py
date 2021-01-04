#!/usr/bin/env python
# -*- coding: utf-8 -*-
###############################################################################
#
# Copyright (c) 2021, Gianluca Fiore
#
###############################################################################

__author__ = "Gianluca Fiore"
__copyright__ = ""
__credits__ = ""
__license__ = "GPL"
__version__ = ""
__mantainer__ = ""
__date__ = "2021/01/04"
__email__ = ""
__status__ = ""

import sys
import yaml

def main():
    # input file needs to be redirected to script, as: validate_yaml.py < file.yaml
    print(yaml.safe_load(sys.stdin))

if __name__ == '__main__':
    status = main()
    sys.exit(status)

