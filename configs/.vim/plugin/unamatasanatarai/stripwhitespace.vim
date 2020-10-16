scriptencoding utf-8
" Strip trailing whitespace (<Leader>ss)
function! unamatasanatarai#stripwhitespace#stripwhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>ss :call unamatasanatarai#stripwhitespace#stripwhitespace()<CR>
