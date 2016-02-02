#!/usr/bin/env python

import os
import sys
import shutil


shittyfiles = [
    '~/.adobe',              # Flash crap
    '~/.macromedia',         # Flash crap
    '~/.recently-used',
    '~/.local/share/recently-used.xbel',
    '~/Desktop',             # Firefox creates this
    '~/.gstreamer-0.10',
    '~/.pulse',
    '~/.esd_auth',
    '~/.config/enchant',
    '~/.dropbox-dist',
    '~/.bazaar/',           # bzr insists on creating files holding default values
    '~/.bzr.log',
    '~/.nv/',
    '~/.viminfo',           # configured to be moved to ~/.cache/vim/viminfo, but it is still sometimes created...
    '~/.npm/',              # npm cache
    '~/.cache/chromium/',   # chromium cache
]


def rmtrash():
    found = []
    for f in shittyfiles:
        absf = os.path.expanduser(f)
        if os.path.exists(absf):
            found.append(absf)
            print("    %s" % f)

    if len(found) == 0:
        print("No shitty files found :)")
        return
    else:
        print("Found shittyfiles:")
        files_size = []
        for f in found:
            files_size.append(os.stat(f).st_size)
            if os.path.isfile(f):
                os.remove(f)
            else:
                shutil.rmtree(f)
        print("Cleaned files, freed %dKb of space" % (sum(files_size)/1000))

if __name__ == '__main__':
    rmtrash()
