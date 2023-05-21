local rt_ok, rt = pcall(require, "rust-tools")

if not rt_ok then
  return
end

rt.setup({
  server = {
    on_attach = function(client, bufnr)
      local on_attach = require("user.lsp.handlers").on_attach
      vim.cmd([[hi RustInlayHints guifg=#535C7E]])
      on_attach(client, bufnr)
    end,
  },
  tools = {
    inlay_hints = {
      highlight = "RustInlayHints",
      other_hints_prefix = " ⇝",
      parameter_hints_prefix = " ‹",
    },
  },
})
