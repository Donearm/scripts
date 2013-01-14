#!/bin/bash

# Remove vim undo files referring to non-existent any more files

UNDODIR="$HOME/.vim/undodir/"

# save and change IFS
OLDIFS=$IFS
IFS=$'\n'

fileArray=($(find "$UNDODIR" -type f -print))

# restore IFS
IFS=$OLDIFS


for e in "${fileArray[@]}" ;
do
	UNDOPATH=`echo $e | sed -e 's:'"${UNDODIR}"'::; s:%:/:g'`
	if [[ -f "$UNDOPATH" ]];
	then
		continue
	else
		rm -f "$e"
	fi
done


exit 0
