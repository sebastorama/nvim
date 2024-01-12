
require("lazy").setup({
  -- DX
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  "nvim-telescope/telescope-ui-select.nvim",
  "tpope/vim-surround",
  "windwp/nvim-autopairs",
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  "junegunn/vim-easy-align",
  "folke/which-key.nvim",
  "mhinz/vim-grepper",
  "kazhala/close-buffers.nvim",
  {
    'mikesmithgh/kitty-scrollback.nvim',
    enabled = true,
    lazy = true,
    cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
    event = { 'User KittyScrollbackLaunch' },
    -- version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^2.0.0', -- pin major version, include fixes and features that do not have breaking changes
    config = function()
      require('kitty-scrollback').setup()
    end,
  },

  -- GIT
  { "TimUntersberger/neogit", dependencies = "nvim-lua/plenary.nvim" },
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },

  -- UI
  "nvim-pack/nvim-spectre",
  "folke/which-key.nvim",
  "kyazdani42/nvim-tree.lua",
  "kyazdani42/nvim-web-devicons",
  "norcalli/nvim-colorizer.lua",
  { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
  "nvim-lualine/lualine.nvim",
  "ziontee113/neo-minimap",
  "folke/todo-comments.nvim",
  "lewis6991/gitsigns.nvim",
  "nanozuki/tabby.nvim",
  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  -- dadbod
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-ui",
  "kristijanhusak/vim-dadbod-completion",
  "vim-scripts/dbext.vim",

  -- Colorschemes
  "NLKNguyen/papercolor-theme",
  "folke/tokyonight.nvim",
  "ellisonleao/gruvbox.nvim",
  "tjdevries/colorbuddy.nvim",
  "tjdevries/gruvbuddy.nvim",
  "navarasu/onedark.nvim",
  "Mofiqul/vscode.nvim",
  "ayu-theme/ayu-vim",
  "Th3Whit3Wolf/one-nvim",
  { "catppuccin/nvim", as = "catppuccin" },
  "shaunsingh/solarized.nvim",

  -- Completion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-calc",
  "f3fora/cmp-spell",
  "ray-x/lsp_signature.nvim",

  -- LSP & TreeSitter
  { "williamboman/mason.nvim", lazy = false },
  { "williamboman/mason-lspconfig.nvim", lazy = false },
  "neovim/nvim-lspconfig", -- enable LSP
  "mfussenegger/nvim-lint",
  "tamago324/nlsp-settings.nvim", -- language server settings defined in json for
  "nvim-lua/plenary.nvim",
  "jose-elias-alvarez/typescript.nvim",
  "stevearc/aerial.nvim",
  "windwp/nvim-ts-autotag",
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/playground",
  "nvim-treesitter/nvim-treesitter-context",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "github/copilot.vim",
  "simrat39/rust-tools.nvim",

  -- NEORG
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = require("user.neorg").setup
  },

  -- DAP
  "mfussenegger/nvim-dap",
  -- "nvim-telescope/telescope-dap.nvim",
  -- { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },

  -- snippets
  "L3MON4D3/LuaSnip",
})
