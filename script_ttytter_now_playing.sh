#!/bin/sh

# Script to capture info on currently playing song in MPD, add an 
# (optional) prefix and/or suffix and tweet it all via TTYtter (which 
# must be of course already been configured)
#
# Dependencies: TTYtter, a MPD client that can output song info (I use 
# ncmpcpp)

RC='-donearm'
PREFIX='on air: ' # what should go before the now playing string
SUFFIX=' #NP' # what should go after the now playing string
# save the now playing string from the mpd client of choice (it and 
# format can be of course changed according to one's tastes
NP=$(ncmpcpp --now-playing "%a - %t")

if [[ -z $NP ]]; then
	echo "Can't get the current song, is MPD playing?"
	echo "Or perhaps the MPD client isn't working/displaying song info correctly?"
	exit 1
else
	continue
fi

STATUS="♫ ${PREFIX}${NP}${SUFFIX} ♫"
echo $STATUS
sleep 2 # brief pause to let the user interrupt the script
ttytter -rc=$RC -script -status="$STATUS"
exit 0
