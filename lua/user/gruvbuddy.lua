require("colorbuddy").colorscheme("gruvbuddy")

local ok, indent_blankline = pcall(require, "indent_blankline")

if not ok then
  return
end

vim.opt.termguicolors = true

vim.cmd([[highlight IndentBlanklineIndent1 guibg=#282C34 guifg=#333333 gui=nocombine]])

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
