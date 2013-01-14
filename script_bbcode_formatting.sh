#!/bin/bash

# Format every file containing bbcode under a path to be ready to be
# posted on a forum or blog.
# This means: 

# every image in a bbcode will have a single space between it and the
# following (1)
#
# there won't be any space at the beginning of any line containing
# bbcode (2)
#
# there will be a single empty line between the end of the code and the 
# link containing the source (the row starting with "fonte:" or
# "credits:" (3)
#
# there will be an empty line at the start of the file and there won't
# be any multiple consecutive ones (4)
#
# any <br> tag in the html code will be removed (5)
#
# there will be a space after every image (<a> tag) in the html code (6)

STARTDIR="$1"
SEDEXP1='s/\(\/URL\]\)[^\[]*\(\[URL\)/\1 \2/g' # (1)
SEDEXP2='s/^[ \t]*//g' # (2)
SEDEXP3='/^$/N;/\n$/D' # (3)
SEDEXP4='/./,/^$/!d;1 s/^/\n/' # (4)
SEDEXP5='s/<br>//g' # (5)
SEDEXP6='s/\(<\/a>\)[^<]*\(<a\)/\1 \2/g' # (6)
FILES=`find "${STARTDIR}" -maxdepth 2 -name "source.txt" -o -name "0000"`


cat $PROVA1

# Big sed expression. (1) at the end because as first doesn't work
sed -i -e '
/^$/N;/\n$/D
/./,/^$/!d
1 s/^/\n/
s/<br>//g
s/\(<\/a>\)[^<]*\(<a\)/\1 \2/g
s/^[ \t]*//g
s/\(\/URL\]\)[^\[]*\(\[URL\)/\1 \2/g
' $PROVA1

exit 0
