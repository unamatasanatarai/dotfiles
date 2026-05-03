#!/usr/bin/env bash
#
# Environment Preparation
#
# This script handles directory creation and initial setup.
# It also ensures the Terminal has the necessary permissions to proceed.

echo "Checking Full Disk Access..."
if ! ls ~/Library/Messages &>/dev/null; then
    echo ">>> Terminal needs Full Disk Access to set system-level defaults."
    echo ">>> Opening Privacy settings for you..."
    open "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles"
    echo ">>> Please grant Full Disk Access to your Terminal and then RESTART the installation process."
    exit 1
else
    echo "Full Disk Access confirmed."
fi

#at the moment of installation, bash is not yet configured. So import the defaults
REPO_ROOT="$(cd -- "${BASH_SOURCE[0]%/*}/.." && pwd -P)"
source "$REPO_ROOT/configs/.config/bash/src/xdg"
LOCAL_BIN="$HOME/.local/bin"
BASH_DATA_HOME="$XDG_DATA_HOME/bash"

dir_vars=(
    LOCAL_BIN
    BASH_DATA_HOME
    XDG_CACHE_HOME
    XDG_CONFIG_HOME
    XDG_DATA_HOME
    XDG_STATE_HOME
)

for var in "${dir_vars[@]}"; do
    dir="${!var}"
    mkdir -vp "$dir" || {
        echo "Failed to create directory $dir"
        exit 1
    }
done
