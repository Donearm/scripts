#!/bin/sh

# Extract url and title from an article read in newsbeuter and save them
# in a file (articles_to_share)
# Use the "pipe-to" command from newsbeauter to feed the article to this
# script

TMPFILE=$(mktemp)

cat - > $TMPFILE

TITLE=$(grep 'Titolo:' $TMPFILE | sed 's/Titolo: //g')
URL=$(grep 'Collegamento:' $TMPFILE | sed 's/Collegamento: //g')

echo "$TITLE $URL" >> articles_to_share

exit 0
