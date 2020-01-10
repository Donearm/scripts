#!/bin/bash

if [ $# -ne 3 ];
then
	echo "Usage: $0 URL -d DIRECTORY"
	exit 1
fi

for i in {1..4}
do
	case $1 in
		-d) shift; DIRECTORY=$1; shift ;;
		*) URL=${URL:-$1}; shift;;
	esac
done

mkdir -p $DIRECTORY

BASEURL=$(echo $URL | egrep -o "https?://[a-z.]+")
curl -s $URL | egrep -o "<img src=[^>]*>" | sed 's/<img src=\"\([^"]*\).*/\1/g' > /tmp/download-images-$$.list
sed -i "s|^/|$BASEURL/|" /tmp/download-images-$$.list

cd $DIRECTORY

while read FILENAME;
do
	curl -s -O "$FILENAME" --silent
done < /tmp/download-images-$$.list

exit 0
