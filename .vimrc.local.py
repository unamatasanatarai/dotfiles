autocmd BufWritePost .vimrc.local source $MYVIMRC

au BufNewFile,BufRead *.py 
    \ set tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=79
    \ expandtab
    \ autoindent
    \ fileformat=unix

let b:ale_linters = ['pylint']
let g:ale_python_pylint_options = '--load-plugins pylint_django --disable=missing-docstring'
