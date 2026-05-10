#!/usr/bin/env bash

script_dir="${BASH_SOURCE[0]%/*}"
[[ "$script_dir" == "${BASH_SOURCE[0]}" ]] && script_dir="."

cd -- "$script_dir/.." || {
    printf "Error: Could not change to repository root\n" >&2
    exit 1
}

if ! ./scripts/install-brew.sh; then
    printf "Error: install-brew.sh failed\n" >&2
    exit 1
fi

os_vers=$(sw_vers -productVersion) || {
    printf "Error: Failed to get macOS version\n" >&2
    exit 1
}
os_major="${os_vers%%.*}"

if [[ "$os_major" == "12" ]]; then
    printf "==> macOS 12 detected. Installing MacPorts and yabai...\n"
    
    if ! ./scripts/install-brew-monterey.sh; then exit 1; fi
    if ! ./scripts/install-macports.sh; then exit 1; fi
    
    cd configs/.config/skhd || exit 1
    [[ -e skhdrc || -L skhdrc ]] && unlink skhdrc
    if ! ln -sf skhdrc-monterey skhdrc; then
        printf "Error: Failed to link skhdrc-monterey\n" >&2
        exit 1
    fi
    cd - >/dev/null || exit 1
else
    printf "==> macOS newer than 12 detected. Installing brew only with aerospace...\n"
    
    if ! ./scripts/install-brew-sonoma.sh; then exit 1; fi
    
    cd configs/.config/skhd || exit 1
    [[ -e skhdrc || -L skhdrc ]] && unlink skhdrc
    if ! ln -sf skhdrc-sonoma skhdrc; then
        printf "Error: Failed to link skhdrc-sonoma\n" >&2
        exit 1
    fi
    cd - >/dev/null || exit 1
fi
