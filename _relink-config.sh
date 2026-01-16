#!/usr/bin/env bash

CONFIG_HOME="$HOME/.config"
MY_CONFIGS="$PWD/configs/.config"

mkdir -p "$CONFIG_HOME"
shopt -s dotglob

skip=("." ".." ".gitignore")

for filepath in "$MY_CONFIGS"/* "$MY_CONFIGS"/.*; do
    file="${filepath%/}"
    file="${file##*/}"

    [[ " ${skip[@]} " =~ " ${file} " ]] && continue

    target="$CONFIG_HOME/$file"

    if [[ -h "$target" ]]; then
        echo "Unlinking $target"
        unlink "$target"
    elif [[ -d "$target" || -f "$target" ]]; then
        echo "Removing $target"
        rm -rf "$target"
    fi

    echo "Linking $filepath $target"
    ln -sf "$filepath" "$target"
done
