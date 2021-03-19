#!/bin/sh

# Script to increase/decrease the backlight brightness on any device. 
# Just set the correct path in $FILE for your system
#
# Notice: must be run as root or with sudo
#
set -e

FILE="/sys/class/backlight/amdgpu_bl0/brightness"
CURRENTBRIGHTNESS=$(cat "$FILE")
NEWBRIGHTNESS=$CURRENTBRIGHTNESS

if [[ -z "$2" ]]; then
	echo "No number increase or decrease given, please provide one, exiting..."
	exit 1
fi

if [ "$1" == "-inc" ]; then
	NEWBRIGHTNESS=$(( $CURRENTBRIGHTNESS + $2 ))
elif [ "$1" == "-dec" ]; then
	NEWBRIGHTNESS=$(( $CURRENTBRIGHTNESS - $2 ))
else
	echo "Use '-inc' or '-dec'. Nothing to do"
	exit 1
fi

echo "$NEWBRIGHTNESS" | tee "$FILE"

exit 0
