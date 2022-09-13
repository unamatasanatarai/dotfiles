#!/usr/bin/env bash

set -euo pipefail

input_volume=$(osascript -e "get input volume of (get volume settings)")

if [ "$input_volume" -lt 20 ]; then
  echo "✕"
else
  echo "🎤"
fi
