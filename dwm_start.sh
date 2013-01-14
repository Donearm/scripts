#!/bin/bash

# Start script for dwm with statusbar info too

eval `cat ~/.fehbg`

xbindkeys
xset m 1 1
slock &

urxvtd -q -o -f
if [ $? -eq 0 ]; then
	urxvtc
fi

stalonetray &
volwheel &


while true
do
	echo `date +"[%a %d %b] [%H:%M:%S]"`
	sleep 2
done &
exec dwm
