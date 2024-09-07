return {
  -- LSP & TreeSitter
  { 'neovim/nvim-lspconfig', event = 'VeryLazy' }, -- enable LSP
  { 'mfussenegger/nvim-lint', event = 'VeryLazy' },
  { 'tamago324/nlsp-settings.nvim', event = 'VeryLazy' }, -- language server settings defined in json for
  'nvim-lua/plenary.nvim',

  -- DX
  -- { 'github/copilot.vim',         event = 'InsertEnter' },
  {
    'supermaven-inc/supermaven-nvim',
    event = 'InsertEnter',
    config = function()
      require('supermaven-nvim').setup({
        keymaps = {
          accept_suggestion = '<M-i>',
          accept_word = '<M-o>',
          clear_suggestion = '<C-]>',
        },
      })
    end,
  },
  { 'kazhala/close-buffers.nvim', event = 'BufRead' },
  { 'tpope/vim-surround', event = 'InsertEnter' },
  { 'folke/zen-mode.nvim', opts = { window = { width = 100 } }, cmd = 'ZenMode' },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  { 'junegunn/vim-easy-align', cmd = 'EasyAlign' },
  { 'mhinz/vim-grepper', cmd = 'Grepper' },
  { 'kyazdani42/nvim-web-devicons', event = 'VeryLazy' },
  {
    'norcalli/nvim-colorizer.lua',
    event = 'VeryLazy',
    config = function()
      require('colorizer').setup()
    end,
  },
}
