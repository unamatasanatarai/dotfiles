" reload automatically, if you modify this .vimrc
autocmd BufWritePost .vimrc source $MYVIMRC
" reload automatically, if local .virmc.local was updated
autocmd BufWritePost .vimrc.local source $MYVIMRC

" numbers and keybinding
set relativenumber
set number

" keybindings
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
inoremap jj <Esc>

" be quiet
set noerrorbells
set novisualbell


" start scrolling sooner
set scrolloff=2
set sidescrolloff=5
set sidescroll=1

" :find *fuzzy*
set path+=**

" finally
filetype plugin indent on

" read any possible local vim settings
if filereadable(glob(".vimrc.local"))
  source .vimrc.local
endif

