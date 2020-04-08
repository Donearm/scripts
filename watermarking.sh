#!/bin/bash

# Watermarking a series of image (currently with my copyright)
# Takes 2 parameters, the original and the watermarked image. For
# multiple images, a for loop works great.

IN="${1}"
OUT="${2}"

CAPTION='© Gianluca Fiore'

# Get the width of the image to calculate the position of the watermark
WIDTH=$(identify -format %w $IN)

# If the width is above 3000, use a slightly larger watermark. Otherwise
# it will be hardly readable
if [[ ${WIDTH} >=3000 ]]; then
	GEOMETRY="700x700+200+1000"
else
	GEOMETRY="500x500+200+1000"
fi
convert -background '#0008' -fill white -gravity center \
	-size $(expr ${WIDTH} / 3)x100 caption:${CAPTION} \
	$IN +swap -gravity center -geometry "${GEOMETRY}" \
	-composite $OUT
