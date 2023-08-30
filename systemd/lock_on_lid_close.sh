#!/bin/sh
#
# A systemd post/pre hook to lock the screen under Wayland before and 
# after suspend

case $1 in
	pre)
		# Do the thing you want before suspend here, e.g.:
		if [ ! -z $WAYLAND_DISPLAY ]; then
		# We are under Wayland, lock screen with swaylock
		su gianluca -c "DISPLAY=:0 swaylock -i ~/documents/Camera_images/0000DROPBOX/Hvar-IMG_3407.jpg --indicator-idle-visible"
		else
			su gianluca -c "DISPLAY=:0 i3lock \
			--blur 7 --bar-indicator --bar-pos y+h --bar-direction 1 --bar-max-height 50 \
			--bar-base-width 50 --bar-color 1cd2ee --bar-periodic-step 50 --bar-step 50 \
			--keyhl-color fffefe --redraw-thread --clock --force-clock \
			--time-pos x+5:y+h-80 --time-color 3e999f --time-align 1 \
			--date-pos tx:ty+15 --date-color 3e999f --date-align 1 \
			--ringver-color ff0021 --ringwrong-color ff0021 --status-pos x+5:y+h-16 \
			--verif-align 1 --wrong-align 1 --verif-color ffffff --wrong-color ffffff \
			--modif-pos -50:-50"
		fi
	;;
	post)
		# Do the thing you want after resume here, e.g.:
		if [ ! -z $WAYLAND_DISPLAY ]; then
		# We are under Wayland, lock screen with swaylock
		su gianluca -c "DISPLAY=:0 swaylock -i ~/documents/Camera_images/0000DROPBOX/Hvar-IMG_3407.jpg --indicator-idle-visible"
		else
			sleep 1
			su gianluca -c "DISPLAY=:0 i3lock \
			--blur 7 --bar-indicator --bar-pos y+h --bar-direction 1 --bar-max-height 50 \
			--bar-base-width 50 --bar-color 1cd2ee --bar-periodic-step 50 --bar-step 50 \
			--keyhl-color fffefe --redraw-thread --clock --force-clock \
			--time-pos x+5:y+h-80 --time-color 3e999f --time-align 1 \
			--date-pos tx:ty+15 --date-color 3e999f --date-align 1 \
			--ringver-color ff0021 --ringwrong-color ff0021 --status-pos x+5:y+h-16 \
			--verif-align 1 --wrong-align 1 --verif-color ffffff --wrong-color ffffff \
			--modif-pos -50:-50"
		fi
esac
