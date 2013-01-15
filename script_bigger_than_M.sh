#!/bin/sh

DIR="$1"

du -h "${DIR}" | awk '$1 ~ ".*[GM].*" {print $2}'

exit 0
