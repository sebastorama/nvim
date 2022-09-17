local typescript_status_ok, typescript = pcall(require, "typescript")
if not typescript_status_ok then
  return
end

typescript.setup({
  server = { -- pass options to lspconfig's setup method
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  },
})
