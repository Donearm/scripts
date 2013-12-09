##Scripts

a collection of personal scripts. A few worked way back in time, some need a complete rewrite but 90% are perfectly usable.

####cert-hashing.sh

Hash a SSL certificate

####clitwitter.py

Old script to post on Twitter with Basic Authentication. Need to be updated with 
OAuth but I've since switched to TTYtter

####delete\_by\_percentage.lua

Delete a random choice of files in a directory by a given percentage. Seems 
totally pointless but you'll never imagine the use case that made me write it... 
:)

####deploy.sh

Deploy script for dotfiles here on Github. Untested.

####dizionario\_sqlscript.lua

Search and insert words and definitions in a SQLite dictionary of multiple 
languages

####dwm\_start.sh

Boot script for DWM

####dzenstatusbar.sh

A simple dzen statusbar

####dzenweather.sh

Weather script with icons for Dzen

####feh\_or\_browser.lua

Useful for Newsbeuter or other similar cli softwares that can't show images in 
terminals. It checks whether a url is to an image, and open it in feh, or to 
something else, and open it in the browser

####fehgallery.lua and fehgallery.py

Sort images in a directory and feed them to feh. Also, delete feh's filelist 
files if present. Same script written in Lua and Python

####get\_ip.py

Print the current IP

####hdbenchmark.sh

A very raw HD benchmark tool

####imgtags.py

Remove exiv tags from all the images in the current directory. People add all 
sorts of absurd tags to their images...

####lib/basename.lua

The basename shell command implemented in Lua

####lib/benchmark\_clock.lua

A quite raw benchmark for Lua scripts

####lib/compare\_table.lua

Compare tables for equality, after having "setified" them, in Lua

####lib/dirname.lua

The dirname shell command implemented in Lua

####lib/generate\_random\_ints.lua

Random number generator

####lib/iterate\_nested\_tables.lua

Iterate over nested tables in Lua

####lib/list\_files.lua

List files with just `ls` instead of using `lua-filesystem` (which has more 
features of course)

####lib/markdown-print.css and lib/markdown.css

Css for markdown files converted to html, printed or shown on screen

####lib/parse\_cli\_arguments.lua

A skeleton of a function parsing cli arguments in Lua

####lib/secs2minutes.lua

Convert an integer representing the seconds in minutes or a full representation 
of a clock (HH:MM:SS)

####magnet\_link\_to\_torrent.sh

Output a magnet link to a torrent file to save it for future re-use

####markdownitall.lua

Convert all markdown files in a path to html

####mplayerss.lua

Launch MPlayer while disabling screensaver, DPMS settings and any compositing 
manager. When MPlayer exits, it reapplies the previous settings

####naut-bulkrename.sh, naut-feh\_slide.sh and naut-urxvt.sh

Launch scripts for Nautilus. Not actually using them since years

####net\_data\_sum.py

Save network upload and download statistics in a file. Sum the numbers if from 
the same day (to take into account reboots)

####newsbeuter\_extract\_titleurl.sh

Output url and title from an article in newsbeuter in a file. I used, and 
occasionally use still, this to tweet the interesting news from the rss feeds I 
follow

####plowdown\_parallel.sh

Use plowdown to download in parallel when downloading from different sites

####pyscreenshoter.py

Take a desktop screenshot with just a few Python lines

####randomman.lua

Randomly choose and open a manpage. I found this to be an extremely quick and 
funny way to discover hidden features and commands of your system

####script\_bandwidth\_archive.sh

Save bandwidth stats to a text file, ready to be loaded in Tiddlywiki

####script\_bbcode\_formatting.sh

Format files containing BBCode. More informations in the script itself

####script\_bigger\_than\_M.sh

Print files and directories that are bigger than 1Mb. I use this to discover 
what is eating up all the disk space in a partition

####script\_blog\_backup.sh

A pretty basic, and not that useful, blog/site backup script

####script\_clean\_vim\_undodir.sh and script\_clean\_vim\_views.sh

2 scripts to clean undodir and views directories under `~/.vim/` to delete 
references to files that are not present anymore on disk and thus save space. 
Probably not useful today with >1TB disks but I hate wasting space

####script\_dl\_single\_github\_file.sh

Download a single file from a specific repository on Github

####script\_dos\_unix.sh

Convert Dos/Unix newline format

####script\_efi\_menu\_restore.sh

Restore UEFI boot menu entries. Of course only those I use/care about

####script\_entropy.sh

An entropy-generating script. I use this when I need to overwrite a partition or 
disk with random data for security reasons. As I'm paranoid, `/dev/urandom` 
isn't enough

####script\_exif\_clean.sh

A wrapper for imgtags.py

####script\_extract\_ip.sh

Extract all URLs from a file

####script\_flash\_video\_save.sh

Save the flash video opened in firefox. Not working with all files/sites

####script\_flush\_thumbnails.sh

Remove all those `.thumbnails/` directories under a path. I hate keeping 5 years 
old thumbnails of files that have been removed ages ago...

####script\_ip4toip6.sh

Convert an IPv4 address to its IPv6 equivalent

####script\_loop\_ff\_profile.sh

Move Firefox profiles in a file mounted in memory

####script\_make\_thumbs.sh

Create thumbnails for images in a directory

####script\_merge\_html.sh

Merge all html files in a directory in a single page

####script\_music\_to\_android.sh

Transfer a directory containing music to the sdcard `Music/` directory on 
Android phones. Not using this anymore, mounting the phone via usb is quicker

####script\_mutt\_mailto.sh

Open mailto links in mutt

####script\_pdf\_to\_jpeg.sh

Extract every page of a pdf as jpg images

####script\_pianobar\_update\_proxy.sh

Update the proxy address used by pianobar to access Pandora outside the US

####script\_playlist\_make.sh

Make a playlist out of music files in a directory and optionally convert flacs 
to oggs

####script\_print\_utf8.sh

Output a serie of Unicode characters on the terminal. For the times when you 
know there's a character in the Unicode table but don't know the code and can't 
remember the name. Of course I've only added those I find more useful

####script\_private.sh

Mount my private, cryptsetup encrypted partition and start the MPD daemon

####script\_proxy\_checker.sh

Check whether a proxy is working and is from the US by trying to access 
pandora.com (as it is blocked here in Italy, if I can access it it must be an US 
address)

####script\_rate\_music.sh

Add currently playing song in MPD to a playlist using ncmpcpp or cmus (quite 
easily expanded for other players). The original script allowed only to rate 
songs in aptly named playlists (1 to 5) but this permits to use any name for the 
playlist

####script\_touchpad.sh

Disable/enable the touchpad. When writing long texts on a laptop the fingers can 
move the pointer and it's annoying. Disabling the touchpad removes the problem

####script\_transmission\_notify.sh

A libnotify notification for completed torrents in Transmission

####script\_ttytter\_now\_playing.sh

Tweets current playing song (from ncmpcpp) via TTYtter. This must be configured 
already

####script\_wifi\_control.sh

Completely disable and power off the Atheros wifi card on the Asus 1005H netbook

####script\_xwinwrap-video.sh

Use a video as desktop background with xwinwrap. I have no idea why anybody 
would want to but it's a funny trick

####showip.c

Show IP addresses for a host

####systemd/network.service

Systemd service for wired networks

####systemd/ttytter-screen.service and systemd/ttytter-tmux.service

Launch TTYtter under screen or tmux as a self-respawning daemon with Systemd

####tmux\_workon\_project.sh

Open 2 split windows in tmux, changing paths to the project's to work on

####ttytter\_startup.sh

Old shell TTYtter startup script that I used before switching to Systemd. It 
checks whether a tmux session containing TTYtter is already running and 
reattaches to it or if it's not, launch one. This is for WM that are launched by 
\startx as a DM implements already the same functionalities
