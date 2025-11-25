#!/usr/bin/env bash

symlink_config() {
    local from="$1"
    local to="$2"
    [[ -h "$to" ]] && echo "Unlinking $to" && unlink "$to"
    [[ -d "$to" || -f "$to" ]] && echo "Removing $to" && rm -rf "$to"
    echo "linking $form $to" && ln -sf "$from" "$to"
}

symlink_config "$HOME/.config/bash/bashrc" "$HOME/.bashrc" 
symlink_config "$HOME/.config/bash/bashrc" "$HOME/.bash_profile" 
symlink_config "$HOME/.config/bash/bashrc" "$HOME/.profile" 
symlink_config "$HOME/.config/bash/inputrc" "$HOME/.inputrc" 
symlink_config "$HOME/.config/bash/bash_logout" "$HOME/.bash_logout" 
symlink_config "$PWD/configs/bin" "$HOME/bin" 
symlink_config "$HOME/.config/vim/vimrc" "$HOME/.vimrc" 
