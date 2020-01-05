#!/usr/bin/env python2
# -*- coding: utf-8 -*-
###############################################################################
# Copyright (c) 2012-2020, Gianluca Fiore
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
###############################################################################

__author__ = "Gianluca Fiore"
__copyright__ = "2011 Gianluca Fiore"
__license__ = "GPL"
__version__ = "0.1"
__date__ = "2011/08/21"
__email__ = "forod.g@gmail.com"

import sys
import gtk.gdk

def main():
    w = gtk.gdk.get_default_root_window()
    sz = w.get_size()
    pb = gtk.gdk.Pixbuf(gtk.gdk.COLORSPACE_RGB, False, 8, sz[0], sz[1])
    pb = pb.get_from_drawable(w, w.get_colormap(), 0, 0, 0, 0, sz[0], sz[1])

    if pb is not None:
        pb.save("screenshot.png", "png")
        print("Screenshot taken")
    else:
        print("Unable to get a screenshot")


if __name__ == '__main__':
    status = main()
    sys.exit(status)
