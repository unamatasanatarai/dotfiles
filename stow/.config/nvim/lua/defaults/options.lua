local g = vim.g
local opt = vim.opt

-- Lua filetype detection
g.do_filetype_lua = 1
g.did_load_filetypes = 0

-- Skip providers
g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

-- Disable distribution plugins
g.zipPlugin = 0
g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_2html_plugin = 1
g.highlighturl_enabled = 1
g.load_black = 0
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
g.loaded_netrwFileHandlers = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_remote_plugins = 1

-- Options
opt.cursorline = true
opt.completeopt = 'menuone,noselect'
opt.hidden = true
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.lazyredraw = true
opt.list = true
opt.listchars = {
  --eol = '¬',
  tab = '▷ ',
  trail = '·',
  nbsp = '␣',
  extends = '»',
  precedes = '«',
}
opt.backup = false
opt.writebackup = false
opt.showmode = false
opt.swapfile = false
opt.scrolloff = 5
opt.shortmess:append 'c'
opt.shortmess:append 'I'
opt.splitright = true
opt.tags = './tags;,tags'
opt.ttimeoutlen = 10
opt.wildignorecase = true
opt.wildignore = '.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**';
opt.clipboard = 'unnamedplus'
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.laststatus = 2
opt.cmdheight = 2
opt.history = 100
opt.signcolumn = 'yes'
opt.pumheight = 10
opt.undofile = true
opt.updatetime = 300

opt.ttyfast = true
opt.expandtab = true
opt.autoindent = true
-- opt.copyindent = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
-- opt.breakindent = true
-- opt.preserveindent = true


---- local options = {
--  backup = false,                          -- creates a backup file
--  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
--  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
--  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
--  conceallevel = 0,                        -- so that `` is visible in markdown files
--  fileencoding = "utf-8",                  -- the encoding written to a file
--  hlsearch = true,                         -- highlight all matches on previous search pattern
--  ignorecase = true,                       -- ignore case in search patterns
--  mouse = "a",                             -- allow the mouse to be used in neovim
--  pumheight = 10,                          -- pop up menu height
--  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
--  showtabline = 2,                         -- always show tabs
--  smartcase = true,                        -- smart case
--  smartindent = true,                      -- make indenting smarter again
--  splitbelow = true,                       -- force all horizontal splits to go below current window
--  splitright = true,                       -- force all vertical splits to go to the right of current window
--  swapfile = false,                        -- creates a swapfile
--  termguicolors = true,                    -- set term gui colors (most terminals support this)
--  timeoutlen = 400,                        -- time to wait for a mapped sequence to complete (in milliseconds)
--  undofile = true,                         -- enable persistent undo
--  updatetime = 300,                        -- faster completion (4000ms default)
--  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
--  expandtab = true,                        -- convert tabs to spaces
--  shiftround = true,
--  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
--  softtabstop = 2,
--  tabstop = 2,                             -- insert 2 spaces for a tab
--  autoindent = true,
--  smartindent = true,
--  smarttab = true,
--  copyindent = true,
--  cursorline = true,                       -- highlight the current line
--  number = true,                           -- set numbered lines
--  relativenumber = true,                   -- set relative numbered lines
--  numberwidth = 4,                         -- set number column width to 2 {default 4}
--  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
--  wrap = false,                            -- display lines as one long line
--  scrolloff = 8,                           -- is one of my fav
--  sidescrolloff = 8,
--  guifont = "monospace:h17",               -- the font used in graphical neovim applications
--  listchars = "tab:▷ ,trail:·,extends:»,precedes:«,nbsp:␣",
--  list = true,
--}
--
--vim.opt.shortmess:append "c"
--
--for k, v in pairs(options) do
--  vim.opt[k] = v
--end
--
--vim.cmd "filetype plugin indent on"
--vim.cmd "set whichwrap+=<,>,[,],h,l"
--vim.cmd [[set iskeyword+=-]]
--vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
