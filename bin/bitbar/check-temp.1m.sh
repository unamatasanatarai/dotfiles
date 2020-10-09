#!/usr/bin/env bash
# install bitbar.app
# install osx-cpu-temp

theme=$(defaults read "Apple Global Domain" AppleInterfaceStyle 2>&1 > /dev/null)
if [[ $? -eq 1 ]]; then
  # LIGHT
  col_normal="#111111"
  col_warning="#F78502"
  col_danger="#f7f0202"
elif [[ $theme -eq "Dark" ]]; then
  col_normal="#EEEEEE"
  col_warning="#F78502"
  col_danger="#f7f0202"
fi

temp=`osx-cpu-temp`
num=${temp:0:2}
color=$col_normal
if [[ $num > 60 ]]; then
  color=$col_warning
fi
if [[ $num > 75 ]]; then
  color=$col_danger
fi
echo "$temp | color=$color"
