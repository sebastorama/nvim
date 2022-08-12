local ok, indent_blankline = pcall(require, "indent_blankline")

if not ok then
  return
end

vim.opt.termguicolors = true
vim.cmd([[highlight IndentBlanklineIndent1 guibg=#252525 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guibg=#303030 gui=nocombine]])

indent_blankline.setup({
  -- for example, context is off by default, use this to turn it on
  show_current_context = true,
  show_current_context_start = false,
})
