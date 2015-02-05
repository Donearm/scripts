#/bin/bash

# Mount encrypted partition on a usb hd with a keyfile

KEYFILE="/mnt/d/Stuff/ib_wd_usb.jpg"
CRYPTSETUP=$(which cryptsetup)

if [[ $1 == 'mount' ]]; then
	$CRYPTSETUP --key-file $KEYFILE luksOpen /dev/sdc2 cryptousb || exit 1
	mkdir -p /media/cryptousb
	mount /dev/mapper/cryptousb /media/cryptousb
elif [[ $1 == 'umount' ]]; then
	sync
	umount -l /media/cryptousb || exit 1
	$CRYPTSETUP luksClose cryptousb || exit 1
	rmdir /media/cryptousb 
else
	echo "Something went wrong...."
fi

exit 0
