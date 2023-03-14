local rt_ok, rt = pcall(require, "rust-tools")

if not rt_ok then
  return
end

rt.setup({
  server = {
    on_attach = require("user.lsp.handlers").on_attach,
  },
})
