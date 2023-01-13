require("colorbuddy").colorscheme("gruvbuddy")

local ok, indent_blankline = pcall(require, "indent_blankline")

if not ok then
  return
end

vim.opt.termguicolors = true

vim.cmd([[highlight indentblanklineindent1 guibg=#282c34 guifg=#333333 gui=nocombine]])
vim.cmd([[highlight ColorColumn guibg=#2D313A guifg=#2D313A gui=nocombine]])

vim.opt.list = true
vim.opt.listchars:append("eol:↴")

indent_blankline.setup({
  show_end_of_line = true,
  show_current_context = false,
  show_current_context_start = false,
  char_highlight_list = {
    "IndentBlanklineIndent1",
  },
  space_char_highlight_list = {
    "IndentBlanklineIndent1",
  },
})
