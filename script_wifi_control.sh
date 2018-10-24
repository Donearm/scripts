#!/bin/bash

# Shutdown the Atheros wifi card on the Asus 1005H

INT='wlan0'
MODULE='ath9k'

case $1 in:
	off)
	sudo /etc/rc.d/wicd stop
	sudo iwconfig $INT txpower off
	sudo ifconfig $INT down
	sudo rmmod $MODULE
	;;
	on)
	sudo modprobe $MODULE
	sudo ifconfig $INT up
	sudo /etc/rc.d/wicd start
	;;
	*)
	echo "Usage: $0 on|off"
	;;

exit 0
