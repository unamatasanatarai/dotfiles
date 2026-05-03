#!/usr/bin/env bash
REPO_ROOT="${BASH_SOURCE[0]%/*}/.."

while read -r from to; do
    [[ -z "$from" ]] && continue
    if [[ -L "$to" ]]; then
        echo "Unlinking $to"
        unlink "$to" || {
            echo "Failed to unlink $to"
            exit 1
        }
    fi
    if [[ -d "$to" || -f "$to" ]]; then
        echo "Removing $to"
        rm -rf "$to" || {
            echo "Failed to remove $to"
            exit 1
        }
    fi
    echo "linking $from $to"
    ln -sf "$from" "$to" || {
        echo "Failed to link $from to $to"
        exit 1
    }
done <<EOF
$HOME/.config/bash/bashrc $HOME/.bashrc
$HOME/.config/bash/bashrc $HOME/.bash_profile
$HOME/.config/bash/bashrc $HOME/.profile
$HOME/.config/bash/inputrc $HOME/.inputrc
$HOME/.config/bash/bash_logout $HOME/.bash_logout
$REPO_ROOT/configs/bin $HOME/bin
$HOME/.config/vim/vimrc $HOME/.vimrc
EOF
