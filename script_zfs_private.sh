#!/bin/sh

# Mount a local ZFS encrypted dataset

DATASET='zroot/data/private'
DIR='/mnt/private'
GONOTIFY=$(command -v go-notify-me)

function close_if_needed() {
	if $(systemctl --user is-active --quiet mpd.service); then
		# we run MPD and MPDScribble always together so it makes
		# sense to stop them together too
		systemctl --user stop mpd.service;
		systemctl --user stop mpdscribble.service;
		systemctl --user stop mpDris2.service;
	fi

	# Check also if we need to kill go-notify-me
	pidof go-notify-me >/dev/null && pkill go-notify-me;
}

function start_if_available() {
	if $(systemctl --user start mpd.service --quiet >/dev/null 2>&1); then
		if $(systemctl --user start mpdscribble.service --quiet >/dev/null 2>&1); then
			if $(systemctl --user start mpDris2.service --quiet >/dev/null 2>&1); then
				# Both MPD, MPDScribble and mpDris2 started successfully. Happy times
				return 0
			else
				# mpDris2 didn't start
				return 1
			fi
		else
			# MPDScribble didn't start
			return 1
		fi
	else
		# MPD didn't start
		return 1
	fi
}

case $1 in
	umount) close_if_needed
		sudo zfs unmount $DATASET
		sudo zfs unload-key $DATASET
		;;
	*) if [ ! -d $DIR ]; then
			sudo mkdir -p $DIR
		fi

		if [[ $DISPLAY != '' ]];
		then
			sudo zfs load-key $DATASET
			sudo zfs mount $DATASET
			if [ $? -eq 0 ]; then
				start_if_available
				if start_if_available; then
					$GONOTIFY &>> ~/.xsession-errors &
				fi
				echo -e "\nPrivate partition mounted and ready!"
			else
				exit 1
			fi
		else
			sudo zfs load-key $DATASET
			sudo zfs mount $DATASET
			if [ $? -eq 0 ]; then
				start_if_available
				if start_if_available; then
					$GONOTIFY &>> ~/.xsession-errors &
				fi
				notify-send "Private partition mounted and ready!"
			else
				exit 1
			fi
		fi
	;;
esac

exit 0
