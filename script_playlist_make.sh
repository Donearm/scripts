#!/bin/bash

# Script to create a playlist from a directory containing songs and
# converting, if found, flac files to ogg for easier use on music players

# Directory where to put ogg from flac files
DIR='/media/private/canzoni_cellulare/'

function usage ()
{
	echo "Usage:"
	echo "script_playlist_make.sh DIRECTORY"
	echo "-f	convert flacs to ogg"
	echo "-h	for this help"
}

function flactogg ()
{
	if [ -z "$1" ]; then
		echo "You should tell me the desired directory...."
		usage
		exit 1
	fi
	ORIG_DIR="${1}"
	NEW_DIR="${DIR}$(basename ${1})"
	if [ ! -d "$NEW_DIR" ]; then
		mkdir "${NEW_DIR}"
	fi
	cd "${NEW_DIR}"
	# convert each flac files from the original directory to this one
	# under $DIR
	for f in "${ORIG_DIR}"*.[fF][lL][aA][cC] ; do
		oggfile=$(basename "${f%%flac}"ogg)
		oggenc -q 2 -o "${oggfile}" "${f}" ;
	done
	# make the playlist
	ls *.ogg > $(basename $PWD).m3u
}


function playlister ()
{
# changedir into the first parameter and generate a m3u playlist
# named after the parent directory (which should be the name of the
# album)
	PLAYLIST="$(basename $1)".m3u
	if [ -z "$1" ]; then
		echo "You should tell me the desired directory...."
		usage
		exit 1
	fi
	cd "${1}"
	ls *.[MmOo][pPgG][3gG] > $PLAYLIST
	# Check if the playlist is empty (meaning that aren't any songs in
	# it). If it is, remove it
	if [ ! -s "$PLAYLIST" ]; then
		echo ""
		echo "Perhaps are you trying to make a playlist from flac files?"
		rm "$PLAYLIST"
	fi
}

case "${1}" in
	-h) usage
	;;
	-f) flactogg "${2}"
	;;
	*) playlister "${1}"
	;;
esac

exit 0
