return {
  -- LSP & TreeSitter
  { 'neovim/nvim-lspconfig', event = 'VeryLazy' }, -- enable LSP
  { 'mfussenegger/nvim-lint', event = 'VeryLazy' },
  { 'tamago324/nlsp-settings.nvim', event = 'VeryLazy' }, -- language server settings defined in json for
  'nvim-lua/plenary.nvim',

  -- DX
  -- { 'github/copilot.vim',         event = 'InsertEnter' },
  { 'kazhala/close-buffers.nvim', event = 'BufRead' },
  {
    'echasnovski/mini.surround',
    version = false,
    config = function()
      require('mini.surround').setup()
    end,
  },
  { 'folke/zen-mode.nvim', opts = { window = { width = 100 } }, cmd = 'ZenMode' },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  { 'junegunn/vim-easy-align', cmd = 'EasyAlign' },
  { 'mhinz/vim-grepper', event = 'VeryLazy' },
  { 'kyazdani42/nvim-web-devicons', event = 'VeryLazy' },
}
