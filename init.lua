require("user.globals")

local modules = {
  "user.aerial",
  "user.autocmd",
  "user.autopairs",
  "user.cmp",
  "user.color",
  "user.colorizer",
  "user.dadbodui",
  "user.diffview",
  "user.evil_lualine",
  -- "user.indent-blankline",
  "user.keymaps",
  "user.lsp",
  "user.luasnip",
  "user.neogit",
  "user.ntree",
  "user.nvim-dap",
  "user.nvim-dap-ui",
  "user.options",
  "user.plugins",
  "user.spectre",
  "user.tabby",
  "user.telescope",
  "user.transparent",
  "user.treesitter",
  "user.ts-autotag",
  "user.ufo",
  "user.which-key",
  --"user.lualine",
}

for _, v in pairs(modules) do
  package.loaded[v] = nil
  require(v)
end
