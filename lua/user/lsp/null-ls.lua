local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier.with({
      extra_args = { "--single-quote" },
      filetypes = { "css", "scss", "json", "yaml", "markdown" },
    }),
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),
    -- diagnostics.cspell
    -- diagnostics.flake8
  },

  on_attach = function(client, buffno)
    local ft = vim.filetype.match({ buf = buffno })

    if client.server_capabilities.documentFormattingProvider then
      local augroup = vim.api.nvim_create_augroup("NullLsFormatting", {})
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = 0,
        group = augroup,
        callback = function()
          vim.lsp.buf.format({
            filter = function()
              return client.name == "null-ls"
            end,
          })
        end,
      })
    end
  end,
})
