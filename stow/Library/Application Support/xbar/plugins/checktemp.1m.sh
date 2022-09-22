#!/usr/bin/env bash

set -euo pipefail

if [ -f /usr/local/bin/osx-cpu-temp ]; then
  /usr/local/bin/osx-cpu-temp
fi

if [ -f /opt/homebrew/bin/osx-cpu-temp ]; then
  /opt/homebrew/bin/osx-cpu-temp
fi
