#!/usr/bin/env bash
# install bitbar.app
# install osx-cpu-temp

filename=~/.cache/mousekeylogs/k$(date "+%Y%m%d").log
if [ -f $filename ]; then
    count=$(wc -l $filename)
    num=$(echo $count | grep -o -E '^\s*[0-9]+')
    words=$( echo $num / 5 | bc)
    echo "${words}w"
    echo "---"
    echo -e "chars\t${num}"
    echo -e "words\t${words}"
fi
