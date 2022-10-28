local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local augroup = vim.api.nvim_create_augroup("general", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  group = augroup,
  pattern = { 'markdown' },
  callback = function()
    vim.opt.wrap = true
    keymap("n", "j", "gj", opts)
    keymap("n", "k", "gk", opts)
    keymap("n", "$", "g$", opts)
    keymap("n", "0", "g0", opts)
  end,
})

autocmd("FileType", {
  group = augroup,
  pattern = { 'php' },
  callback = function()
    vim.opt.shiftwidth = 4
    vim.opt.softtabstop = 4
    vim.opt.tabstop = 4
  end,
})

autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    vim.cmd "let winview = winsaveview()"
    vim.cmd ":%!ttw"
    vim.cmd "call winrestview(winview)"
  end
})

autocmd("FocusLost", {
  group = augroup,
  callback = function()
    vim.cmd 'colorscheme warlock'
    vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'
    vim.cmd "hi StatusLine guibg=NONE ctermbg=NONE"
    vim.cmd "hi CursorLine guibg=NONE ctermbg=NONE"
    vim.cmd "hi SignColumn guibg=NONE ctermbg=NONE"
    vim.cmd "hi LineNr guibg=NONE ctermbg=NONE"
    vim.cmd "hi CursorLineNr guibg=NONE ctermbg=NONE"
  end,
})

autocmd("FocusGained", {
  group = augroup,
  callback = function()
    vim.cmd 'colorscheme nordfox'
    vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'
    vim.cmd "hi StatusLine guibg=NONE ctermbg=NONE"
  end,
})
