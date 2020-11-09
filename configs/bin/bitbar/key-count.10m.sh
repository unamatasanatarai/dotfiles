#!/usr/bin/env bash
# install bitbar.app
# install osx-cpu-temp

count=$(wc -l ~/.keylogger/$(date "+%Y%m%d").log)
num=$(echo $count | grep -o -E '^\s*[0-9]+')
words=$( echo $num / 5 | bc)
echo "${num}c ${words}w"

