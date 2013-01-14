#!/bin/bash

REPO="git://github.com/Donearm/configs.git"
REPODIR="~/.config/configfiles/"

if [ ! -d $REPODIR ]; then
	mkdir -p $REPODIR
fi

cd $REPODIR
git init
git remote add origin $REPO
git pull origin master

function rsync_files() {
	rsync --exclude ".git/" --exclude "README.md*" -av . ~
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	rsync_files
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		rsync_files
	fi
fi

source ~/.bash_profile

exit 0
