#!/usr/bin/env bash
REPO_ROOT="${BASH_SOURCE[0]%/*}/.."

echo "==> Installing custom fonts..."
mkdir -p ~/Library/Fonts/ || {
    echo "Failed to create Fonts directory"
    exit 1
}
cp "$REPO_ROOT"/configs/fonts/source-code-pro/* ~/Library/Fonts/ 2>/dev/null || true
cp "$REPO_ROOT"/configs/fonts/archivo/*.ttf ~/Library/Fonts/ 2>/dev/null || true
cp "$REPO_ROOT"/configs/fonts/archivo/static/*.ttf ~/Library/Fonts/ 2>/dev/null || true

if command -v fc-cache &>/dev/null; then
    echo "==> Updating font cache..."
    fc-cache -fv >/dev/null || {
        echo "Failed to update font cache"
        exit 1
    }
fi
