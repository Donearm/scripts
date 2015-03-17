#!/usr/bin/env python
# -*- coding: utf-8 -*-
###############################################################################
# Copyright (c) 2015, Gianluca Fiore
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
###############################################################################

# Browse (sub)reddits, sequentially, with cortex

__author__ = "Gianluca Fiore"
__license__ = "GPL"
__date__ = "20150317"
__status__ = "beta"

import argparse
import sys
import subprocess

# Declare here the (sub)reddits
REDDITS_IMG = ['unixporn', 'wallpaperdump', 'celebs', 'celebswallpaper', 'fashpics', 'models']
REDDITS_PROGRAMMING = ['compsci', 'programming', 'golang', 'awesomewm', 'archlinux', 'linux']
REDDITS_VAR = ['linguistics', 'history', 'music', 'metal', 'fitness']

REDDITS_ALL = REDDITS_IMG + REDDITS_PROGRAMMING + REDDITS_VAR


def argument_parser():
    """CLI argument parser"""
    p = argparse.ArgumentParser()
    p.add_argument("-i", "--image",
            action="store_true",
            help="browse images-related (sub)reddits",
            dest="r_img")
    p.add_argument("-p", "--programming",
            action="store_true",
            help="browse programming-related (sub)reddits",
            dest="r_prog")
    p.add_argument("-v", "--various",
            action="store_true",
            help="browse various (sub)reddits",
            dest="r_var")
    p.add_argument("-a", "--all",
            action="store_true",
            help="browse all (sub)reddist",
            dest="r_all")

    options = p.parse_args()
    return options, p


def launch_cortex(reddit):
    """Launch cortex for every reddit given"""
    for r in reddit:
        if type(r) == 'list':
            launch_cortex(r)
        else:
            command = ['cortex', r]
            p = subprocess.call(command)


if __name__ == '__main__':
    try:
        options, cli_parser = argument_parser()
    except:
        sys.exit(1)

    # Check first if we want to browse all reddits
    if options.r_all:
        launch_cortex(REDDITS_ALL)
    else:
        if options.r_img:
            launch_cortex(REDDITS_IMG)
        elif options.r_prog:
            launch_cortex(REDDITS_PROGRAMMING)
        elif options.r_var:
            launch_cortex(REDDITS_VAR)
        else:
            print("Choose a list of reddits to browse please")
            cli_parser.print_help()
            cli_parser.exit(status=1)
