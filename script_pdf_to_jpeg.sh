#!/bin/bash 

# Output every page of a pdf in a jpeg image

if [ -z $1  ]; then
    read -e -p "Choose a pdf file please " PDF
else
    PDF="$1"
fi

read -e -p "Which name should I to give to the files? " NAME
read -e -p "And last but not least, where do I have to put the files? " DIR

convert  $PDF ${DIR}${NAME}_%04d.jpg

exit 0
