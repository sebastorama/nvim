local vscode_ok, vscode = pcall(require, "vscode")

vim.cmd([[set bg=light]])

if not vscode_ok then
  return
end

vscode.setup({
  -- Enable italic comment
  italic_comments = true,
})
