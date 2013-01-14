#!/bin/sh
#
# Dead simple single file downloader from a github repo.
#
# Usage: ./script username repo_name filename

USER="$1"
REPO="$2"
FILE="$3"

wget -O ${FILE}-from_github https://github.com/${USER}/${REPO}/raw/master/${FILE}

exit 0
