" this was causing strange errors
"let loaded_matchparen = 1
" general setting {{{
set encoding=utf-8 nobomb
set nocompatible
set ruler
syntax on
set autowrite
set title
set laststatus=2
set listchars=tab:▹\ ,trail:·,nbsp:⚋,extends:»,precedes:«
set list
set lazyredraw
set termguicolors
call unamatasanatarai#colors#termgui()
set background=dark
set shortmess+=A                      " ignore annoying swapfile messages
set shortmess+=I                      " no splash screen
set shortmess+=O                      " file-read message overwrites previous
set shortmess+=T                      " truncate non-file messages in middle
set shortmess+=W                      " don't echo "[w]"/"[written]" when writing
set shortmess+=a                      " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set shortmess+=o                      " overwrite file-written messages
set shortmess+=t                      " truncate file messages at start
autocmd InsertEnter * norm zz         " Automatic vertical centering on entering insert mode
" }}}

" be quiet {{{
set noerrorbells
set novisualbell
" }}}

