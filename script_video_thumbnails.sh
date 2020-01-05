#!/bin/bash
#
# Make an image of a collection of thumbnails taken from a video, adding
# informations like file name, resolution, lenght and codec of it.
# It's possible to customize the number of thumbnails to go into the
# final image (default 16, a multiple of 4 looks best)
#
# copyright 2015-2020, Gianluca Fiore <forod.g@gmail.com>
#
# Requirements: mplayer, bc, awk, grep, imagemagick, cut

# MPlayer options
MP_OPTIONS='-nosound -vo null -really-quiet -identify'
# Font to use for the informations in final thumbnail
FONT='/usr/share/fonts/TTF/DejaVuSans-Bold.ttf'

if [ "$1" == '-h' ]; then
	# printing usage informations
	echo "Usage:

	script_video_thumbnails.sh some_video number_of_thumbs

	some_video = video from which we want to create the thumbnails
	number_of_thumbs = as it says, default is 16

	Use \"-h\" to print this help"
	echo ""
	exit 0
fi

if [ -z "$1" ]; then
	read -e -p "Insert a video to generate thumbnails from: " VIDEO
else
	VIDEO="$1"
fi

# how many thumbs we want
if [ -n "$2" ]; then
	DIVIDER="$2"
else
	DIVIDER=16
fi

# Ask where to output the thumbnails
read -e -p "Where do you want your thumbnails? " THUMBDIR
THUMBDIR="${THUMBDIR:=$HOME/thumbs}" # defaults to ~/thumbs if THUMBDIR
									# is empty
# we need the filename without extensions for a correct name of the
# final thumbnail
VID_EXTENSION=`echo $(basename "$VIDEO") | sed 's/\.[a-zA-Z0-9]\{,3\}$//g'`

VID_LENGTH=`mplayer $MP_OPTIONS -ss 00:00 -frames 1 "$VIDEO" 2>/dev/null | \
grep ID_LENGTH | awk -F= '{print $2}'`
VID_WIDTH=`mplayer $MP_OPTIONS -ss 00:00 -frames 1 "$VIDEO" 2>/dev/null | \
grep ID_VIDEO_WIDTH | awk -F= '{print $2}'`
VID_HEIGHT=`mplayer $MP_OPTIONS -ss 00:00 -frames 1 "$VIDEO" 2>/dev/null | \
grep ID_VIDEO_HEIGHT | awk -F= '{print $2}'`
VID_FORMAT=`mplayer $MP_OPTIONS -ss 00:00 -frames 1 "$VIDEO" 2>/dev/null | \
grep ID_VIDEO_FORMAT | awk -F= '{print $2}'`
VID_SIZE=`du -h "$VIDEO" | awk '{print $1}'`

INTERVAL=`echo ${VID_LENGTH}/$DIVIDER | bc -l | awk -F. '{print $1}'`

# obtain the effective length of the video (in the 00:00 format)
#
# i minuti
L_MIN=`echo ${VID_LENGTH}/60 | bc -l | awk -F. '{print $1}'`
# i secondi (formato mplayer)
P_SEC=`echo ${VID_LENGTH}/60 | bc -l | awk -F. '{print $2}' | cut -c 1-5`
# i secondi (formato :00)
L_SEC=`echo ${P_SEC}*60/100 | bc -l | cut -c 1-2`

# save $interval so іt won't be overridden by the let addition in the
# for cicle
BASE_INTERVAL=$INTERVAL

# Create a directory for hosting and managing the thumbs
if [ -d $THUMBDIR ]; then
	rm -f $THUMBDIR/*
else
	mkdir -p $THUMBDIR
fi

# Create the thumbs
for n in `seq 1 $DIVIDER` ; do
	mplayer -nosound -noaspect -vf spp,scale -vc , -vo jpeg:optimize=0:quality=100:outdir=${THUMBDIR} -ss $INTERVAL -frames 1 "$VIDEO";
	let INTERVAL=$INTERVAL+$BASE_INTERVAL;
	# rename the thumb
	mv ${THUMBDIR}/0*.jpg ${THUMBDIR}/$n-${INTERVAL}.jpg;
done

# move to the thumbs directory and generate the montage of all of them
cd $THUMBDIR
montage ./*.jpg -tile 4x -background black -geometry 300x300+2+2 \
-font $FONT -pointsize 8 -fill white \
-title "$(basename "$VIDEO") - ${VID_SIZE}B - ${VID_WIDTH}x${VID_HEIGHT} - ${L_MIN}:${L_SEC}" \
"${VID_EXTENSION}".jpg


# These two command create a shadow instead
THUMB_SIZE=`convert -identify "${VID_EXTENSION}".jpg "${VID_EXTENSION}".jpg | awk '{print $3}'`
montage -shadow -geometry ${THUMB_SIZE}+10+10 "${VID_EXTENSION}".jpg "${VID_EXTENSION}".jpg

echo ""
echo "Everything done, you can find your thumbs in $HOME/thumbs/"
echo ""
exit 0
