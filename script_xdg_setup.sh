#!/bin/sh
#
# Raw and quick script to set up the file's association for xdg-open

IMAGEVIEWER="imv.desktop"
VIDEOPLAYER="mpv.desktop"
EBOOKREADER="com.github.johnfactotum.Foliate.desktop"
DOCREADER="apvlv.desktop"

xdg-mime default "${BROWSER}.desktop" text/html
xdg-mime default "${BROWSER}.desktop" application/x-extension-xht
xdg-mime default "${BROWSER}.desktop" application/x-extension-xhtml
xdg-mime default "${BROWSER}.desktop" application/xhtml+xml
xdg-mime default "${BROWSER}.desktop" application/x-extension-htm
xdg-mime default "${BROWSER}.desktop" application/x-extension-html

xdg-mime default $IMAGEVIEWER image/jpeg
xdg-mime default $IMAGEVIEWER image/pjpeg
xdg-mime default $IMAGEVIEWER image/png
xdg-mime default $IMAGEVIEWER image/gif
xdg-mime default $IMAGEVIEWER image/*

xdg-mime default $VIDEOPLAYER video/mp4
xdg-mime default $VIDEOPLAYER video/mkv
xdg-mime default $VIDEOPLAYER video/mpeg
xdg-mime default $VIDEOPLAYER video/*

xdg-mime default $VIDEOPLAYER audio/*

xdg-mime default $EBOOKREADER application/epub+zip

xdg-mime default $DOCREADER application/pdf
