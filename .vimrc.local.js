let g:auto_save = 1  " enable AutoSave on Vim startup
let g:ale_fixers = {'javascript': ['eslint']}
let b:ale_linters = {'javascript': ['eslint']}
let g:ale_fix_on_save = 1
nnoremap <leader>f :ALEFix<CR>
