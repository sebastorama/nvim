local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ","
vim.g.maploaclleader = ","

-- Command
keymap("c", "<C-o>", "%:p:h", opts)

keymap("", "<F1>", "<Nop>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<leader>S", ":setlocal spell!<CR>", opts)

-- Navigate tabs and buffers
keymap("n", "<S-l>", ":tabn<CR>", opts)
keymap("n", "<S-h>", ":tabp<CR>", opts)

keymap("n", "<Left>", ":tabm -1<CR>", opts)
keymap("n", "<Right>", ":tabm +1<CR>", opts)

keymap("n", "<S-Left>", ":bn<CR>", opts)
keymap("n", "<S-Right>", ":bp<CR>", opts)

-- Arrow keys for resizing
keymap("n", "<Up>", ":resize +3<CR>", opts)
keymap("n", "<Down>", ":resize -3<CR>", opts)

-- Buffers
keymap("n", "<leader>bb", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>bd", ":bp | sp | bn | bd<CR>", opts)
keymap("n", "<localleader>d", ":bp | sp | bn | bd<CR>", opts)
keymap("n", "<leader>bD", ":%bd|e#<CR>", opts)
keymap("n", "<localleader>n", ":bn<CR>", opts)
keymap("n", "<localleader>p", ":bp<CR>", opts)

-- Resize with arrows
keymap("n", "<C-S-Up>", ":resize +3<CR>", opts)
keymap("n", "<C-S-Down>", ":resize -3<CR>", opts)
keymap("n", "_", ":vertical resize -3<CR>", opts)
keymap("n", "+", ":vertical resize +3<CR>", opts)

-- Misc Actions
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "<localleader><localleader>", ":nohl<CR>", opts)
keymap("n", "<leader><leader>s", ":source ~/.config/nvim/lua/user/luasnip.lua<CR>", opts)
keymap("n", "<leader><leader>r", ":luafile %<CR>", opts)
keymap(
  "n",
  "<leader>/",
  ":lua require(\"telescope.builtin\").current_buffer_fuzzy_find({ sorter = require('telescope.sorters').get_substr_matcher({})})<CR>",
  opts
)
keymap("n", "<leader><leader>/", ":lua require('spectre').open()<CR>", opts)
keymap("n", "<leader><leader>e", ":e %:p:h", opts)
keymap("n", "<localleader>cd", ":Copilot disable<CR>", opts)
keymap("n", "<localleader>ce", ":Copilot enable<CR>", opts)
keymap("n", "<localleader>e", ":Exp<CR>", opts)
keymap("n", "<localleader>t", ":tabe term://zsh<CR>", opts)

-- VISUAL

-- Stay in ident mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- CLIPBOARD Actions
keymap("v", "<leader>y", '"+y', opts)
keymap("n", "<leader>p", '"+p', opts)

-- INSERT
keymap("i", "<C-f>", "<Right>", opts)
keymap("i", "<C-b>", "<Left>", opts)
