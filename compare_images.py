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

import sys
import os

# Requires PIL and imagehash modules
from PIL import Image
import imagehash

CUTOFF = 20

exampleDir = '/mnt/documents/d/Camera_images/Krakow/Krakow2019'

def find_similar_images(paths, hashfunc = imagehash.average_hash):
    """Compare all the images in a given path for similarity and return a list of all that have a match"""
    def is_image(filename):
        f = filename.lower()
        return f.endswith(".png") or f.endswith(".jpg") or f.endswith(".jpeg") or '.jpg' in f

    image_filenames = []
    for i in os.listdir(paths):
        if is_image(i):
            image_filenames.append(os.path.join(paths, i))

    images = {}
    for img in sorted(image_filenames):
        try:
            hash = hashfunc(Image.open(img))
            images[img] = hash
        except Exception as e:
            print('Problem: ', e, ' with ', img)
        
    similar_images = []
    for k, h in images.items():
        for v in images.values():
            similarity = h - v
            # if similarity is less than the cutoff value but above 0 (which means the images are identical), we have a match
            if similarity < CUTOFF and similarity > 0:
                current_value = [t for (t, w) in images.items() if w == v]
                print("Comparing ", k, " with ", current_value[0])
                print(similarity)
                similar_images.extend([k, current_value[0]])

    return similar_images


def main():
    s = find_similar_images(paths=exampleDir)
    # a set to remove duplicates in the resulting list
    print(set(s))

if __name__ == '__main__':
    status = main()
    sys.exit(status)
