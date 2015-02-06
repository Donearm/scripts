#!/bin/bash
#________________________________________________________________________________
#
#				    RIPENCODE
#________________________________________________________________________________
#
#		Automatically rip cd audio tracks to wav and then ask 
#			    for further encoding to mp3, ogg or flac
#________________________________________________________________________________
#
# Requirements: cdrkit, dialog, lame, vorbis-tools, flac
#
# Copyright: 2009-2015, Gianluca Fiore <forod.g@gmail.com>
#
# Setting a couple of variables
CDDRIVE=/dev/sr0
CDSCAN="1000,0,0"
BADARGS="Error! Type 1 for mp3, 2 for ogg, 3 for flac or 4 for just wav"
ENCODINGAUTHOR="Encoded by Gianluca Fiore"
#
# Ask to save in a crypted partition or no
read -e -p "Do you want to save files in an encrypted directory? (y/n) " CRYPT
case  $CRYPT in
    'y') OUTDIR='/media/private/tmp_ripping'
    ;;
    'n') OUTDIR='/mnt/d/Mp3'
    ;;
esac
# Check if OUTDIR exists, if not create it
if [ ! -d $OUTDIR ]
then
    echo "Creating directories needed"
    mkdir $OUTDIR
fi

cd $OUTDIR
echo 'Starting ripping the CD'
dialog --infobox "Please Wait" 4 12
sudo cdda2wav -B -cuefile -paranoia -c s -L 0 dev=$CDDRIVE $OUTDIR

WAVFILE=$( find $OUTDIR -name "*.wav" )

read -s -n1 -p \
"Select encoding type: Hit(1) for mp3, (2) for ogg, (3) for flac\n
(you can also press (4) for keeping the wav files) " \
keypress
echo

case "$keypress" in
    1 ) for i in $WAVFILE; do lame -m j --preset insane --silent -h -v -V 2 \
    -B 320 --tc $ENCODINGAUTHOR $i ${i%%.wav}.mp3; done 
    ;;
    2 ) oggenc -Q -q 9 $WAVFILE -X .wav -P .ogg ;;
    3 ) flac -V --replay-gain -8 -T "artist=%a" -T "title=%t" -T \
    "album=%g" -T "date=%y" -T "tracknumber=%n" -T "genre=%m" $WAVFILE
    ;;
    4 ) exit 0
    ;;
    * ) echo $BADARGS 
	exit 1;;
esac

# remove the wavs
find $OUTDIR -name "*.wav" -exec rm -f {} \;
    
dialog --msgbox "Encoding completed. Have fun!" 8 24

exit 0
