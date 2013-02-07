#!/bin/sh

# Start script for dwm

eval `cat ~/.fehbg`

xbindkeys
xset m 0.7 2
xset dpms 0 900 2750

urxvtd -q -o -f

exec dwm
