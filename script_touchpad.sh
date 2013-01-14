#!/bin/sh

# Disable or enable the touchpad

SYNCLIENT=`which synclient`

case $1 in
	on)
	$SYNCLIENT TouchpadOff=0
	;;
	off)
	$SYNCLIENT TouchpadOff=1
	;;
	*)
	exit 1
	;;
esac

exit 0

