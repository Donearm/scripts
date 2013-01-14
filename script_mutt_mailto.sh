#!/bin/bash

# Script to open mailto links with mutt under urxvt

TERMINAL="urxvt"

#CMD=$(basename "$0")
#CMD="${CMD%*-newterminal}"
CMD="mutt"

exec $TERMINAL -e "$CMD" "$@"
