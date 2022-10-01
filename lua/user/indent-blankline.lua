local ok, indent_blankline = pcall(require, "indent_blankline")

if not ok then
  return
end

vim.opt.termguicolors = true

vim.cmd([[highlight IndentBlanklineIndent1 guibg=#191B2D guifg=#191B2D gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guibg=#131422 guifg=#131422 gui=nocombine]])

vim.opt.list = true
vim.opt.listchars:append("eol:↴")

indent_blankline.setup({
  show_end_of_line = true,
  show_current_context = false,
  show_current_context_start = false,
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
  space_char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
})
