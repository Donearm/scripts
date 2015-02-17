#!/bin/bash

REPO="git://github.com/Donearm/configs.git"
REPODIR="~/.config/configfiles/"

if [ ! -d $REPODIR ]; then
	mkdir -p $REPODIR
fi

cd $REPODIR

function pull_repo() {
	git init
	git remote add origin $1
	git pull origin master
}

function link_files() {
	for i in .*; do
		ln -s ${REPODIR}$i ~/$1
	done
}

pull_repo $REPO
link_files

source ~/.bash_profile

exit 0
