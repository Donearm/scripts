#/bin/bash

# Custom slideshow of all the images in a directory, sorted by filename,
# to use as a nautilus/thunar script

shopt -s extglob # more globbing patterns

feh -Z -S filename --scale-down  --no-jump-on-resort \
*.[p,j,g,P,J,G][n,p,i,N,P,I][g,f,G,F,e,E]?([g,G])

rm ./*_filelist

shopt -u extglob # unset
