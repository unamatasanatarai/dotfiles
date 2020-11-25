source ~/.vim/cfg/general.vim
source ~/.vim/cfg/folding.vim
source ~/.vim/cfg/numbers.vim
source ~/.vim/cfg/keyboard.vim
source ~/.vim/cfg/tmpfiles.vim
source ~/.vim/cfg/undo.vim

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
set rtp+=/usr/local/bin/fzf
" plugin: fzf {{{	" plugin: fzf {{{
command! -bang -nargs=*  ProjectFiles
  \ call fzf#run(fzf#wrap({'source': 'rg --files --hidden --no-ignore-vcs --glob "!{node_modules/*,.git/*,vendor/*}"', 'options': '--expect=ctrl-t,ctrl-x,ctrl-v --multi' }))
set rtp+=/usr/local/bin/fzf
nmap <C-P> :ProjectFiles<CR>
" }}}

" ripgrep fzf {{{
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, <bang>0)
" }}}

" the end {{{
filetype plugin indent on
" }}}

