scriptencoding utf-8
let s:middot='·'
let s:raquo='»'
let s:small_l='ℓ'

function! unamatasanatarai#foldtext#foldtext() abort
  let l:lines='[' . (v:foldend - v:foldstart + 1) . s:small_l . ']'
  let l:first=substitute(getline(v:foldstart), '\v *', '', '')
  let l:dashes=substitute(v:folddashes, '-', s:middot, 'g')
  return s:raquo . s:middot . s:middot . l:lines . l:dashes . ': ' . l:first
endfunction

"au FileType javascript call JavaScriptFold()
"function! unamatasanatarai#foldtext#JavaScriptFold()
"    setl foldmethod=syntax
"    setl foldlevelstart=0
"    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend
"
"    function! FoldText()
"        return substitute(getline(v:foldstart), '{.*', '{...}', '')
"    endfunction
"    setl foldtext=FoldText()
"endfunction
