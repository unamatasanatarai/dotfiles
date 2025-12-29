#!/usr/bin/env bash

if ! command -v brew &>/dev/null; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle install --file=./configs/Brewfile

cp ./configs/fonts/source-code-pro/* /Library/Fonts/
cp ./configs/fonts/archivo/*.ttf /Library/Fonts/
cp ./configs/fonts/archivo/static/*.ttf /Library/Fonts/
fc-cache -fv > /dev/null
