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
keymap("n", "_", ":vertical resize -3<CR>", opts)
keymap("n", "+", ":vertical resize +3<CR>", opts)

-- Misc Actions
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>s", ":nohl<CR>", opts)

-- Telescope
keymap("n", "<leader>fg", ":Telescope git_files<CR>", opts)
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fd", ":Telescope diagnostics<CR>", opts)

-- LSP
keymap("n", "gd", ":Telescope lsp_definitions<CR>", opts)
keymap("n", "gr", ":Telescope lsp_references<CR>", opts)
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", { silent = false, noremap = false})

-- VISUAL

-- Stay in ident mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("v", "p", '"_dP', opts)

-- CLIPBOARD Actions
keymap("v", "<leader>y", "+y", opts)

-- INSERT
keymap("i", "<C-f>", "<Right>", opts)
keymap("i", "<C-b>", "<Left>", opts)

