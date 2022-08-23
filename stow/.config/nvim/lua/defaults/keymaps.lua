local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("i", "jj", "<ESC>", opts)
keymap("n", "<leader>w", ":w<cr>", opts)
keymap("n", "<leader>bp", ":lua vim.lsp.buf.formatting_sync()<CR>", opts)

-- keymap("n", "<C-p>", ":Telescope find_files find_command=rg,--hidden,--no-ignore,--files<cr>", opts)
keymap("n", "<C-p>", ":Telescope find_files<cr>", opts)
keymap("n", "<C-g>", ":Telescope live_grep<cr>", opts)
