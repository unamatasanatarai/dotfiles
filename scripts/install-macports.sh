#!/usr/bin/env bash
REPO_ROOT="$(cd -- "${BASH_SOURCE[0]%/*}/.." && pwd -P)"

echo "==> Setting up MacPorts..."
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

if ! command -v port >/dev/null 2>&1; then
    echo "MacPorts is not installed. Installing MacPorts..."

    echo "==> The MacPorts installer requires administrator privileges."
    echo "==> Please enter your Mac password when prompted to authenticate sudo."

    curl -fL "https://github.com/macports/macports-base/releases/download/v2.12.5/MacPorts-2.12.5-12-Monterey.pkg" -o /tmp/M.pkg
    sudo installer -pkg /tmp/M.pkg -target /
fi

PORTS_FILE="$REPO_ROOT/configs/MacPortsfile"
if [[ -f "$PORTS_FILE" ]]; then
    echo "==> Installing ports from MacPortsfile..."
    grep -v '^#' "$PORTS_FILE" | xargs sudo port install
fi

echo "==> Reclaiming disk space from MacPorts..."
sudo port reclaim -uNqc
