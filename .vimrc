" reload automatically, if you modify this .vimrc
autocmd BufWritePost .vimrc source $MYVIMRC

" numbers and keybinding
set relativenumber
set number
nmap <Leader>nu :set nu! rnu!<CR>

" highlighting lines
highlight clear LineNr
highlight clear CursorLineNr
set ruler

" search normalization
set incsearch
set hlsearch
set smartcase
highlight clear Search
highlight       Search    ctermfg=White  ctermbg=Black  cterm=bold
highlight    IncSearch    ctermfg=White  ctermbg=Red    cterm=bold

" window decorations
set cursorline
set title
set titleold=
set showtabline=1
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

" text wrapping. Typically I don't like it. so by default, it's a no no
set nowrap
set wrapmargin=0
set breakindentopt=shift:2,sbr
set showbreak=↪
set breakindent
set linebreak

" intentation
set autoindent
set smartindent
set expandtab
set smarttab

" IDE
set autowrite
set autoread
syntax on
set wildmenu
set wildmode=full
set tabstop=2
set softtabstop=2
set shiftwidth=2
set matchpairs+=<:>

" :find *fuzzy*
set path+=**

" be quiet
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" file browser Vex
let g:netrw_browse_split=4
let g:netrw_banner=0
let g:netrw_liststyle=3

" feel me
set nocompatible
set history=999
set undolevels=999

" start scrolling sooner
set scrolloff=2
set sidescrolloff=5
set sidescroll=1

" 100 characters line
"hi ColorColumn ctermbg=darkgrey ctermfg=black guibg=darkgrey guifg=black
"set colorcolumn=100
highlight OverLength ctermfg=darkgray guifg=darkgray
match OverLength /\%81v.\+/

" status bar
set laststatus=2
set statusline=\ %-.42f\ %m%=%l:%c\ 

" invisible characters
set listchars=tab:▹\ ,trail:·,nbsp:⚋,extends:»,precedes:«
set fillchars=fold:-
set list

" fix some keys please // aka: hardMode
nnoremap <BS> <NOP>

inoremap <Up> <NOP>
noremap <Up> <NOP>

inoremap <Down> <NOP>
noremap <Down> <NOP>

inoremap <Left> <NOP>
noremap <Left> <NOP>

inoremap <Right> <NOP>
noremap <Right> <NOP>
" quick save
nmap ,w :w<CR>

" Delete trailing white space on save
fun! TrimTrailingWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
autocmd BufWritePre *.php,*.js :call TrimTrailingWhitespace()

" ctrlp
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=100
let g:ctrlp_dotfiles=1
let g:ctrlp_show_hidden=1
let g:ctrlp_switch_buffer=0
let g:ctrlp_working_path_mode=0

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" finally
filetype plugin indent on

" read any possible local vim settings
if filereadable(glob(".vimrc.local"))
  source .vimrc.local
endif
