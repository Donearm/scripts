#!/usr/bin/env python
# -*- coding: utf-8 -*-
###############################################################################
# Copyright (c) 2019, Gianluca Fiore
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
###############################################################################

__author__ = "Gianluca Fiore"
__license__ = "GPLv3"
__version__ = "0.1"
__date__ = "20190521"
__status__ = "beta"

from os import chdir
import instaloader

# Path to save the images
MAINPATH = ''
# A list of hashtags to download the latest 30 ones
HASHTAGS = []

def main():
    chdir(MAINPATH)

    L = instaloader.Instaloader(download_videos=False, download_video_thumbnails=False, download_geotags=False, download_comments=False, save_metadata=True, post_metadata_txt_pattern="")

    for h in HASHTAGS:
        L.download_hashtag(h, max_count=30)

if __name__ == '__main__':
    main()
