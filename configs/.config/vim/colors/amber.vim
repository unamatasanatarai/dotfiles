set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "amber"

hi Normal           guifg=#dd9000 guibg=NONE cterm=NONE gui=NONE
hi Comment          guifg=#aeae5a guibg=NONE cterm=standout gui=standout
hi Constant         guifg=#95CB82 gui=NONE cterm=NONE
hi String           guifg=#95cb82
hi Character        guifg=#95CB82
hi Number           guifg=#95CB82
hi Boolean          guifg=#95CB82
hi Float            guifg=#95CB82
hi Conditional      guifg=#71ade7
hi Function         guifg=#71ade7
hi FunctionCall     guifg=#ff0000
hi Identifier       guifg=#dd9000 gui=NONE cterm=NONE
hi Statement        guifg=#dd9000
hi Return           guifg=#ff0000
hi Operator         guifg=#71ade7
hi Repeat           guifg=#71ade7
hi Keyword          guifg=#dd9000
hi Type             guifg=#dd9000
hi Structure        guifg=#dd9000
hi PreProc          guifg=#dd9000
hi Special          guifg=#dd9000
hi Delimeter        guifg=#ff0000 guibg=#00ff00
hi SpecialComment   guifg=#71aed7 guibg=#1d292b gui=standout cterm=standout
hi Underlined       gui=underline
hi Italic           gui=standout cterm=standout
hi Todo             guifg=#ee2222 guibg=NONE gui=bold term=bold
hi Error            guifg=#c33c33 guibg=NONE
hi WarningMsg       guifg=#e1ad4c

hi Cursor           guibg=#cd974b guifg=#000000
hi CursorLine       guibg=NONE
hi CursorColumn     guibg=#343434
hi ColorColumn      guibg=#343434
hi CursorLineNr     guifg=#343434 gui=bold
hi LineNr           guifg=#343434
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

hi StatusLine       guifg=#343434 guibg=NONE cterm=NONE
hi StatusLineNC     guifg=#343434 guibg=NONE cterm=NONE
hi TabLine          guifg=#7d7d7d guibg=#162022 cterm=NONE
hi TabLineSel       guifg=#71aed7 guibg=#162022 cterm=NONE
hi TabLineFill      guibg=#162022 cterm=NONE
hi TabLineNC        guibg=NONE guifg=#dd9000 cterm=NONE
hi VertSplit        guifg=#2b3d40
hi Title            guifg=#dd9000

hi Search           guibg=#71ade7
hi IncSearch        guifg=#71ade7 gui=bold
hi MoreMsg          guifg=#95cb82 gui=bold
hi Question         guifg=#6abf40
hi Directory        guifg=#71aed7
hi SpecialKey       guifg=#343434
hi NonText          guifg=#343434
hi ExtraWhitespace  guibg=NONE guifg=NONE
hi ListChar         guibg=NONE guifg=NONE
hi EndOfBuffer      guifg=#343434
hi WildMenu         guibg=#585858

hi helpBar          guifg=#dd9000
hi helpStar         guifg=#dd9000
hi helpIgnore       guifg=#dd9000
hi helpHyperTextJump guifg=#71aed7

hi pythonBuiltin guifg=#dd9000
hi pythonClass guifg=#71aed7

hi shRange guifg=#71aed7
hi shQuote guifg=#dd9000
hi shTestOpr guifg=#dd9000
hi shHereString guifg=#dd9000
hi shDerefVar guifg=#dd9000
hi shOperator guifg=#dd9000
hi shLoop guifg=#71aed7
hi shForPP guifg=#dd9000
hi shNoQuote guifg=#dd9000

hi cIncluded guifg=NONE
