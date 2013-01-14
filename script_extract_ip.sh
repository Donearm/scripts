#!/bin/bash
#
# Script to extract just the URLs from a file
#
# needs 2 arguments: the source and the output file
#
INFILE="$1"
OUTFILE="$2"
AFFIX="_2"
cat "$INFILE" | tr -c "[0-9.]" "\n" \
| grep "[1-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[1-9][0-9]*" \
| sort | uniq -c | sort -rn > "$OUTFILE"
read -p "Do you want to remove the number of occurrences? "
case "$keypress" in
	yY) cat "$OUTFILE" | sed 's/\ [0-9]\{1,2\}\ //g' > {$OUTFILE}"$AFFIX"
	;;
	nN) echo "As you wish."
	;;
esac
exit 0

