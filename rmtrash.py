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
        for f in found:
            if os.path.isfile(f):
                os.remove(f)
            else:
                shutil.rmtree(f)
        print("All cleaned")

if __name__ == '__main__':
    rmtrash()
