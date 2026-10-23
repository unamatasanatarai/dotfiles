#!/usr/bin/env bash
REPO_ROOT="$(cd -- "${BASH_SOURCE[0]%/*}/.." && pwd -P)"

echo "==> Setting up MacPorts..."
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

if ! command -v port >/dev/null 2>&1; then
    echo "MacPorts is not installed. Installing MacPorts..."

    echo "==> The MacPorts installer requires administrator privileges."
    echo "==> Please enter your Mac password when prompted to authenticate sudo."

    pkg_dir=$(mktemp -d) || exit 1
    trap 'rm -rf "$pkg_dir"' EXIT
    pkg="$pkg_dir/MacPorts.pkg"

    curl -fL "https://github.com/macports/macports-base/releases/download/v2.12.5/MacPorts-2.12.5-12-Monterey.pkg" -o "$pkg" || {
        echo "Failed to download MacPorts installer"
        exit 1
    }
    # Gatekeeper check: must be signed and notarized before it runs as root
    spctl --assess --type install "$pkg" || {
        echo "MacPorts installer failed signature verification"
        exit 1
    }
    sudo installer -pkg "$pkg" -target / || {
        echo "Failed to install MacPorts"
        exit 1
    }
fi

PORTS_FILE="$REPO_ROOT/configs/MacPortsfile"
if [[ -f "$PORTS_FILE" ]]; then
    echo "==> Installing ports from MacPortsfile..."
    grep -v '^#' "$PORTS_FILE" | xargs sudo port install
fi

echo "==> Reclaiming disk space from MacPorts..."
sudo port reclaim -uNqc
