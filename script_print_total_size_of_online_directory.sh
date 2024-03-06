#!/bin/bash

# Print size of a remote public directory without downloading it
# Only # the headers are downloaded, and then summed to print a total in MB
#
# From: https://unix.stackexchange.com/questions/743175/how-do-you-get-the-total-size-of-wget-recursive-without-downloading-all-the-file

directory='https://the-eye.eu/public/Books/rpg.rem.uz/Dungeons%20%26%20Dragons/AD%26D%201st%20Edition/'

tmpdir=$(mktemp -d) # use a tmpdir because the "--spider" argument may overwrite 
					# already present files, cancelling their contents

(
cd ${tmpdir}
wget --recursive  -erobots=off --no-parent --spider --server-response $directory 2>&1 |grep --line-buffered -i content-length | gawk '{sum+=$2}END{print sum/1e6}'
)

find ${tmpdir} -type d -delete

exit 0
