#!/bin/bash

# Check whether a proxy server is working or not

# HTTP Proxy Server's IP Address (or URL)
proxy_server=$1

# HTTP Proxy Server's Port Number
port=$2

# We're trying to reach this url via the given HTTP Proxy Server
# (http://www.google.com by default)
url="http://www.pandora.com"

# Timeout time (in seconds)
timeout=20

# We're fetching the return code and assigning it to the $result variable
#result=`HEAD -d -p http://$proxy_server:$port -t $timeout $url`
#result=`curl -x $proxy_server:$port --head -s --connect-timeout $timeout $url -D - | grep HTTP | awk '{print $2,$3}'`
head_request=`wget --server-response --spider -e "http_proxy = $proxy_server:$port" $url -o /tmp/head`
result=`grep HTTP /tmp/head | awk '{print $2,$3}'`
echo $result

# If the return code is 200, we've reached to $url successfully
if [ "$result" = '200 OK' ]; then
	echo "1 (proxy works)"
	rm -f /tmp/head
	exit 0
# Otherwise, we've got a problem (either the HTTP Proxy Server does not work
# or the request timed out)
else
	echo "0 (proxy does not work or request timed out)"
	rm -f /tmp/head
	exit 1
fi
