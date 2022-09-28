local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

vim.cmd([[startinsert!]])

keymap("i", "<S-CR>", "<ESC>ZZ", opts)
