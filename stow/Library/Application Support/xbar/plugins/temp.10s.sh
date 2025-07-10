#!/usr/bin/env bash

# <xbar.title>CPU Temperature</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>Your Name</xbar.author>
# <xbar.desc>Shows current CPU temperature on macOS menu bar.</xbar.desc>
# <xbar.dependencies>osx-cpu-temp</xbar.dependencies>
# <xbar.image></xbar.image>

set -euo pipefail

get_temp() {
  if [[ "$(uname -m)" == "x86_64" ]]; then
    if [ -f /usr/local/bin/osx-cpu-temp ]; then
      /usr/local/bin/osx-cpu-temp
    else
      /opt/homebrew/bin/osx-cpu-temp
    fi
  else
    echo "?°C"
  fi
}

temp=$(get_temp)
echo "$temp"

