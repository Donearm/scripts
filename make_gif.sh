#!/bin/sh

# Use like: ./make_gif.sh video output.gif

SS=00:17
DURATION=14
PALETTE="/tmp/palette.png"
FILTERS="fps=15,scale=300:-1:flags=lanczos"
BAD_QUALITY_FILTERS="fps=15,scale=320:-1:sws_dither=ed" # Use this if
					# you want a smallest possible final gif, sacrificing the quality
PALETTEOPTS="palettegen=stats_mode=diff"

ffmpeg -v warning -ss $SS -t $DURATION -i $1 -vf "$FILTERS,$PALETTEOPTS" -y $PALETTE
ffmpeg -v warning -ss $SS -t $DURATION -i $1 -i $PALETTE -lavfi "$FILTERS [x]; [x][1:v] paletteuse=sierra2_4a" -y $2

exit 0
