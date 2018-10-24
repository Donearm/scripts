#!/bin/bash

# Copy the given music directory to the android device (usually in
# /mnt/sdcard/Music/)
# Requires Android Sdk (adb) and the transferring of files via wifi
# enabled

ANDROIDIP='192.168.1.5'
ADB=$(which adb)


function usage ()
{
	echo "Usage:"
	echo "script_music_to_android.sh DIRECTORY"
	echo "default is to copy given directory to android device"
	echo ""
	echo "-l	Lists file and directories under Music/"
	echo "-r	Remove the directory with the same name"
	echo "-h	for this help"
}

function copy_dir ()
{
	DIRNAME=$(basename "${directory}")
	DESTDIR="/mnt/sdcard/Music/${DIRNAME}"
	$ADB connect $ANDROIDIP
	$ADB shell mkdir $DESTDIR
	$ADB push ${directory} $DESTDIR
	$ADB disconnect
}

function show_dir ()
{
	$ADB connect $ANDROIDIP
	$ADB shell ls -l /mnt/sdcard/Music/
}

function remove_dir ()
{
	DIRNAME=$(basename "${directory}")
	DESTDIR='/mnt/sdcard/Music/'"$DIRNAME"
	$ADB connect $ANDROIDIP
	$ADB shell rm -r "${DESTDIR}"
	$ADB disconnect
}

case "${1}" in
	-h) usage
	;;
	-l) show_dir
	;;
	-r) if [[ ! -z "$2" ]]; then
			directory="${2}"
			remove_dir
		else
			read -ep "Which directory? " directory
			remove_dir
		fi
	;;
	*) if [[ ! -z "$1" ]]; then
			directory="${1}"
			copy_dir
		else
			read -ep "Where is the directory to copy? " directory
			copy_dir
		fi
	;;
esac

exit 0
