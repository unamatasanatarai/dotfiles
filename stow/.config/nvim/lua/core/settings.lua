local g = vim.g
local opt = vim.opt

-- Lua filetype detection
g.do_filetype_lua = 1
g.did_load_filetypes = 0

-- UX
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.scrolloff = 4
opt.cursorline = true
opt.laststatus = 2
opt.list = true
opt.listchars = {
--  eol = '↩',
  tab = '▷ ',
  trail = '·',
  nbsp = '␣',
  extends = '»',
  precedes = '«',
}

-- View
opt.wrap = false
opt.linebreak = true -- wrap should take place on space, not midword
opt.fileencoding = "utf-8"
opt.showmode = false
opt.showcmd = false

-- Search
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wildignorecase = true
opt.wildignore = '.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**';
opt.clipboard = 'unnamedplus'

-- Indents
opt.autoindent = true
opt.breakindent = true
opt.copyindent = true
opt.expandtab = true
opt.preserveindent = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2

-- History
opt.history = 100
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.swapfile = false

-- Tooling
opt.cmdheight = 1
opt.pumheight = 10

-- BUCKET
opt.completeopt = 'menuone,noselect'
opt.hidden = true
opt.lazyredraw = true
opt.shortmess:append 'c'
opt.shortmess:append 'I'
opt.splitright = true
opt.timeoutlen = 200
-- I do not like mouse
opt.mouse=

vim.cmd "syntax on"
-- well, off + on is a stupid hack. But it WORKS.
vim.cmd "filetype off"
vim.cmd "filetype plugin indent on"
vim.cmd "set nofixendofline"
vim.cmd "set noeol"
