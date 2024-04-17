return {
  -- LSP & TreeSitter
  { 'neovim/nvim-lspconfig', event = 'VeryLazy' }, -- enable LSP
  { 'mfussenegger/nvim-lint', event = 'VeryLazy' },
  { 'tamago324/nlsp-settings.nvim', event = 'VeryLazy' }, -- language server settings defined in json for
  'nvim-lua/plenary.nvim',
  { 'jose-elias-alvarez/typescript.nvim', event = 'VeryLazy' },
  { 'github/copilot.vim', event = 'InsertEnter' },

  -- DX
  { 'kazhala/close-buffers.nvim', event = 'BufRead' },
  { 'tpope/vim-surround', event = 'InsertEnter' },
  { 'folke/zen-mode.nvim', opts = {}, event = 'VeryLazy' },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  { 'junegunn/vim-easy-align', event = 'VeryLazy' },
  { 'mhinz/vim-grepper', event = 'VeryLazy' },
  {
    'kyazdani42/nvim-tree.lua',
    event = 'VeryLazy',
    config = function()
      require('nvim-tree').setup {}
    end,
  },
  { 'kyazdani42/nvim-web-devicons', event = 'VeryLazy' },
  {
    'norcalli/nvim-colorizer.lua',
    event = 'VeryLazy',
    config = function()
      require('colorizer').setup()
    end,
  },
}
