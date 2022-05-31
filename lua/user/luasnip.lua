local ok, luasnip = pcall(require, "luasnip")
if not ok then
  return
end

-- load my custom snippets folder
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.filetype_extend("typescript", { "javascript" })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent = true })
