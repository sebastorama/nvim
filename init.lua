 require("user.globals")

local modules = {
  "user.autocmd",
  "user.autopairs",
  "user.cmp",
  "user.color",
  "user.colorizer",
  "user.dadbodui",
  "user.diffview",
  "user.evil_lualine",
  "user.keymaps",
  "user.lsp",
  "user.luasnip",
  "user.neogit",
  "user.ntree",
  "user.nvim-dap",
  "user.nvim-dap-ui",
  "user.options",
  "user.plugins",
  "user.symbols_outline",
  "user.telescope",
  "user.transparent",
  "user.treesitter",
  "user.ts-autotag",
  "user.which-key",
  --"user.lualine",
}

for k, v in pairs(modules) do
  package.loaded[v] = nil
  require(v)
end
