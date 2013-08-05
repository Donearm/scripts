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

function link_files() {
	for i in .*; do
		ln -s ${REPODIR}$i ~/$1
	done
}

link_files

source ~/.bash_profile

exit 0
