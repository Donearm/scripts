#!/bin/bash

# Move the FF profile to a file mounted in ram via the loop option to
# improve the overall responsiveness. A backup is made beforehand.

USER=`ls -l ~/.mozilla/firefox/profiles.ini | awk '{print $3}'`
GROUP=`ls -l ~/.mozilla/firefox/profiles.ini | awk '{print $4}'`
NAVIGATIONPATH=`grep -m 2 Path ~/.mozilla/firefox/profiles.ini \
| grep navigation3 | awk -F= '{print $2}'`
NAVIGATIONIMG='navigation.img'

cd ~/.mozilla/firefox

# mv the current profiles in a different directory and recreate their
# directories as empty
mv $NAVIGATIONPATH bckp-${NAVIGATIONPATH}
mkdir $NAVIGATIONPATH

# create the new file images
dd if=/dev/zero of=$NAVIGATIONIMG bs=1M count=150
# and format them
mkfs.ext3 -m 0 -O dir_index,has_journal,sparse_super -F $NAVIGATIONIMG

# Mount the new images as loopback
sudo mount -o loop,noatime $NAVIGATIONIMG $NAVIGATIONPATH

# Then copy the contents of the old profiles in the new locations
cp -a bckp-${NAVIGATIONPATH}/* $NAVIGATIONPATH
sudo chown -R $USER:$GROUP $NAVIGATIONPATH

# Finally compact the sqlite dbs of the profiles
find -nowarn . -name "*.sqlite" -exec sqlite3 {} 'VACUUM;' \;

# What to add in fstab
echo ""
echo "ADD THESE LINES IN /etc/fstab to mount the profiles at every boot"
echo ""
echo "$HOME/.mozilla/firefox/$NAVIGATIONIMG $HOME/.mozilla/firefox/$NAVIGATIONPATH       auto    loop,noatime    0  0"
echo ""

exit 0
