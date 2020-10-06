#!/usr/bin/env bash
# install bitbar.app
# install osx-cpu-temp

temp=`/usr/local/bin/osx-cpu-temp`
num=${temp:0:2}
color="#000000"
if [[ $num > 60 ]]; then
  color="#fcf82a"
fi
if [[ $num > 75 ]]; then
  color="#ff0000"
fi
echo "$temp | color=$color"
