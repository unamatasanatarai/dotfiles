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

echo "==> Services launched."
