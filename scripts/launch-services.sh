#!/usr/bin/env bash

echo "==> Starting services and opening apps..."

if command -v skhd &>/dev/null; then
	echo "    Starting or restarting skhd..."
	skhd --restart-service 2>/dev/null || skhd --start-service || echo "    Failed to start skhd"
fi

if [[ -d "/Applications/LuLu.app" ]]; then
	echo "    Starting LuLu..."
	open "/Applications/LuLu.app" || echo "    Failed to start LuLu"
fi

os_vers=$(sw_vers -productVersion) || {
	printf "Error: Failed to get macOS version\n" >&2
	exit 1
}

os_major="${os_vers%%.*}"
if [[ "$os_major" == "12" ]]; then
	echo "    Starting or restarting yabai..."
	yabai --restart-service 2>/dev/null || yabai --start-service || echo "    Failed to start yabai"
else
	echo "    Starting or restarting aerospace..."
	open -a AeroSpace || echo "    Failed to start aerospace"
fi

echo "==> Services launched."
