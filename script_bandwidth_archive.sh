#!/bin/bash

PROCDEV='/proc/net/dev'
ETH='eth0'
OUTFILE="$HOME/.tiddlywiki/data/bandwidth_statistics.txt"
BCKPFILE="/mnt/documents/Stuff/net_data_statistics.txt"

TOTDOWN=`grep $ETH $PROCDEV | awk '{print $2}' | sed 's/\(.*\:\)\([0-9]*\)/\2/g'`
TOTUP=`grep $ETH $PROCDEV | awk '{print $10}'`

# Data goes to a file available to tiddlywiki
#echo "Stats for `date +%Y%m%d`" >> $OUTFILE
#echo "Transmitted data : $(($TOTUP/1000)) kB" >> $OUTFILE
#echo "Received data : $(($TOTDOWN/1000)) kB" >> $OUTFILE
#echo "" >> $OUTFILE

# Save the totals in kilobytes and check if they are enough to be
# recorded ( > 0)
UPKB=$(($TOTUP/1000))
DOWNKB=$(($TOTDOWN/1000))

if [[ $UPKB == '0' || $DOWNKB == '0' ]]; then
	# no much data, just exit
	exit 1
else
	# Copy the data in a backup file, different string too
	echo "`date +%Y%m%d`: Up[$(($TOTUP/1000)) kB] Down[$(($TOTDOWN/1000)) kB]" \
	>> $BCKPFILE
fi


exit 0
