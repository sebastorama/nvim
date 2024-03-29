local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

mason.setup()

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
  return
end

local servers = {
  "cssls",
  "cssmodules_ls",
  "docker_compose_language_service",
  "dockerls",
  "emmet_ls",
  "eslint",
  "html",
  "jsonls",
  "lua_ls",
  "tailwindcss",
  "tsserver"
}

--[[ mason_lspconfig.setup({
  ensure_installed = servers,
}) ]]


local lspconfig_ok, lspconfig = pcall(require, "lspconfig")

if not lspconfig_ok then
  return
end

-- Emmet support
-- lsp_installer.setup({ ensure_installed = "emmet_ls" })
lspconfig.emmet_ls.setup({
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
})

for _, server in pairs(servers) do
  local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  -- search for custom options defined on user.lsp.settings
  local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
  end
  lspconfig[server].setup(opts)
end
