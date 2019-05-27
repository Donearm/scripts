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
    '~/.ACEStream/.acestream_cache/'    # Acestream cache
]

def clean_npm():
    """Npm has a command, npm cache clean --force, to actually clean its cache. Running it instead of removing the directory manually"""

    try:
        os.system("npm cache clean --force &> /dev/null")
    except:
        print("An error occurred while trying to remove NPM cache")


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
            print(f)
            files_size.append(os.stat(f).st_size)
            if os.path.isfile(f):
                os.remove(f)
            else:
                shutil.rmtree(f)
        print("Cleaned files, freed %dKb of space" % (sum(files_size)/1000))

if __name__ == '__main__':
    clean_npm()
    rmtrash()
