#!/bin/bash

# Main interval in seconds
INTERVAL=1

# The various functions
#
# Date
DATEFORMAT='%A %d %B %T'
fdate() {
	date "+$DATEFORMAT"
}

# Hostname and kernel
fhost() {
	echo $(uname -n && uname -r)
}

# Cpu temp
fcputemp() {
	echo "$(cat /proc/acpi/thermal_zone/THRM/temperature | cut -c 26-27)°C"
}

# Cpu usage (combined for multiple cores)
fcpuusage() {
	echo "$(top -n 1 | grep Cpu | awk '{print $2}' | sed 's/[us,].*$//g')"
}

# Hd temp 1
fhdtemp1() {
	echo $(sudo hddtemp /dev/sda -n)°C 
}

# Hd temp 2
fhdtemp2() {
	echo $(sudo hddtemp /dev/sdb -n)°C
}

# Gpu temp
fgputemp() {
	echo $(nvidia-settings -q gpucoretemp | grep Attribute | awk '{print $4}' | tr -d .)°C
}

# Mail notifier
# -- currently not working --
NEWMAILDIRS=$(find ${MAIL} -type d -name "*new")
fmail() {
	for d in "$NEWMAILDIRS"; do
		ls $d ;
	done
}


# Main loop
DATECOUNTER=$INTERVAL
CPUCOUNTER=$INTERVAL
HDCOUNTER=$INTERVAL
GPUCOUNTER=$INTERVAL

while true; do
#	if [[ $DATECOUNTER -ge $INTERVAL ]]; then
#		PDATE=$(fdate)
#		DATECOUNTER=0
#	fi

#	if [[ $CPUCOUNTER -ge $INTERVAL ]]; then
#		PCPUTEMP=$(fcputemp)
#		CPUCOUNTER=0
#	fi

#	if [[ $HDCOUNTER -ge $INTERVAL ]]; then
#		PHDTEMP=$(fhdtemp)
#		HDCOUNTER=0
#	fi

	#if [[ $GPUCOUNTER -ge $INTERVAL ]]; then
#		PGPUTEMP=$(fgputemp)
#		GPUCOUNTER=0
#	fi
	PDATE=$(fdate)
	PHOST=$(fhost)
	PCPUTEMP=$(fcputemp)
	PCPUUSAGE=$(fcpuusage)
	PHDTEMP1=$(fhdtemp1)
	PHDTEMP2=$(fhdtemp2)
	PGPUTEMP=$(fgputemp)

	# Icons
	ICONTUX="^i(/home/gianluca/.icons/dzen/tux.xpm)"
	ICONCALENDAR="^i(/home/gianluca/.icons/dzen/calendar.xpm)"
	ICONCPU="^i(/home/gianluca/.icons/dzen/cpu.xpm)"
	ICONHD="^i(/home/gianluca/.icons/dzen/hard-disk.xpm)"
	ICONNVIDIA="^i(/home/gianluca/.icons/dzen/nvidia.xpm)"

	# Order and print the status line
	echo "$ICONTUX ${PHOST} $ICONCALENDAR ^fg(white)${PDATE}^fg() \
	$ICONCPU $PCPUTEMP/$PCPUUSAGE $ICONHD $PHDTEMP1|$PHDTEMP2 $ICONNVIDIA $PGPUTEMP"
	#echo "^fg(white)fdate^fg() fcputemp fhdtemp fgputemp"

	#$CPUCOUNTER=$((CPUCOUNTER+1))
	#$HDCOUNTER=$((HDCOUNTER+1))
	#$GPUCOUNTER=$((GPUCOUNTER+1))

	sleep $INTERVAL
done | dzen2 -fn '-*-liberation sans-medium-r-*-*-12-*-*-*-*-*-*-*' -bg '#1b1213' -fg '#e9e8e3' -w 1680 -x 1050 -ta r 
