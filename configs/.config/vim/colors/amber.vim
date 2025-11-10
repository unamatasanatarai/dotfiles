set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "amber"

" === Terminal colors ===
let g:terminal_ansi_colors = [
      \ "#000000", "#d2322d", "#6abf40", "#cd974b",
      \ "#217EBC", "#9B3596", "#178F79", "#ffb000",
      \ "#333333", "#c33c33", "#95cb82", "#dfdf8e",
      \ "#71aed7", "#2d3441", "#47BEA9", "#ffffff"
      \ ]

" === Core colors ===
let s:bg = "#0e1415"
let s:fg = "#ffb000"
let s:punct = "#71ade7"
let s:def = "#71ade7"
let s:const = "#2d3441"
let s:string = "#95cb82"
let s:comment = "#dfdf8e"
let s:dim_comment = "#696969"
let s:active = "#cd974b"
let s:statusline = "#2d3441"
let s:diffadd = "#6abf40"
let s:diffdelete = "#d2322d"
let s:diffchange = "#ec8013"
let s:mistake_bg = "#2b1d1e"
let s:mistake_fg = "#c33c33"
let s:error = "#d13e23"
let s:warn = "#f4b371"
let s:hint = "#8ebeec"
let s:info = "#88cc66"

" === Highlight Groups ===

hi Normal           guifg=#ffb000 guibg=NONE cterm=NONE
hi Comment          guifg=#dfdf8e gui=italic
hi Constant         guifg=#95CB82
hi String           guifg=#95cb82
hi Character        guifg=#95CB82
hi Number           guifg=#95CB82
hi Boolean          guifg=#95CB82
hi Float            guifg=#95CB82
hi Identifier       guifg=#ffb000
hi Function         guifg=#71ade7
hi Statement        guifg=#ffb000
hi Operator         guifg=#71ade7
hi Keyword          guifg=#ffb000
hi Type             guifg=#ffb000
hi Structure        guifg=#71ade7
hi PreProc          guifg=#ffb000
hi Special          guifg=#cd974b
hi SpecialComment   guifg=#71aed7 guibg=#1d292b gui=italic
hi Underlined       gui=underline
hi Italic           gui=italic
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
hi VertSplit        guifg=#2b3d40
hi Title            guifg=#2d3441

hi Search           guibg=#71ade7
hi IncSearch        guifg=#71ade7 gui=bold
hi MoreMsg          guifg=#95cb82 gui=bold
hi Question         guifg=#6abf40
hi Directory        guifg=#71aed7
hi SpecialKey       guifg=#585858                                                                            
hi NonText          guifg=#585858
hi EndOfBuffer      guifg=#585858
hi WildMenu         guibg=#585858
                    

hi DiagnosticError        guifg=#d13e23
hi DiagnosticWarn         guifg=#f4b371
hi DiagnosticHint         guifg=#8ebeec
hi DiagnosticInfo         guifg=#88cc66
hi DiagnosticVirtualTextError guifg=#D1503A guibg=#350B0B
hi DiagnosticVirtualTextWarn  guifg=#C8935D guibg=#3F240A
hi DiagnosticVirtualTextHint  guifg=#7E9CB9 guibg=#1D2B37
hi DiagnosticVirtualTextInfo  guifg=#7BAC62 guibg=#162C0B

hi LspReferenceText   guibg=#253437
hi LspReferenceRead   guibg=#253437
hi LspReferenceWrite  guibg=#253437 gui=underline guisp=#cd974b
hi LspCodeLens        guifg=#5c5c5c
hi LspCodeLensSeparator guifg=#5c5c5c

hi WinBar          guifg=#ffb000 guibg=#0e1415 gui=bold
hi WinBarNC        guifg=#7d7d7d guibg=#0e1415

" Done!

