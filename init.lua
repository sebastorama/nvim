require('user.globals')

require('user.options')
-- Lazy nvim setup
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
--
require('user.keymaps')
require('user.autocmd')
require('user.commands')
require('lazy').setup('plugins')
require('user.lsp')

vim.cmd [[colorscheme tokyonight ]]
