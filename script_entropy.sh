#!/bin/bash 

# Entropy-producing script. Useful to increase /dev/random seed
# Requires openssl and perl or hdparm installed

i=0
f=1
d=8
#
#while [ $f -gt $i ]
#    do
#	head -c 12 /dev/random | find / -name - >> file1
#	head -c $f file1 | tail -c $d | openssl sha1 >> $part
	#perl -e 'srand (time ^ $$ ^ unpack "%L*", `ps axww | gzip`);'
#	f=$((f+1))
#	d=$((d+1))
#done

# If the above is not enough, generate various I/O reads with hdparm
for hd in `df | awk '{print $1}' | grep ¿d` ; do
	hdparm -t $hd;
done

exit 0
