#!/bin/sh

# Mount a local encrypted partition (with cryptsetup)

MAPPER='private'
CRYPTS=$(which cryptsetup)
PWDTMP="/tmp/pwd.tmp"
DIR='/media/private'
PARTITION='/dev/disk/by-uuid/9bfb2faa-b1bb-4a18-b500-e4a2e344267e'
GONOTIFY=$(which go-notify-me)

case $1 in
    umount) sudo systemctl stop mpd.service && pkill go-notify-me;
		sudo umount -f $DIR
		wait
	    sudo $CRYPTS luksClose $MAPPER
		sudo rm -rf $DIR
	    ;;
	*) if [ -b /dev/mapper/$MAPPER ]; then
		sudo $CRYPTS luksClose $MAPPER;
		sudo systemctl stop mpd.service && pkill go-notify-me;
	    else
			if [ ! -d $DIR ]; then
				sudo mkdir -p $DIR
			else
				if [[ $DISPLAY != '' ]]; 
					then
					sudo $CRYPTS luksOpen $PARTITION $MAPPER
					sudo mount /dev/mapper/$MAPPER $DIR
					if [ $? -eq 0 ]; then
						# start the mpd demon
						sudo systemctl start mpd.service
						$GONOTIFY &>> ~/.xsession-errors &
						notify-send "Private partition mounted and ready!"
					else
						exit 1
					fi
				else
					sudo $CRYPTS  luksOpen $PARTITION $MAPPER
					sudo mount /dev/mapper/$MAPPER $DIR
					if [ $? -eq 0 ]; then
						sudo systemctl start mpd.service
						$GONOTIFY &>> ~/.xsession-errors &
						notify-send "Private partition mounted and ready!"
					else
						exit 1
					fi
				fi
			fi
	    fi
	    ;;
esac
