#!/bin/sh
#
# Raw and quick script to set up the file's association for xdg-open

IMAGEVIEWER="feh.desktop"
VIDEOPLAYER="mpv.desktop"
EBOOKREADER="org.pwmt.zathura.desktop"
DOCREADER="org.pwmt.zathura.desktop"

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
xdg-mime default $IMAGEVIEWER image/webp
xdg-mime default $IMAGEVIEWER image/*

xdg-mime default $VIDEOPLAYER video/mp4
xdg-mime default $VIDEOPLAYER video/mkv
xdg-mime default $VIDEOPLAYER video/mpeg
xdg-mime default $VIDEOPLAYER video/avi
xdg-mime default $VIDEOPLAYER video/x-msvideo
xdg-mime default $VIDEOPLAYER video/webm
xdg-mime default $VIDEOPLAYER video/*

xdg-mime default $VIDEOPLAYER application/ogg
xdg-mime default $VIDEOPLAYER audio/*

xdg-mime default $EBOOKREADER application/epub+zip

xdg-mime default $DOCREADER application/pdf
xdg-mime default $DOCREADER  application/postscript
# Djvu files open with Zathura (needs zathura-djvu package)
xdg-mime default $DOCREADER image/vnd.djvu
