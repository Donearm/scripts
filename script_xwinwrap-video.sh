#!/bin/bash
#
# Use a video as desktop background

xwinwrap -ni -o 0.9 -fs -s -st -sp -b -nf -- \
mplayer -wid WID -quiet -nosound -loop 0 -noframedrop -vo gl2 "$1" &

exit 0
