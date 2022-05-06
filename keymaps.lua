local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ","
vim.g.maploaclleader = ","

keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>s", ":nohl<CR>", opts)
keymap("n", "_", ":vertical res -3<CR>", opts)
keymap("n", "+", ":vertical res +3<CR>", opts)

