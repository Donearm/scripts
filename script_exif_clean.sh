#!/bin/sh

# Using imgtags.py, clean images of every EXIF tags

IMGTAGS='/mnt/d/Script/imgtags.py'

for i in "$@"; do
	$IMGTAGS -i "${i}" -d;
done

exit 0
