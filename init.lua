require("user.globals")

local modules = {
  "user.aerial",
  "user.autocmd",
  "user.autopairs",
  "user.cmp",
  "user.colorizer",
  "user.commands",
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
  "user.plugins",
  "user.spectre",
  "user.tabby",
  "user.telescope",
  "user.transparent",
  "user.treesitter",
  "user.ts-autotag",
  "user.ufo",
  "user.which-key",
  "user.neominimap",
  "user.gruvbuddy",
  "user.options",
}

for _, v in pairs(modules) do
  package.loaded[v] = nil
  require(v)
end
