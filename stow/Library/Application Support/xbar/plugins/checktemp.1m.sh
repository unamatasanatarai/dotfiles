#!/usr/bin/env bash

set -euo pipefail

if [[ "$(uname -m)" = "x86_64" ]]; then
  "$(brew --prefix)"/bin/osx-cpu-temp
else
  echo "?°C"
fi
