require("user.globals")

-- Lazy nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("user.plugins")

 local modules = {
  "user.options",

  "user.aerial",
  "user.autocmd",
  "user.autopairs",
  "user.cmp",
  "user.colorizer",
  "user.commands",
  "user.conform",
  "user.dadbodui",
  "user.diffview",
  "user.evil_lualine",
  "user.gitsigns",
  "user.keymaps",
  "user.lsp",
  "user.luasnip",
  "user.mason-nvim-dap",
  "user.neogit",
  "user.neominimap",
  "user.ntree",
  "user.nvim-dap",
  "user.nvim-dap-ui",
  "user.quickfix",
  "user.rust-tools",
  "user.spectre",
  "user.tabby",
  "user.telescope",
  "user.todo-comments",
  "user.treesitter",
  "user.treesitter-context",
  "user.treesitter-textobjects",
  "user.ts-autotag",
  "user.which-key",
  "user.color-tokyonight-dark",
  "user.ufo"
}

for _, v in pairs(modules) do
  package.loaded[v] = nil
  require(v)
end
