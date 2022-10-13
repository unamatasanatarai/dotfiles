#!/usr/bin/env bash

set -euo pipefail

input_volume=$(osascript -e "get input volume of (get volume settings)")

echo "$input_volume🎤"
