local mason = require('mason')
-- local mason_lspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')

mason.setup()

local servers = {
  'cssls',
  'cssmodules_ls',
  'docker_compose_language_service',
  'dockerls',
  'emmet_ls',
  'eslint',
  'html',
  'jsonls',
  'lua_ls',
  'nil_ls',
  'tailwindcss',
  'ts_ls',
}

-- mason_lspconfig.setup({
--   ensure_installed = vim.tbl_filter(function(server)
--     return server ~= 'nil_ls' -- nil_ls installed by nix
--   end, servers),
-- })

-- Emmet support
-- lsp_installer.setup({ ensure_installed = "emmet_ls" })
lspconfig.emmet_ls.setup {
  on_attach = require('user.lsp.handlers').on_attach,
  capabilities = require('user.lsp.handlers').capabilities,
  filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
}

for _, server in pairs(servers) do
  local opts = {
    on_attach = require('user.lsp.handlers').on_attach,
    capabilities = require('user.lsp.handlers').capabilities,
  }

  -- search for custom options defined on user.lsp.settings
  local has_custom_opts, server_custom_opts = pcall(require, 'user.lsp.settings.' .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend('force', server_custom_opts, opts)
  end
  lspconfig[server].setup(opts)
end
