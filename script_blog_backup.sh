#!/bin/bash
#
# Pretty simple and fast blog/site backup

SITE='' # put your blog here
DIR_BACK="/mnt/d/Stuff/blog_backup"

wget -m -p -w 3 --convert-links -P $DIR_BACK $SITE

exit 0
