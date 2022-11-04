#!/bin/sh
#
# Raw and quick script to set up the file's association for xdg-open

IMAGEVIEWER="imv-folder.desktop"
VIDEOPLAYER="mpv.desktop"
EBOOKREADER="org.pwmt.zathura.desktop"
DOCREADER="org.pwmt.zathura.desktop"
TEXTREADER="vim.desktop"

# Setting up a few arrays depending on the application we need
# mimetypes to be associated with
BROWSER_ARRAY=('text/html',
	'application/x-extension-xht',
	'application/x-extension-xhtml',
	'application/xhtml+xml',
	'application/x-extension-htm',
	'application/x-extension-html'
)
IMAGES_ARRAY=('image/jpeg',
	'image/pjpeg',
	'image/jpg',
	'image/png',
	'image/gif',
	'image/webp',
	'image/*'
)
VIDEOS_ARRAY=('video/mp4',
	'video/mkv',
	'video/mpeg',
	'video/x-msvideo',
	'video/webm',
	'video/*',
	'application/ogg',
	'audio/*'
)
DOCUMENTS_ARRAY=('application/pdf',
	'application/postscript',
# Djvu files open with Zathura (needs zathura-djvu package)
	'image/vnd.djvu',
	'image/x-djvu',
	'application/vnd.ms-excel',
	'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
	'application/vnd.ms-powerpoint',
	'application/vnd.openxmlformats-officedocument.presentationml.presentation',
	'application/msword',
	'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
)
TEXTS_ARRAY=('text/csv',
	'text/css',
	'text/javascript'
)

# Loop through each array and set default application for the mimetypes
for m in ${BROWSER_ARRAY[@]}; do
	xdg-mime default "${BROWSER}.desktop" $m
done
for m in ${IMAGES_ARRAY[@]}; do
	xdg-mime default $IMAGEVIEWER $m
done
for m in ${VIDEOS_ARRAY[@]}; do
	xdg-mime default $VIDEOPLAYER $m
done
for m in ${DOCUMENTS_ARRAY[@]}; do
	xdg-mime default $DOCREADER $m
done
for m in ${TEXTS_ARRAY[@]}; do
	xdg-mime default $TEXTREADER $m
done

xdg-mime default $EBOOKREADER application/epub+zip

exit 0
