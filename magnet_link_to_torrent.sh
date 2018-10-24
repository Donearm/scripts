#!/bin/bash

# echo a magnet link to a torrent file

WATCHDIR='/media/private/torrent/watch' # set your watch directory here

cd $WATCHDIR || exit
[[ "$1" =~ xt=urn:btih:([^&/]+) ]] || exit
hashh=${BASH_REMATCH[1]}
if [[ "$1" =~ dn=([^&/]+) ]];then
	filename=${BASH_REMATCH[1]}
else
	filename=$hashh
fi

if [[ "$2" == 'vids' ]]; then
	directory="${WATCHDIR}/vids/"
elif [[ "$2" == 'books' ]]; then
	directory="${WATCHDIR}/books/"
elif [[ "$2" == 'music' ]]; then
	directory="${WATCHDIR}/music/"
else
	directory="${WATCHDIR}/others/"
fi

echo "d10:magnet-uri${#1}:${1}e" > "${directory}meta-$filename.torrent"
