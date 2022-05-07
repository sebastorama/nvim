local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ","
vim.g.maploaclleader = ","

-- NORMAL

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<leader>S", ":setlocal spell!<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Resize with arrows
keymap("n", "<C-S-Up>", ":resize +3<CR>", opts)
keymap("n", "<C-S-Down>", ":resize -3<CR>", opts)
keymap("n", "<C-S-Left>", ":vertical resize -3<CR>", opts)
keymap("n", "<C-S-Right>", ":vertical resize +3<CR>", opts)

-- Misc Actions
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>s", ":nohl<CR>", opts)

-- Telescope
keymap("n", "<leader>fg", ":Telescope git_files<CR>", opts)
-- VISUAL

-- Stay in ident mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("v", "p", '"_dP', opts)

