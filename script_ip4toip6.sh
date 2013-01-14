#!/bin/sh

# Convert a IPv4 address to its corresponding IPv6 address
# Usage: script ip

IPV4_ADDR=$1

# Remove dots from the address
IPV4_ADDR=`echo $IPV4_ADDR | tr "." " "`

# Convert each octets to hexadecimal using printf
IPV4_ADDR=`printf "%02x%02x:%02x%02x" $IPV4_ADDR`

# Add prefix and suffix to have the IPv6 version
IPV6_ADDR=2002:$IPV4_ADDR::1

# Print it
echo $IPV6_ADDR
