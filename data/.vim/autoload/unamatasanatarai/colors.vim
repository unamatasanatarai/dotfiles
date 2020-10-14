scriptencoding utf-8

function! unamatasanatarai#colors#termgui() abort
    set termguicolors
    let &t_8f="\e[38;2;%ld;%ld;%ldm"
    let &t_8b="\e[48;2;%ld;%ld;%ldm"
    set background=dark
endfunction
