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
