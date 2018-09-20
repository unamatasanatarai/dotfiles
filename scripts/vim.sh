#!/usr/bin/env bash

. ./_utils.sh

say "Installing vim goodness"

cd ~
rm -f .vimrc
wget https://raw.githubusercontent.com/unamatasanatarai/dotfiles/master/data/.vimrc

mkdir -p ".vim/pack/vendor/start"
cd !$
git clone --depth=1 https://github.com/ctrlpvim/ctrlp.vim.git
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git
git clone --depth=1 https://github.com/907th/vim-auto-save.git
vi "+helptags ~/.vim/pack/vendor/start/syntastic/doc" +qall
vi "+helptags ~/.vim/pack/vendor/start/ctrlp.vim/doc" +qall
vi "+helptags ~/.vim/pack/vendor/start/vim-auto-save/doc" +qall

say_done
