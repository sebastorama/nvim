vim.cmd([[packadd packer.nvim]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

return packer.startup(function(use)
  use("wbthomason/packer.nvim")
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })
  use({
    "nvim-telescope/telescope.nvim",
    requires = "nvim-lua/plenary.nvim",
  })
  use({
    "TimUntersberger/neogit",
    requires = "nvim-lua/plenary.nvim",
  })
  use({
    "sindrets/diffview.nvim",
    requires = "nvim-lua/plenary.nvim",
  })

  use("tpope/vim-surround")
  use({
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icon
    },
  })

  -- use "github/copilot.vim"

  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("windwp/nvim-autopairs")
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })

  use("vimwiki/vimwiki")
  use("windwp/nvim-ts-autotag")
  use("folke/which-key.nvim")

  -- dadbod
  use("tpope/vim-dadbod")
  use("kristijanhusak/vim-dadbod-ui")
  use("kristijanhusak/vim-dadbod-completion")

  -- Colorschemes
  use("navarasu/onedark.nvim")
  use("tomasiser/vim-code-dark")
  use("NLKNguyen/papercolor-theme")
  use("folke/tokyonight.nvim")
  use("xiyaowong/nvim-transparent")
  use("tanvirtin/monokai.nvim")
  use("romgrk/github-light.vim")
  use("ellisonleao/gruvbox.nvim")
  use("projekt0n/github-nvim-theme")
  use("doums/darcula")
  use({ "lalitmee/cobalt2.nvim", requires = "tjdevries/colorbuddy.nvim" })
  use("tjdevries/gruvbuddy.nvim")
  use("Yazeed1s/minimal.nvim")
  use("ishan9299/modus-theme-vim")

  -- Completion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("saadparwaiz1/cmp_luasnip")
  use("hrsh7th/cmp-calc")
  use("f3fora/cmp-spell")
  use("ray-x/lsp_signature.nvim")

  -- LSP
  use("neovim/nvim-lspconfig") -- enable LSP
  use("williamboman/nvim-lsp-installer") -- simple to use language server installer
  use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
  use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
  use("nvim-lua/plenary.nvim")
  use("simrat39/symbols-outline.nvim")

  -- DAP
  use("mfussenegger/nvim-dap")
  use("nvim-telescope/telescope-dap.nvim")
  use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

  -- snippets
  use("L3MON4D3/LuaSnip")
  use("rafamadriz/friendly-snippets")
end)
