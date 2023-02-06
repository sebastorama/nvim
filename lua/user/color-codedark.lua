local vscode_ok, vscode = pcall(require, "vscode")

if not vscode_ok then
  return
end

vim.o.background = "dark"

vscode.setup({
  -- Enable italic comment
  italic_comments = true,
})
