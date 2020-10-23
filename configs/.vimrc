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

" folding {{{
if has('windows')
    set fillchars=vert:┃
    set fillchars+=fold:·
endif
set foldmethod=indent
set foldlevelstart=99
set foldtext=unamatasanatarai#foldtext#foldtext()
" }}}

" numbers {{{
set relativenumber
set number
highlight clear LineNr
highlight clear CursorLineNr
" }}}

" permanent undo {{{
set history=9999
set undolevels=9999
set undodir=~/.vim/tmp/undo
set undofile
set updatecount=60              " update swapfiles every 60 typed characters
set updatetime=2000             " CursorHold interval
" }}}

" swapfile {{{
set directory=~/.vim/tmp/swp
" }}}

" Don’t create backups when editing files in certain directories {{{
set backupdir=~/.vim/tmp/backup
set backupskip=/tmp/*,/private/tmp/*
" }}}
"
" keybindings {{{
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
inoremap jj <Esc>
" }}}

" be quiet {{{
set noerrorbells
set novisualbell
" }}}

" searching {{{
set incsearch
set hlsearch
set ignorecase
set smartcase
highlight clear Search
highlight       Search    ctermfg=White  ctermbg=Gray  cterm=bold
highlight    IncSearch    ctermfg=White  ctermbg=Red    cterm=bold
" }}}

" text wrapping {{{
set nowrap
set showbreak=↪
set breakindent
set linebreak
" }}}

" intentation {{{
set autoindent
set smarttab
set shiftround
set shiftwidth=4
set expandtab
" }}}

" autocomplete {{{
set wildmode=longest,list,full
set wildmenu
set wildignore=*.pyc,*.swp
set wildignore+=*/.git/*,*/.DS_Store
" }}}

" start scrolling sooner {{{
set scrolloff=4
set sidescrolloff=4
set sidescroll=1
" }}}

" :find *fuzzy* {{{
set path+=**
" }}}

" read .vimrc.local file if exists {{{
if filereadable(glob(".vimrc.local"))
    source .vimrc.local
endif
" }}}

" plugin: fzf {{{
" set rtp+=/usr/local/bin/fzf
nmap <C-P> :GFiles<CR>
" }}}

" the end {{{
filetype plugin indent on
" }}}

