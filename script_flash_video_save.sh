#!/bin/bash

FLASHPIDS=$(pidof plugin-container)

for p in $FLASHPIDS; do
	cp -b "/proc/$p/fd/"$(ls -l /proc/$p/fd | grep Flash | awk '{print $9}') ~/vid-$p.mp4
done

exit 0

