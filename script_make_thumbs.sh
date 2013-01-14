#!/bin/bash 

# Create thumbnails from a series of images in a directory

read -e -p "Which directory? " DIR
read -p "Do you want (T)humbs, (R)esize or resize (E)xactly? " TRoE
read -p "Max Dimension? (use nnnnxnnnn) " DIM

case $TRoE in
    [Tt]) for jpegs in $DIR*.jpg ; do
# the \> stands for "shrink only larger images" thus, if there is an
# image smaller than the desidered thumb it won't be touched
	    convert -thumbnail $DIM\> "$jpegs" "${DIR}th_`basename $jpegs .jpg`.png" ;

# funny alternative with soft edges and a transparent background. Not
# much useful but pretty to look at :-)
	    #convert -thumbnail $DIM -matte -virtual-pixel transparent \
		#-channel A -blur 0x8 -evaluate subtract 50% \
		#-evaluate multiply 2.001 "$jpegs" "${DIR}th_`basename $jpegs .jpg`.png" ;
	done 
	;;
    [Rr]) for jpegs in $DIR*.jpg ; do
	    convert -size $DIM "$jpegs" -resize $DIM "${DIR}sm_`basename $jpegs`" ;
	done
	;;
    [Ee]) for jpegs in $DIR*.jpg ; do
	    convert "$jpegs" -resize $DIM! "${DIR}res_`basename $jpegs`" ;
	done
	;;
esac
    
exit 0
