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

import os

# Mkdir function. Like mkdir -p
def mkdir(directory):
    """
    Mkdir function, like mkdir -p in *nix shells
    Create a directory, and parent ones if needed, but only if it doesn't 
    already exist.
    """
    if os.path.isdir(directory):
        pass
    elif os.path.isfile(directory or os.path.islink(directory):
            raise OSError("a file or symlink with the same name already exists.")
    else:
        head, tail = os.path.split(directory)
        # Check that parent directory exists already
        if head and not os.path.isdir(head):
            # make it then
            mkdir(head)

        if tail:
            os.mkdir(directory)
