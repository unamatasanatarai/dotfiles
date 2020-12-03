#!/usr/bin/env bash
# install bitbar.app
# install osx-cpu-temp

filename=~/.cache/mousekeylogs/m$(date "+%Y%m%d").log
if [ -f $filename ]; then
    count=$(wc -l $filename)
    num=$(echo $count | grep -o -E '^\s*[0-9]+')
    echo "${num}M"
fi
