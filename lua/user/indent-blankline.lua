local ok, indent_blankline = pcall(require, "indent_blankline")

if not ok then
  return
end

vim.opt.termguicolors = true
vim.cmd([[highlight IndentBlanklineIndent1 guibg=#282D42 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guibg=#2E344C gui=nocombine]])

require("indent_blankline").setup({
  char = "",
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
  space_char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
  show_trailing_blankline_indent = false,
})
