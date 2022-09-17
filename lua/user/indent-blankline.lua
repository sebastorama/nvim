local ok, indent_blankline = pcall(require, "indent_blankline")

if not ok then
  return
end

vim.opt.termguicolors = true
-- vim.cmd([[highlight IndentBlanklineIndent1 guifg=#333333 gui=nocombine]])

vim.opt.list = true
vim.opt.listchars:append("eol:↴")

indent_blankline.setup({
  show_end_of_line = true,
  show_current_context = true,
  show_current_context_start = false,
})
