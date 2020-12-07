#!/usr/bin/env bash
# install bitbar.app
# install osx-cpu-temp

filename=~/.cache/mousekeylogs/m$(date "+%Y%m%d").log
if [ -f $filename ]; then
    left=$(grep "L" $filename | wc -l | grep -o -E '[0-9]+')
    right=$(grep "R" $filename | wc -l | grep -o -E '[0-9]+')
    wheel=$(grep "W" $filename | wc -l | grep -o -E '[0-9]+')
    other=$(grep "O" $filename | wc -l | grep -o -E '[0-9]+')
    total=$(echo $left + $right + $other | bc)
    echo "${total}m"
    echo "---"
    echo -e "left\t\t${left}"
    echo -e "middle\t${other}"
    echo -e "right\t${right}"
    echo -e "wheel\t${wheel}"
fi
