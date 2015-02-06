#!/bin/bash
#
# Debug awesome with Xephyr
#
Xephyr -ac -br -noreset -screen 1280x1024 :1 &
sleep 1
DISPLAY=:1.0 awesome -c ~/.config/awesome/rc.lua
