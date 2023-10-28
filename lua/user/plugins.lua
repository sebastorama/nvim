require("lazy").setup({
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
  "neovim/nvim-lspconfig", -- enable LSP
  "williamboman/nvim-lsp-installer", -- simple to use language server installer
  "tamago324/nlsp-settings.nvim", -- language server settings defined in json for
  "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
  "nvim-lua/plenary.nvim",
  "jose-elias-alvarez/typescript.nvim",
  "stevearc/aerial.nvim",
  "windwp/nvim-ts-autotag",
  { "nvim-treesitter/nvim-treesitter" },
  { "nvim-treesitter/playground" },
  "nvim-treesitter/nvim-treesitter-context",
  "github/copilot.vim",
  "simrat39/rust-tools.nvim",

  -- DAP
  "mfussenegger/nvim-dap",
  -- "nvim-telescope/telescope-dap.nvim",
  -- { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },

  -- snippets
  "L3MON4D3/LuaSnip",
})
