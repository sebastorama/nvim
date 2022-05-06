vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'tpope/vim-surround'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    }
  }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use 'navarasu/onedark.nvim'
end)

