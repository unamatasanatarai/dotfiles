local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("i", "jj", "<ESC>", opts)
keymap("i", "jk", "<ESC>", opts)
keymap("n", "<leader>w", ":w<cr>", opts)

keymap("n", "<C-p>", ":Telescope find_files<cr>", opts)
keymap("n", "<C-g>", ":Telescope live_grep<cr>", opts)
