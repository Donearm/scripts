#!/usr/bin/env python2
# -*- coding: utf-8 -*-
###############################################################################
# Copyright (c) 2011-2014, Gianluca Fiore
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
###############################################################################
#
# Requirements: Python 2.7 or later, Pyexiv2
#

__author__ = "Gianluca Fiore"
__license__ = "GPL"
__version__ = "0.1"
__date__ = "20110530"
__email__ = "forod.g@gmail.com"
__status__ = "beta"

import sys
import argparse
import os.path
import pyexiv2


def argument_parser():
    """Argument parser"""
    cli_parser = argparse.ArgumentParser()

    cli_parser.add_argument("-f", "--force",
            action="store_true",
            help="force writing of tags regardless of them being already present",
            dest="force")
    cli_parser.add_argument("-i", "--image",
            required=True,
            action="store",
            help="the image",
            dest="image")
    cli_parser.add_argument("-d", "--delete",
            action="store_true",
            help="delete all tags present in an image",
            dest="delete")
    cli_parser.add_argument(action="store",
            nargs="*",
            help="the tags to be written into the file",
            dest="tags")
    options = cli_parser.parse_args()
    return options


def write_tags(image, key, tags):
    """Write each tags into the iptc key inside an image. Tags must be a list"""
    image[key] = pyexiv2.IptcTag(key, tags)
    image.write()


def delete_tags(metadata, key):
    """Delete any tags present inside an image"""
    try:
        metadata.__delitem__(key)
    except KeyError:
        print("There's not a %s tag in this image, exiting..." % key)
        return 1


def main ():
    """main loop"""

    options = argument_parser()

    image = os.path.abspath(options.image)
    if os.path.isfile(image) and image.endswith(('jpg', 'JPG', 'jpeg', 'JPEG', 'png', 'PNG', 'tiff', 'TIFF')):
        m = pyexiv2.ImageMetadata(image)
        m.read()
        iptckeys = m.iptc_keys
        xmpkeys = m.xmp_keys
        exifkeys = m.exif_keys
        if options.delete:
            # delete all tags
            try:
                k = m['Iptc.Application2.Keywords']
                delete_tags(m, 'Iptc.Application2.Keywords')
                print("Deleting tags")
                m.write()
                return 0
            except KeyError:
                # there are already no tags, skip...
                print("%s has no tags, nothing to delete" % options.image)
                return 0
        if not options.tags:
            # without tags given perhaps the user wants just see the already
            # presents tags (if any)
            try:
                k = m['Iptc.Application2.Keywords']
                print("%s is already tagged with %s " % (options.image, k.value))
                return 0
            except:
                print("%s has no tags set" % options.image)
                return 0
        else:
            try:
                k = m['Iptc.Application2.Keywords']
                if options.force:
                    # Force switch enabled, write tags without questions
                    write_tags(m, 'Iptc.Application2.Keywords', options.tags)

                else:
                    print("There are already these tags present:\n")
                    for t in k.value:
                        print(t)
                    s = raw_input("\nDo you want to overwrite them with %s ? [y/n] " % options.tags)
                    if s == 'y' or s == 'Y':
                        print("Writing tags")
                        write_tags(m, 'Iptc.Application2.Keywords', options.tags)
                    else:
                        print("Exiting...")
                        sys.exit(0)
            except KeyError:
                # there is no previously set tag with this name, pyexiv2 throws KeyError
                print("Writing tags")
                write_tags(m, 'Iptc.Application2.Keywords', options.tags)
    else:
        print("No image given")


if __name__ == '__main__':
    status = main()
    sys.exit(status)
