#!/bin/bash
## Usage: add_to_playlist playlistname
# 
# Adds current playing song to the mpd playlist
# 
# Inspired by: https://bbs.archlinux.org/viewtopic.php?id=116113

## USER CONFIGURATION-----------------------------------------------------

## Path to playlists
playlists="/media/private/Music/.playlists"

## END USER CONFIGURATION--------------------------------------------------

## Prefix and suffix strings for the playlist file name
pl_prefix=''
pl_suffix='.m3u'

## Get current song from ncmpcpp or cmus or throw an error
song=`ncmpcpp --now-playing '%D/%f' 2>/dev/null` || \
    song=`cmus-remote -Q 2>/dev/null | grep file` || \
    { echo "Error: you need either ncmpcpp or cmus installed to run this script. Aborting." >&2; exit 1; }

## Error cases
if [[ -z "$song" ]]; then
	echo 'No song is playing.'
	exit 1
elif [[ "$1" -lt 0 || "$1" -gt 5 ]]; then
	echo "Rating must be between 1 and 5. Or zero to delete the current song's rating."
	exit 1
fi

## Path to lock file
lock="/tmp/rate-music.lock"

## Lock the file
exec 9>"$lock"
if ! flock -n 9; then
	notify-send "Rating failed: Another instance is running."
	exit 1
fi

## Strip "file " from the output
song=${song/file \///}

## Temporary file for grepping and sorting
tmp="$playlists/tmp.m3u"


## Append the song to the new playlist
if [[ ! -z $1 ]]; then
	f="$playlists/${pl_prefix}$1${pl_suffix}"
	mkdir -p "$playlists"
	echo "$song" >> "$f"
	sort -u "$f" | uniq > "$tmp"
	mv -f $tmp $f
fi

## The lock file will be unlocked when the script ends
