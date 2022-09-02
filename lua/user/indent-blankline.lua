local ok, indent_blankline = pcall(require, "indent_blankline")

if not ok then
  return
end

vim.opt.termguicolors = true
vim.cmd([[highlight IndentBlanklineIndent1 guifg=#333333 gui=nocombine]])

indent_blankline.setup({
  -- for example, context is off by default, use this to turn it on
  show_current_context = false,
  show_current_context_start = false,
  char_highlight_list = {
    "IndentBlanklineIndent1",
  },
})
