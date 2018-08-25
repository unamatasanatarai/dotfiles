#!/usr/bin/env bash
# custom icon on a locked screen. Quite fun.

icon=$HOME/.config/i3/scripts/lock.png
bg=/tmp/lock-screen.png
scrot $bg
convert $bg -scale 10% -scale 1000% $bg
convert $bg $icon -gravity center -composite -matte $bg
i3lock -u -i $bg

