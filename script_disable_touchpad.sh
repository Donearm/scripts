#!/bin/sh
list=`xinput --list | grep -i 'Lachesis'`

if [ ${#list} -eq 0 ]; then
	exec  `synclient touchpadoff=0`
	notify-send -t 1500 "Touchpad on" "Mouse not present"
else
	exec `synclient touchpadoff=1`
	notify-send -t 1500 "Touchpad off" "Mouse present"
fi
