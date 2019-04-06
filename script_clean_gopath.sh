#!/bin/sh

# Go clean archive files and executable binaries from go install and go 
# get in $GOPATH

PACKAGES=$(find "${GOPATH}src/" -mindepth 1 -maxdepth 2 -type d -print)

GOPATHSIZE=$(du -hs ${GOPATH} | cut -f1)

echo "GOPATH size before cleaning = " $GOPATHSIZE

for p in $PACKAGES; do
	echo $p;
	go clean -i $p;
done

NEWGOPATHSIZE=$(du -hs ${GOPATH} | cut -f1)

echo "GOPATH size after cleaning = " $NEWGOPATHSIZE
