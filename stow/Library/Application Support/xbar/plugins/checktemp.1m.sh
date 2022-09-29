#!/usr/bin/env bash

set -euo pipefail

if [[ "$(uname -m)" = "arm*" ]]; then
  "$(brew --prefix)"/bin/osx-cpu-temp
else
  echo "?°C"
fi
