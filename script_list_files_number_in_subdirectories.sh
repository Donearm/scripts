#!/bin/bash

# A quick script to list only the number of files in all the 
# subdirectories of the given ($1) directory. Adding a second argument, 
# "large", will make the script print only subdirectories that contain 
# more than 1 file

DIR="$1"

for d in $(find $DIR -mindepth 1 -maxdepth 1 -type d); do
	n=$(find "$d" -type f -print | wc -l)
	if [ "$2" == "large" ]; then
		# if we want to know if subdirectories have more than 1 file
		if [ $n -ge 2 ]; then
			echo "Directory $d has $n files in it"
		fi
	else
		# if not "large" argument was given, print all subdirectories
		echo "Directory $d has $n files in it"
	fi
done

exit 0
