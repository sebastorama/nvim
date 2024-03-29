local ok, ufo = pcall(require, "ufo")

if not ok then
  return
end

vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

ufo.setup({
  provider_selector = function(bufnr, filetype, buftype)
    if(filetype == "norg" or filetype == "lua") then
      return "treesitter"
    end
    return { "lsp", "indent" }
  end,
})
