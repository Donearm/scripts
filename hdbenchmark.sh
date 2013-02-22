#/bin/sh

echo "Writing test, 1GB file"
dd if=/dev/zero of=tempfile bs=1M count=1024 conv=fdatasync,notrunc
echo "Test done, dropping the cache now"
echo 3 > /proc/sys/vm/drop_cache
echo "Cache dropped"
echo ""
echo "Reading test, 1GB file"
dd if=tempfile of=/dev/null bs=1M count=1024
echo "Cached reading test, 1GB file"
dd if=tempfile of=/dev/null bs=1M count=1024
echo "All tests done, bye"

rm tempfile

exit 0
