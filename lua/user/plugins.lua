vim.cmd [[packadd packer.nvim]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

return packer.startup(function(use)
  use "wbthomason/packer.nvim"
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true }
  }
  use {
    "nvim-telescope/telescope.nvim",
    requires = "nvim-lua/plenary.nvim"
  }
  use {
    "TimUntersberger/neogit",
    requires = "nvim-lua/plenary.nvim"
  }
  use {
    "sindrets/diffview.nvim",
    requires = "nvim-lua/plenary.nvim"
  }

  use "tpope/vim-surround"
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icon
    }
  }

  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "windwp/nvim-autopairs"

  use "vimwiki/vimwiki"
  use "windwp/nvim-ts-autotag"
  use "folke/which-key.nvim"
  use { "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" }


  -- Colorschemes
  use "navarasu/onedark.nvim"
  use "tomasiser/vim-code-dark"
  use "NLKNguyen/papercolor-theme"
  use "folke/tokyonight.nvim"
  use "xiyaowong/nvim-transparent"
  use "tanvirtin/monokai.nvim"
  use "romgrk/github-light.vim"
  use "ellisonleao/gruvbox.nvim"


  -- Completion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/cmp-calc"
  use "f3fora/cmp-spell"
  use "ray-x/lsp_signature.nvim"

  -- LSP
  use "neovim/nvim-lspconfig"           -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "nvim-lua/plenary.nvim"

  -- snippets
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"
end)


