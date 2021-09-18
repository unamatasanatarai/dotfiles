set path+=**
set encoding=utf-8 nobomb
syntax on

" keyboards {{{
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
" }}}

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu
" Ignore files
set wildignore+=*.pyc
set wildignore+=*.swp
set wildignore+=**/.DS_Store
set wildignore+=**/node_modules/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

" Highlight {{{
set nu rnu
highlight clear LineNr
highlight clear CursorLineNr
" }}}

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()


lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

" plugin: fzf {{{
set rtp+=/usr/local/bin/fzf
" plugin: fzf {{{
command! -bang -nargs=*  ProjectFiles
  \ call fzf#run(fzf#wrap({'source': 'rg --files --hidden --no-ignore-vcs --glob "!{node_modules/*,.git/*,vendor/*,*/.DS_Store}"', 'options': '--expect=ctrl-t,ctrl-x,ctrl-v --multi' }))
set rtp+=/usr/local/bin/fzf
nmap <C-P> :ProjectFiles<CR>
" }}}

" ripgrep fzf
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -- " . shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* Rga call fzf#vim#grep("rg --column --hidden --line-number --no-heading --color=always --smart-case -- " . shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
" }}}



" scroll sooner please
set scrolloff=4
set sidescrolloff=4
set sidescroll=1
filetype plugin indent on
" }}}

" text wrapping {{{
set nowrap
set showbreak=↪
set breakindent
set linebreak
" }}}


" permanent undo {{{
set history=9999
set undolevels=9999
set undofile
set updatecount=60              " update swapfiles every 60 typed characters
set updatetime=2000             " CursorHold interval
" }}}

" tmpfiles {{{
set directory=~/.cache/vim/tmp/swp
set backupdir=~/.cache/vim/tmp/backup
set undodir=~/.cache/vim/tmp/undo
set backupskip=/tmp/*,/private/tmp/*
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
