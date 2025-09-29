local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("i", "jj", "<ESC>", { noremap = true, silent = true })
keymap("i", "jk", "<ESC>", { noremap = true, silent = true })
keymap("n", "<leader>w", ":w<cr>", { noremap = true, silent = true, desc = "write" })

keymap("n", "<C-p>", ":Telescope find_files<cr>", { noremap = true, silent = true })
keymap("n", "<C-g>", ":Telescope live_grep<cr>", { noremap = true, silent = true })

keymap("n", "<leader>ss", ":let winview = winsaveview()<cr> | :execute '%!ttw'<cr> | :call winrestview(winview)<cr>",
  { desc = "trim trailing whitespace", noremap = true, silent = true })
