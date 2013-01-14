#!/bin/sh

DIR="$1"

du -h "${DIR}" | awk '$1 ~ ".*M.*" {print $2}'

exit 0
