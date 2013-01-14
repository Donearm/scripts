#!/bin/bash

# Remove vim view files referring to non-existent any more files

VIEWDIR="$HOME/.vim/view/"

# save and change IFS
OLDIFS=$IFS
IFS=$'\n'

fileArray=($(find "$VIEWDIR" -type f -print))

# restore IFS
IFS=$OLDIFS


for e in "${fileArray[@]}" ;
do
	VIEWPATH=`echo $e | sed -e 's:=$::; s:'"${VIEWDIR}"'::; s:=+:/:g; s:~:'"$HOME"':'`
	if [[ -f "$VIEWPATH" ]];
	then
		continue
	else
		rm -f "$e"
	fi
done


exit 0
