#!/usr/bin/env bash

REPO_ROOT="${BASH_SOURCE[0]%/*}/.."
CONFIG_HOME="$HOME/.config"
MY_CONFIGS="$REPO_ROOT/configs/.config"

mkdir -p "$CONFIG_HOME" || {
    echo "Failed to create $CONFIG_HOME"
    exit 1
}
shopt -s dotglob

skip=("." ".." ".gitignore")

for filepath in "$MY_CONFIGS"/* "$MY_CONFIGS"/.*; do
    file="${filepath%/}"
    file="${file##*/}"

    [[ " ${skip[@]} " =~ " ${file} " ]] && continue

    target="$CONFIG_HOME/$file"

    if [[ -L "$target" ]]; then
        echo "Unlinking $target"
        unlink "$target" || {
            echo "Failed to unlink $target"
            exit 1
        }
    elif [[ -d "$target" || -f "$target" ]]; then
        echo "Removing $target"
        rm -rf "$target" || {
            echo "Failed to remove $target"
            exit 1
        }
    fi

    echo "Linking $filepath $target"
    ln -sf "$filepath" "$target" || {
        echo "Failed to link $target"
        exit 1
    }
done
