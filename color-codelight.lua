local vscode_ok, vscode = pcall(require, "vscode")

if not vscode_ok then
  return
end

vim.o.background = "light"

vscode.setup({
  -- Enable italic comment
  italic_comments = true,
})
