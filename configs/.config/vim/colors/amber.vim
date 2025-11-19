set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "amber"


hi Normal           guifg=#ffb000 guibg=NONE cterm=NONE gui=NONE
hi Comment          guifg=#dfdf8e guibg=NONE cterm=standout gui=standout
hi Constant         guifg=#95CB82 gui=NONE cterm=NONE
hi String           guifg=#95cb82
hi Character        guifg=#95CB82
hi Number           guifg=#95CB82
hi Boolean          guifg=#95CB82
hi Float            guifg=#95CB82
hi Conditional      guifg=#71ade7
hi Function         guifg=#71ade7
hi FunctionCall     guifg=#ff0000
hi Identifier       guifg=#ffb000 gui=NONE cterm=NONE
hi Statement        guifg=#ffb000
hi Return           guifg=#ff0000
hi Operator         guifg=#71ade7
hi Repeat           guifg=#71ade7
hi Keyword          guifg=#ffb000
hi Type             guifg=#ffb000
hi Structure        guifg=#ffb000
hi PreProc          guifg=#ffb000
hi Special          guifg=#ffb000
hi Delimeter        guifg=#ff0000 guibg=#00ff00
hi SpecialComment   guifg=#71aed7 guibg=#1d292b gui=standout cterm=standout
hi Underlined       gui=underline
hi Italic           gui=standout cterm=standout
hi Todo             guifg=#0e1415 guibg=#d0d058
hi Error            guifg=#c33c33 guibg=NONE
hi WarningMsg       guifg=#e1ad4c

hi Cursor           guibg=#cd974b guifg=#000000
hi CursorLine       guibg=NONE
hi CursorColumn     guibg=#182325
hi CursorLineNr     guifg=#585858 gui=bold
hi LineNr           guifg=#585858
hi ColorColumn      guibg=#182325
hi VertSplit        guifg=#2b3d40
hi Visual           guibg=#293334
hi Folded           guifg=#7d7d7d guibg=#182325
hi FoldColumn       guifg=#4d4d4d guibg=#0e1415
hi SignColumn       guibg=NONE
hi DiffAdd          guibg=#244032 guifg=#56d364
hi DiffDelete       guibg=#462c32 guifg=#f85149
hi DiffChange       guibg=#341a00 guifg=#e3b341
hi DiffText         guibg=#fff987 guifg=#341a00
hi MatchParen       gui=underline guisp=#cd974b

hi Pmenu            guibg=#182325
hi PmenuSel         guibg=#354c50
hi PmenuSbar        guibg=#212f31
hi PmenuThumb       guibg=#47666b

hi StatusLine       guifg=#585858 guibg=NONE cterm=NONE
hi StatusLineNC     guifg=#585858 guibg=NONE cterm=NONE
hi TabLine          guifg=#7d7d7d guibg=#162022 cterm=NONE
hi TabLineSel       guifg=#71aed7 guibg=#162022 cterm=NONE
hi TabLineFill      guibg=#162022 cterm=NONE
hi TabLineNC        guibg=NONE guifg=#ffb000 cterm=NONE
hi VertSplit        guifg=#2b3d40
hi Title            guifg=#ffb000

hi Search           guibg=#71ade7
hi IncSearch        guifg=#71ade7 gui=bold
hi MoreMsg          guifg=#95cb82 gui=bold
hi Question         guifg=#6abf40
hi Directory        guifg=#71aed7
hi SpecialKey       guifg=#585858
hi NonText          guifg=#585858
hi ExtraWhitespace  guibg=NONE guifg=NONE
hi ListChar         guibg=NONE guifg=NONE
hi EndOfBuffer      guifg=#585858
hi WildMenu         guibg=#585858

hi helpBar          guifg=#ffb000
hi helpStar         guifg=#ffb000
hi helpIgnore       guifg=#ffb000
hi helpHyperTextJump guifg=#71aed7

hi pythonBuiltin guifg=#ffb000
hi shRange guifg=#71aed7

" check what is under cursor
nnoremap <leader>i :echo synIDattr(synID(line('.'), col('.'), 1), 'name')<CR>

