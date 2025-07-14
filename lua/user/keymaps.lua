local opts = { noremap = true, silent = true }

vim.g.mapleader = ','
vim.g.maplocalleader = '\\'

-- Command
Keymap('c', '<C-o>', '%:p:h', opts)

Keymap('', '<F1>', '<Nop>', opts)
Keymap('n', '<F5>', ':cclose <cr>', opts)

Keymap('n', '<leader>S', ':setlocal spell!<CR>', opts)

-- Navigate tabs and buffers
Keymap('n', '<S-l>', ':tabn<CR>', opts)
Keymap('n', '<S-h>', ':tabp<CR>', opts)

Keymap('n', '<S-Left>', ':bn<CR>', opts)
Keymap('n', '<S-Right>', ':bp<CR>', opts)

-- Arrow keys for resizing
Keymap('n', '<M-Up>', ':resize +3<CR>', opts)
Keymap('n', '<M-Down>', ':resize -3<CR>', opts)

-- Buffers
Keymap('n', '<leader>bb', "<cmd>lua require('telescope.builtin').buffers({ layout_config={ width=0.5 }})<CR>", opts)
Keymap('n', '<leader>bd', ':bp | sp | bn | bd<CR>', opts)
Keymap('n', '<localleader>d', ':bp | sp | bn | bd<CR>', opts)
Keymap('n', '<leader>bD', ':%bd|e#<CR>', opts)
Keymap('n', '<localleader>n', ':bn<CR>', opts)
Keymap('n', '<localleader>p', ':bp<CR>', opts)
Keymap('n', '<localleader>b', ':BDelete ', opts)

-- Folding
Keymap('n', '<localleader>1', ':set foldlevel=0<CR>', opts)
Keymap('n', '<localleader>2', ':set foldlevel=1<CR>', opts)
Keymap('n', '<localleader>3', ':set foldlevel=2<CR>', opts)
Keymap('n', '<localleader>4', ':set foldlevel=3<CR>', opts)
Keymap('n', '<localleader>5', ':set foldlevel=4<CR>', opts)
Keymap('n', '<localleader>6', ':set foldlevel=5<CR>', opts)
Keymap('n', '<localleader>7', ':set foldlevel=6<CR>', opts)
Keymap('n', '<localleader>8', ':set foldlevel=7<CR>', opts)
Keymap('n', '<localleader>9', ':set foldlevel=99<CR>', opts)

-- Resize with arrows
Keymap('n', '<C-S-Up>', ':resize +3<CR>', opts)
Keymap('n', '<C-S-Down>', ':resize -3<CR>', opts)
Keymap('n', '<C-S-Left>', ':vertical resize -3<CR>', opts)
Keymap('n', '<C-S-Right>', ':vertical resize +3<CR>', opts)
Keymap('n', '_', ':vertical resize -3<CR>', opts)
Keymap('n', '+', ':vertical resize +3<CR>', opts)

-- Misc Actions
Keymap('n', '<leader>e', ':Neotree toggle<CR>', opts)
Keymap('n', '<localleader><localleader>', ':nohl<CR>', opts)
Keymap('n', '<localleader>=', '<c-w>=', opts)
Keymap('n', '<leader><leader>s', ':source ~/.config/nvim/lua/user/luasnip.lua<CR>', opts)
Keymap('n', '<leader><leader>r', ':luafile %<CR>', opts)
Keymap(
  'n',
  '<leader>/',
  ':lua require("telescope.builtin").current_buffer_fuzzy_find({ sorter = require(\'telescope.sorters\').get_substr_matcher({})})<CR>',
  opts
)
Keymap('n', '<leader><leader>/', ":lua require('spectre').open()<CR>", opts)
Keymap('n', '<leader><leader>e', ':e <C-r>=expand("%:p:h")<CR>/', opts)
-- Keymap('n', '<localleader>cd', ':Copilot disable<CR>', opts)
-- Keymap('n', '<localleader>ce', ':Copilot enable<CR>', opts)
Keymap('n', '<localleader>e', ':Oil<CR>', opts)
Keymap('n', '<localleader>t', ':tabe term://zsh<CR>', opts)
Keymap('n', ',p', ':let @+ = expand("%")<cr>', opts)
Keymap('n', '[b', ':bp<CR>', opts)
Keymap('n', ']b', ':bn<CR>', opts)

Keymap('n', '<localleader>z', ':ZenMode<CR>', opts)

-- VISUAL

-- Stay in ident mode
Keymap('v', '<', '<gv', opts)
Keymap('v', '>', '>gv', opts)

-- CLIPBOARD Actions
Keymap('v', '<leader>y', '"+y', opts)
Keymap('n', '<leader>p', '"+p', opts)

-- INSERT
Keymap('i', '<C-f>', '<Right>', opts)
Keymap('i', '<C-b>', '<Left>', opts)

-- Option Do stuff like emacs in insert mode
Keymap('i', '<M-f>', '<Esc>lwwi', opts)
Keymap('i', '<M-b>', '<Esc>bi', opts)
Keymap('i', '<M-d>', '<Esc>ldwi', opts)

-- Claude Code
Keymap('n', '<F9>', ':ClaudeCode<CR>', opts)
Keymap('i', '<F9>', '<Esc>:ClaudeCode<CR>', opts)
Keymap('v', '<F9>', '<Esc>:ClaudeCode<CR>', opts)
Keymap('t', '<F9>', '<C-\\><C-n>:ClaudeCode<CR>', opts)

-- Copy filename and line range to * register
Keymap('v', '<localleader>c', ':<C-u>let @* = "@" . expand("%:~:.") . "#L" . line("\'<") . "-" . line("\'>")<CR>', opts)

-- Convert tag to JSX Fragment
Keymap('n', '<leader>jf', '%ldiw<C-o>diw', { noremap = false, silent = true })

-- Copilot Mapping
-- vim.api.nvim_set_keymap('i', '<M-i>', 'copilot#Accept("<CR>")', { silent = true, expr = true })
-- vim.g.copilot_no_tab_map = true
-- vim.g.copilot_assume_mapped = true
-- vim.g.copilot_tab_fallback = ''

-- Mouse
vim.api.nvim_set_keymap(
  'n',
  '<LeftMouse>',
  '<LeftMouse><cmd>lua vim.lsp.buf.hover({border = "single"})<CR>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  'n',
  '<RightMouse>',
  '<LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>',
  { noremap = true, silent = true }
)
