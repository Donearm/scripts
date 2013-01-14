#!/bin/bash

# Remove all thumbnails directory under a path

if [ ! -z "$1" ]; then
	DIR="$1"
else
	DIR="$PWD"
fi

find "$DIR" -name "*.thumbnails" -type d -exec rm -rf {} \;

exit 0
