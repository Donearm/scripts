#!/bin/sh

# Script to open mailto links with mutt under the terminal

TERMINAL="kitty"

#CMD=$(basename "$0")
#CMD="${CMD%*-newterminal}"
MUTTRC="${HOME}/.muttrc"
CMD="mutt"

exec $TERMINAL -e "$CMD" -F "$MUTTRC" "$@"
