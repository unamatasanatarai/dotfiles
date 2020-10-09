#!/usr/bin/env bash
temp=`/Users/piotrgrabowski/bin/osx-cpu-temp`
num=${temp:0:2}
color="#111111"
if [[ $num > 60 ]]; then
  color="#f78502"
fi
if [[ $num > 75 ]]; then
  color="#f70202"
fi
echo "$temp | color=$color"

