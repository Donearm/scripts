#!/usr/bin/env python

import os
import sys
import shutil


shittyfiles = [
    '~/.ACEStream/.acestream_cache/',   # Acestream cache
    '~/.adobe',                         # Flash crap
    '~/.bazaar/',                       # bzr insists on creating files holding default values
    '~/.bzr.log',
    '~/.cache/BraveSoftware/',          # Brave browser cache
    '~/.cache/calibre',
    '~/.cache/chromium/',               # Chromium cache
    '~/.cache/Cypress',
    '~/.cache/electron/',
    '~/.cache/hugo_cache',
    '~/.cache/iridium/Default/Cache/',                      # Iridium cache
    '~/.cache/iridium/Default/Code Cache/',                 # Iridium cache
    '~/.cache/mesa/',
    '~/.cache/mesa_shader_cache/',
    '~/.cache/ranger/',                 # ranger image/video previews' cache
    '~/.cache/thorium/Default/Cache/',                      # Thorium browser cache
    '~/.cache/thorium/Default/Code Cache/',                 # Thorium browser cache
    '~/.cache/thumbnails/'              # thumbnails
    '~/.cache/vivaldi/',                # Vivaldi browser cache
    '~/.cache/vivaldi/Default/Service Worker/CacheStorage/',                # Vivaldi browser cache
    '~/.cache/zen',                     # Zen browser cache
    '~/.cargo/registry/',               # Cargo rust's cache
    '~/.config/chromium/Default/Service Worker/CacheStorage/', # This neither
    '~/.config/Code - OSS/Cache/',      # VSCode cache
    '~/.config/Code - OSS/CachedData/',      # VSCode cache
    '~/.config/Code - OSS/Code Cache/', # VSCode cache
    '~/.config/Code - OSS/Service Worker/ScriptCache/', # VSCode cache
    '~/.config/Code - OSS/Service Worker/CacheStorage/', # VSCode cache
    '~/.config/enchant',
    '~/.config/iridium/Default/Service Worker/CacheStorage/', # Iridium cache
    '~/.config/Microsoft/Microsoft Teams/Code Cache/', # Teams cache
    '~/.config/thorium/Default/Service Worker/CacheStorage/',       # Thorium browser cache
    '~/.config/tutanota-desktop/Cache/',    # Tutanota cache
    '~/Desktop',                        # Firefox creates this
    '~/.dropbox-dist',
    '~/.esd_auth',
    '~/.gstreamer-0.10',
    '~/.local/share/recently-used.xbel',
    '~/.local/share/Trash/',            # various apps trash
    '~/.macromedia',                    # Flash crap
    '~/.mozilla/firefox/Crash Reports/', # Do we need these? I don't think so
    '~/.nv/',
    '~/.nvm/.cache/',
    '~/.openjfx/',
    '~/.pulse',
    '~/.recently-used',
    '~/.rustup/toolchains/',            # Rust toolchains, unsure if this is safe to remove though
    '~/.thumbnails/normal/',            # I don't care about thumbs...
    '~/.viminfo',                       # configured to be moved to ~/.cache/vim/viminfo, but it is still sometimes created...
]

NPMCACHEDIR="~/.npm/_cacache/"
GOBUILDCACHEDIR="~/.cache/go-build/"
GOMODCACHEDIR="~/.go/pkg/mod/"

def clean_go_build():
    """Go build caches can be removed with its own command. Running it instead of removing the directory manually"""

    go_build_cache_size = calculate_dir_size(GOBUILDCACHEDIR)
    go_mod_cache_size = calculate_dir_size(GOMODCACHEDIR)
    # If cache is empty already, skip cleaning
    print("Cleaning Go build cache...")
    print("Current cache size is %dMb" % (go_build_cache_size + go_mod_cache_size))
    if go_build_cache_size > 0 or go_mod_cache_size > 0:
        try:
            os.system("go clean -cache &> /dev/null")
            os.system("go clean -modcache &> /dev/null")
        except:
            print("An error occurred while trying to remove Go build cache")

        print("Cleaned Go build cache, freed %dKb of space" % int(go_build_cache_size + go_mod_cache_size / 1000))

def clean_npm():
    """Npm has a command, npm cache clean --force, to actually clean its cache. Running it instead of removing the directory manually"""

    npm_cache_size = calculate_dir_size(NPMCACHEDIR)
    print("Cleaning NPM cache...")
    print("Current cache size is %dMb" % npm_cache_size)
    # If cache is empty already, skip cleaning
    if npm_cache_size > 0:
        try:
            os.system("npm cache clean --force &> /dev/null")
        except:
            print("An error occurred while trying to remove NPM cache")

        print("Cleaned npm cache, freed %dKb of space" % (int(npm_cache_size)/1000))


def calculate_dir_size(directory):
    """Walk through each directory and subdirectory of a path and calculate the total size of directories + files in it"""
    size = 0
    absolutepath = os.path.expanduser(directory)
    if os.path.isdir(absolutepath):
        for (dirpath, dirnames, filenames) in os.walk(absolutepath):
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
