local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("user.lsp.configs")
require("user.lsp.nvim_lint")
require("user.lsp.handlers").setup()
require("user.lsp.lsp_signature")
require("user.lsp.typescript")
