#!/usr/bin/env bash
# ./prompt "are you sure?" "echo $?"
[ $(echo -e "No\nYes" | dmenu -i -p "$1" -nb darkred -sb red -sf white -nf gray -fn mono) == "Yes" ] && $2
