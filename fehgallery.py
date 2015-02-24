#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
"""
Feed the image opened on the command-line or via a filemanager to feh and
orders all the other images in the same directory alphabetically but always
starting at the chosen one (the first argument to the script, basically). 
"""


__author__ = "Gianluca Fiore"
__license__ = "GPL"
__version__ = "1.3"
__date__ = "03/02/2011"
__email__ = "forod.g@gmail.com"
__status__ = "Stable"


from os import chdir, listdir, getcwd, path, remove
from os.path import dirname, basename, abspath
import sys
import re
import subprocess

# Compile the regexp to catch all images in the directory
RImages = re.compile(".*\.[tjgp][pin][e]?[gf]", re.IGNORECASE)
RFilelist = re.compile("feh.*_filelist", re.IGNORECASE)
# two regexps to search for single or double quotes and for spaces in a filename
RQuote = re.compile(r"['\"]")
RSpaces = re.compile(r"\s+")


def launch_gallery(stringlist, stringlist_ending=''):
    """
    Run feh on the final string
    --scale-down will scale the images to screen size (if larger)
    """
    try:
        gallery = subprocess.Popen("feh %s" % stringlist, shell=True)
        #gallery.wait() # wait for the first list of files to close
        if stringlist_ending:
            # run the second part (the above 800 files)
            gallery_ending = subprocess.Popen("feh %s" % stringlist_ending, shell=True)
            gallery_ending.wait()
    #    subprocess.call(["feh %s" % finalstring])
    except:
        print(sys.exc_info())
        sys.exit(1)
    finally:
        # append, if any, feh filelists to a new list
        fehfilelist = [f for f in listdir(getcwd()) if RFilelist.match(f)]

        # if there are feh filelists, remove them
        if fehfilelist:
            for f in fehfilelist:
                remove(f)

        sys.exit(0)


# first file is the file inserted on the command line
firstfile = sys.argv[1]
# the directory of the first file
base_dir = dirname(abspath(firstfile))
# chdir to base directory to evade "OSError: File name too long" errors
chdir(base_dir)

# Append images to list
listf = [f for f in listdir(getcwd()) if RImages.match(f)]

# sort the list of files
sortedlistf = sorted(listf)
# the name of the file which is to be seen for first
indexfile = basename(firstfile)

# first method: iterate over sortedlistf and when matching the indexfile add it
# to flistA and then add all its followers. Before stumbling upon the
# indexfile, append each item to flistB and then merge the 2 lists in finallist
#flistA = []
#flistB = []
#finallist = []
## Search the list for the indexfile
#for f in sortedlistf:
#    if match(f, indexfile) and len(flistA) == 0:
#        flistA.append(f)
#    elif len(flistA) != 0:
#        flistA.append(f)
#    else:
#        flistB.append(f)
#
#finallist.extend(flistA)
#finallist.extend(flistB)


# second method: check if indexfile is present, and use the position of it as a
# splitting point. This method is very slighlty faster albeit I prefer the
# first one.
if indexfile in sortedlistf: 
    # save the count of elements in the list
    lengthList = len(sortedlistf)
    # save the index number, or current location, of the index file
    filenumber = sortedlistf.index(indexfile)

    # 2 empty lists that will contain the final list
    flist1 = []
    flist2 = []
    # and the final list
    finallist = []
    flist1 = sortedlistf[filenumber:]
    flist2 = sortedlistf[:filenumber]
    finallist.extend(flist1)
    finallist.extend(flist2)
else:
    print("Something wrong happened, I'm sorry...")
    sys.exit(1)

completefinallist = []
# Add the path to every item in the final list
for names in finallist:
    filenames = path.join(getcwd(), names)
    # escape any problematic character in the directory and/or filenames
    sub_filenames = re.sub(r'([\s\'\"\(\)\[\]\&\=\$\\])', r'\\\1', filenames)
    completefinallist.append(sub_filenames)

# join the final list in a long, single string
# 
# check first that the final list contains less than 800 files; if it's bigger
# split it in two list to be fed to feh one after the other. We do this because
# there is a OSError: "argument list too long" when dealing with more than 800
# files at once.
# Currently disabled because I can't narrow down the exact reason of the OSError,
# often more than 1000 images can load fine and other times only 850 don't
#if len(completefinallist) >= 800:
#    finalstring = " ".join(["%s" % k for k in tuple(completefinallist[:799])])
#    finalstring_ending = " ".join(["%s" % k for k in tuple(completefinallist[800:])])
#    # launch feh gallery
#    launch_gallery(finalstring, finalstring_ending)
#else:
finalstring = " ".join(["%s" % k for k in tuple(completefinallist)])
# launch feh gallery
launch_gallery(finalstring)
