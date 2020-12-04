#!/usr/bin/env bash
# install bitbar.app
# install osx-cpu-temp

filename=~/.cache/mousekeylogs/m$(date "+%Y%m%d").log
left=$(grep "L" $filename | wc -l | grep -o -E '[0-9]+')
right=$(grep "R" $filename | wc -l | grep -o -E '[0-9]+')
wheel=$(grep "W" $filename | wc -l | grep -o -E '[0-9]+')
other=$(grep "O" $filename | wc -l | grep -o -E '[0-9]+')
if [ -f $filename ]; then
    echo "${left}/${other}/${right}"
fi
