#!/bin/bash

# Using the proxy_checker.sh script to automatically update the 
# pianobar's config file with a working USA proxy

CONFIG="${HOME}/.config/pianobar/config"
PROXYCHECK='/mnt/documents/Script/script_proxy_checker.sh'
IP=$1
PORT=$2

# call the proxy checker script and catch its exit status
$PROXYCHECK $1 $2

if [[ $? = "0" ]]; then
	# proxy is working, use it
	# first, assemble the complete config line
	PROXYLINE="control_proxy = http://${1}:${2}"
	sed -i 's|^control_proxy.*|'"${PROXYLINE}"'|g' $CONFIG
	exit 0
else
	# not working, exit
	exit 1
fi
