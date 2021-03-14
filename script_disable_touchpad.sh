#!/bin/sh
#
# credit: https://github.com/lahwaacz/Scripts/blob/master/toggle-touchpad.sh

device="$(xinput list | grep -P '(?<= )[\w\s:]*(?i)(touchpad|synaptics)(?-i).*?(?=\s*id)' -o | head -n1)"

[[ "$(xinput list-props "$device" | grep -P ".*Device Enabled.*\K.(?=$)" -o)" == "1" ]] &&
    xinput disable "$device" ||
    xinput enable "$device"
