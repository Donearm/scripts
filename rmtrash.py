#!/usr/bin/env python

import os
import sys
import shutil


shittyfiles = [
    '~/.adobe',                         # Flash crap
    '~/.macromedia',                    # Flash crap
    '~/.recently-used',
    '~/.local/share/recently-used.xbel',
    '~/Desktop',                        # Firefox creates this
    '~/.gstreamer-0.10',
    '~/.pulse',
    '~/.esd_auth',
    '~/.config/enchant',
    '~/.dropbox-dist',
    '~/.bazaar/',                       # bzr insists on creating files holding default values
    '~/.bzr.log',
    '~/.nv/',
    '~/.viminfo',                       # configured to be moved to ~/.cache/vim/viminfo, but it is still sometimes created...
    '~/.cache/chromium/',               # Chromium cache
    '~/.cache/BraveSoftware/',          # Brave browser cache
    '~/.cache/ranger/',                 # ranger image/video previews' cache
    '~/.cache/mesa/',
    '~/.cache/mesa_shader_cache/',
    '~/.cache/electron/',
    '~/.ACEStream/.acestream_cache/',   # Acestream cache
    '~/.thumbnails/normal/'             # I don't care about thumbs...
]

def clean_go_build():
    """Go build caches can be removed with its own command. Running it instead of removing the directory manually"""
    try:
        os.system("go clean -cache &> /dev/null")
    except:
        print("An error occurred while trying to remove Go build cache")

def clean_npm():
    """Npm has a command, npm cache clean --force, to actually clean its cache. Running it instead of removing the directory manually"""

    try:
        os.system("npm cache clean --force &> /dev/null")
    except:
        print("An error occurred while trying to remove NPM cache")


def calculate_dir_size(directory):
    """Walk through each directory and subdirectory of a path and calculate the total size of directories + files in it"""
    size = 0
    for dirpath, dirnames, filenames in os.walk(directory):
        for f in filenames:
            fp = os.path.join(dirpath, f)
            if not os.path.islink(fp):
                size += os.stat(fp).st_size
    return size


def rmtrash():
    found = []
    for f in shittyfiles:
        absf = os.path.expanduser(f)
        if os.path.exists(absf):
            found.append(absf)

    if len(found) == 0:
        print("No shitty files found :)")
        return
    else:
        print("Found shittyfiles:")
        files_size = []
        for f in found:
            print("Cleaning", f)
            if os.path.isdir(f):
                files_size.append(calculate_dir_size(f))
            else:
                files_size.append(os.stat(f).st_size)

            if os.path.isfile(f):
                os.remove(f)
            else:
                shutil.rmtree(f)
        print("Cleaned files, freed %dKb of space" % (sum(files_size)/1000))

if __name__ == '__main__':
    clean_npm()
    clean_go_build()
    rmtrash()
