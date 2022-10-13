#!/usr/bin/env bash

set -euo pipefail

if [[ "$(uname -m)" = "x86_64" ]]; then
  if [ -f /usr/local/bin/osx-cpu-temp ]; then
    /usr/local/bin/osx-cpu-temp
  else
    /opt/homebrew/bin/osx-cpu-temp
  fi
else
  echo "?°C"
fi
