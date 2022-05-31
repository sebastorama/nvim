local snip_status_ok, luasnip = pcall(require, 'luasnip')
if not snip_status_ok then
  return
end

-- load my custom snippets folder
require("luasnip.loaders.from_vscode").lazy_load({ paths = { './snippets' } })
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.filetype_extend("typescript", { "javascript" })
