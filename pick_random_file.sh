#!/bin/sh

# Return a random number picked among those present in a path with a 
# chosen extension, or any kind at all

DIR="$1"
EXT='jpg'

IFS=$'\n'
# Count the files in DIR that matches the given EXT
if [ -z $EXT ]; then
	# if not EXT set, pick any kind of file
	FILESCOUNT=$(find "$DIR" -type f | wc -l)
	# Capture all files in an array
	FILESLIST=($(find "$DIR" -type f))
else
	FILESCOUNT=$(find "$DIR" -type f -name "*.${EXT}" | wc -l)
	# Capture all files in an array
	FILESLIST=($(find "$DIR" -type f -name "*.${EXT}"))
fi
unset IFS

# Choose a random number between 1 and the total files' count
n=$RANDOM
let "n %= $FILESCOUNT"

CHOSEN=${FILESLIST[$n]}

echo $CHOSEN
