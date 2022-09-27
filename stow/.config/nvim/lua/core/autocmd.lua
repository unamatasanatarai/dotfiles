local opt = vim.opt
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local augroup = vim.api.nvim_create_augroup("general", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  group = augroup,
  pattern = { 'markdown' },
  callback = function()
    opt.wrap = true
    keymap("n", "j", "gj", opts)
    keymap("n", "k", "gk", opts)
    keymap("n", "$", "g$", opts)
    keymap("n", "0", "g0", opts)
  end,
})
autocmd("FocusLost", {
  group = augroup,
  callback = function()
    vim.cmd 'colorscheme warlock'
  end,
})
autocmd("FocusGained", {
  group = augroup,
  callback = function()
    vim.cmd 'colorscheme nordfox'
  end,
})
