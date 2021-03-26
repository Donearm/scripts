## Scripts

a collection of personal scripts. A few worked way back in time, some need a complete rewrite but 90% are perfectly usable.

#### backlight\_change.sh

Increase or decrease the screen's backlight. Should work with any backlight driver

####  bigpkg.py

List Archlinux's installed packages by size. By Allan McRae

#### cert-hashing.sh

Hash a SSL certificate

#### clitwitter.py

Old script to post on Twitter with Basic Authentication. Need to be updated with
OAuth but I've since switched to TTYtter

#### compare\_images.py

A script to compare images in a directory for similarity. It returns 
only those similar but not identical in a list. At this moment the list 
contains all images that have at least another very similar but doesn't 
check if they are similar with all the other images in the list, ending 
up with different couples of similar images but not all very similar. I 
found it too long to loop again and again to check all the images among 
themselves or return different lists for each group of similar images

#### cortex\_reddits.py

Browse (sub)reddits with the Reddit client cortex. Totally an hack, subscribing 
them on Reddit is much easier but I didn't want to read all my subscriptions 
each time so I wrote this script to choose what and when to browse

#### dayoftheweek.py

Not my script originally, I just made it Python 3.2 compatible

#### delete\_by\_percentage.lua

Delete a random choice of files in a directory by a given percentage. Seems 
totally pointless but you'll never imagine the use case that made me write it... 
:)

#### deploy.sh

Deploy script for dotfiles here on Github. Untested.

#### dizionario\_sqlscript.lua

Search and insert words and definitions in a SQLite dictionary of multiple 
languages

#### dwm\_start.sh

Boot script for DWM

#### dzenstatusbar.sh

A simple dzen statusbar

#### dzenweather.sh

Weather script with icons for Dzen

#### feh\_or\_browser.lua

Useful for Newsbeuter or other similar cli softwares that can't show images in 
terminals. It checks whether a url is to an image, and open it in feh, or to 
something else, and open it in the browser

#### fehgallery.lua and fehgallery.py

Sort images in a directory and feed them to feh. Also, delete feh's filelist 
files if present. Same script written in Lua and Python

#### get\_ip.py

Print the current IP. Both IPv4 and IPv6 are shown

#### hdbenchmark.sh

A very raw HD benchmark tool

#### imap\_check.py

CLI unread count of my 2 GMail accounts. I used this as input for an AwesomeWM 
widget before the gmail one from vicious was implemented. Nowadays it's 
superfluous (and in need of refactoring...)

#### imgtags.py

Remove exiv tags from all the images in the current directory. People add all 
sorts of absurd tags to their images...

#### instahashtag.py

A script to download the latest 30 posts matching an hashtags' list on 
Instagram. Requires instaloader

#### lib/basename.lua

The basename shell command implemented in Lua

#### lib/benchmark\_clock.lua

A quite raw benchmark for Lua scripts

#### lib/compare\_table.lua

Compare tables for equality, after having "setified" them, in Lua

#### lib/dirname.lua

The dirname shell command implemented in Lua

#### lib/dns\_lookup.js

DNS lookup in NodeJS

#### lib/generate\_random\_ints.lua

Random number generator

#### lib/get\_home\_dir.go

Get current user's home directory

#### lib/iterate\_nested\_tables.lua

Iterate over nested tables in Lua

#### lib/list\_files.lua

List files with just `ls` instead of using `lua-filesystem` (which has more 
features of course)

#### lib/markdown-print.css and lib/markdown.css

Css for markdown files converted to html, printed or shown on screen

#### lib/markdowntohtml.go

Go parser of Markdown file to HTML

#### lib/must\_run.go

Quick wrapper for error checking for functions that must run (panic if don't)

#### lib/parse\_cli\_arguments.lua

A skeleton of a function parsing cli arguments in Lua

#### lib/prime\_numbers.go

A generator of prime numbers based on Goroutines and channels

#### lib/secs2minutes.lua

Convert an integer representing the seconds in minutes or a full representation 
of a clock (HH:MM:SS)

#### lib/web\_server.go

Dead simple web server in Golang

#### magnet\_link\_to\_torrent.sh

Output a magnet link to a torrent file to save it for future re-use

#### make\_gif.sh

Make a gif from a video using FFmpeg. Quick and Dirty (size, duration are hardencoded).

#### maps\_client.go

Script to query the Google Maps API for results matching a specific category of places around Krakow. This was a base for a full web app that never saw the light. An API key is needed

#### markdownitall.lua

Convert all markdown files in a path to html

#### mplayerss.lua

Launch MPlayer while disabling screensaver, DPMS settings and any compositing 
manager. When MPlayer exits, it reapplies the previous settings

#### naut-bulkrename.sh, naut-feh\_slide.sh and naut-urxvt.sh

Launch scripts for Nautilus. Not actually using them since years

#### net\_data\_sum.py

Save network upload and download statistics in a file. Sum the numbers if from 
the same day (to take into account reboots)

#### newsbeuter\_extract\_titleurl.sh

Output url and title from an article in newsbeuter in a file. I used, and 
occasionally use still, this to tweet the interesting news from the rss feeds I 
follow

#### nofollow-dofollow.js

Quick script for the browser console to check whether links on a page 
are nofollow or dofollow.

#### pick\_random\_file.sh

Returns the name of a file, randomly picked in a given path among those 
matching an extension (or any kind of file at all if no extension is 
selected)

#### plowdown\_parallel.sh

Use plowdown to download in parallel when downloading from different sites

#### pyscreenshoter.py

Take a desktop screenshot with just a few Python lines

#### randomman.lua

Randomly choose and open a manpage. I found this to be an extremely quick and 
funny way to discover hidden features and commands of your system

#### rmtrash.py

Removing some useless directories/files in ~

#### script\_awesome\_debug.sh

Debug AwesomeWM with Xephyr. It can easily adapted to any other WM

#### script\_bandwidth\_archive.sh

Save bandwidth stats to a text file, ready to be loaded in Tiddlywiki

#### script\_bbcode\_formatting.sh

Format files containing BBCode. More informations in the script itself

#### script\_bigger\_than\_M.sh

Print files and directories that are bigger than 1Mb. I use this to discover 
what is eating up all the disk space in a partition

#### script\_blog\_backup.sh

A pretty basic, and not that useful, blog/site backup script

#### script\_clean\_gopath.sh

Clean using `go clean` archive files and executable binaries created 
with `go install` and `go get` in your `$GOPATH`

#### script\_clean\_vim\_undodir.sh and script\_clean\_vim\_views.sh

2 scripts to clean undodir and views directories under `~/.vim/` to delete 
references to files that are not present anymore on disk and thus save space. 
Probably not useful today with >1TB disks but I hate wasting space

#### script\_disable\_touchpad.sh

Launched at boot from your WM/DE, it detects thanks to xinput whether a 
mouse is present or not and disable/enable the touchpad accordingly. It 
goes along with the udev rules, completing it as with udev it can only 
be detected when a mouse is plugged in or off, not when it's already 
plugged in at boot. "Lachesis" is my mouse, of course

#### script\_dl\_single\_github\_file.sh

Download a single file from a specific repository on Github

#### script\_dos\_unix.sh

Convert Dos/Unix newline format

#### script\_download\_images.sh

Download all images on a webpage with Curl. Does not check the type of image nor check if it is already present (it will overwrite images with the same name) but for a quick job it's ok. Readapted from a script found months ago on the web

#### script\_efi\_menu\_restore.sh

Restore UEFI boot menu entries. Of course only those I use/care about

#### script\_entropy.sh

An entropy-generating script. I use this when I need to overwrite a partition or 
disk with random data for security reasons. As I'm paranoid, `/dev/urandom` 
isn't enough

#### script\_exif\_clean.sh

A wrapper for imgtags.py

#### script\_extract\_ip.sh

Extract all URLs from a file

#### script\_flash\_video\_save.sh

Save the flash video opened in firefox. Not working with all files/sites

#### script\_flush\_thumbnails.sh

Remove all those `.thumbnails/` directories under a path. I hate keeping 5 years 
old thumbnails of files that have been removed ages ago...

#### script\_ip4toip6.sh

Convert an IPv4 address to its IPv6 equivalent

#### script\_list\_files\_number\_in\_subdirectories.sh

Print the number of files in each subdirectory of a given directory

#### script\_loop\_ff\_profile.sh

Move Firefox profiles in a file mounted in memory

#### script\_make\_thumbs.sh

Create thumbnails for images in a directory

#### script\_merge\_html.sh

Merge all html files in a directory in a single page

#### script\_music\_to\_android.sh

Transfer a directory containing music to the sdcard `Music/` directory on
Android phones. Not using this anymore, mounting the phone via usb is quicker

#### script\_mutt\_mailto.sh

Open mailto links in mutt

#### script\_pdf\_to\_jpeg.sh

Extract every page of a pdf as jpg images

#### script\_pianobar\_update\_proxy.sh

Update the proxy address used by pianobar to access Pandora outside the US

#### script\_playlist\_make.sh

Make a playlist out of music files in a directory and optionally convert flacs 
to oggs

#### script\_print\_utf8.sh

Output a serie of Unicode characters on the terminal. For the times when you 
know there's a character in the Unicode table but don't know the code and can't 
remember the name. Of course I've only added those I find more useful

#### script\_private.sh

Mount my private, cryptsetup encrypted partition and start the MPD daemon. 
Automatic detection of different partition, on desktop or laptop

#### script\_proxy\_checker.sh

Check whether a proxy is working and is from the US by trying to access 
pandora.com (as it is blocked here in Italy, if I can access it it must be an US 
address)

#### script\_rate\_music.sh

Add currently playing song in MPD to a playlist using ncmpcpp or cmus (quite 
easily expanded for other players). The original script allowed only to rate 
songs in aptly named playlists (1 to 5) but this permits to use any name for the 
playlist

#### script\_ripencode.sh

Audio cd ripping script (to mp3, ogg or flac)

#### script\_touchpad.sh

Disable/enable the touchpad. When writing long texts on a laptop the fingers can 
move the pointer and it's annoying. Disabling the touchpad removes the problem

#### script\_transmission\_notify.sh

A libnotify notification for completed torrents in Transmission

#### script\_ttytter\_now\_playing.sh

Tweets current playing song (from ncmpcpp) via TTYtter. This must be configured 
already

#### script\_video\_thumbnails.sh

This is a old script, but still working, that I used when I did some video 
editing. Basically it generates an image containing informations such as 
filename, size, lenght and codec of a video along with a series of thumbnails to 
show off its content. I never tweaked it more than "black backround, fixed 
spacing between thumbs" though, I just needed something that didn't force me to 
depend on external programs.

#### script\_wd\_cryptousb.sh

Mount an encrypted partition on a usb hd that I use for backups.

#### script\_wifi\_control.sh

Completely disable and power off the Atheros wifi card on the Asus 1005H netbook

#### script\_xdg\_setup.sh

A super-raw and quick script to set up the main files associations with 
xdg-open

#### script\_xwinwrap-video.sh

Use a video as desktop background with xwinwrap. I have no idea why anybody 
would want to but it's a funny trick

#### script\_zfs\_private.sh

A script to mount an encrypted ZFS dataset. Mostly the equivalent of script\_private.sh

#### showip.c

Show IP addresses for a host

#### sopcast.go

A launcher for Sopcast streaming links. I had a Bash function for this 
but it was convoluted to kill the Sopcast process when exiting the video 
player. Go handles this case much more easily

#### systemd/clean\_imagemagick\_tmpfiles.timer and systemd/clean\_imagemagick\_tmpfiles.service

Timer and service to clean ImageMagick's temporary files created in /tmp and not properly cleaned (see issue [395](https://github.com/ImageMagick/ImageMagick/issues/395))

#### systemd/lock\_suspend.service

Lock, using physlock but any other locker may be used, the session on lid closing signal

#### systemd/network.service

Systemd service for wired networks

#### systemd/overwrite-hosts.service and systemd/overwrite-hosts.timer

A service and timer couple to overwrite every 10 minutes the /etc/hosts file
with a copy that is on one of my personal directories. That's because the file
it's automatically generated by copying blacklists from the internet of
advertisement/malware/adware/etc. to ban every few minutes and I need
/etc/hosts to be synced with this updated file

#### systemd/stash.service

A systemd service to run stash app as a server (on a Raspberry Pi in my case but can be ran anywhere)

#### systemd/zfs-scrub@.timer and systemd/zfs-scrub@.service

Timer and service to do a monthly ZFS scrubbing

#### systemd/ttytter-screen.service and systemd/ttytter-tmux.service

Launch TTYtter under screen or tmux as a self-respawning daemon with Systemd

#### tmux\_sites\_projects.sh

Open a 3 windows tmux session, one for each of html, css and js files to
edit. Specifically made for website projects

#### tmux\_workon\_project.sh

Open 2 split windows in tmux, changing paths to the project's to work on

#### ttytter\_startup.sh

Old shell TTYtter startup script that I used before switching to Systemd. It 
checks whether a tmux session containing TTYtter is already running and 
reattaches to it or if it's not, launch one. This is for WM that are launched by 
\startx as a DM implements already the same functionalities

#### validate\_yaml.py

A wrapper around pyyaml to quickly validate a yaml file from the command 
line

#### watermarking.sh

Quick script to add a watermark on an image. Used for copyrighting my 
images at the moment

## Donate 

[![ko-fi](https://www.ko-fi.com/img/donate_sm.png)](https://ko-fi.com/W7W7KA0Z)
