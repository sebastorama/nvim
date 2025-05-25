local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')

mason.setup()

-- Track which servers have been set up to prevent duplicates
local setup_servers = {}

-- Function to safely setup server only once
local function safe_server_setup(server_name, config)
  if setup_servers[server_name] then
    vim.notify(string.format('LSP server %s already set up, skipping duplicate', server_name), vim.log.levels.WARN)
    return
  end
  setup_servers[server_name] = true
  vim.notify(string.format('Setting up LSP server: %s', server_name), vim.log.levels.INFO)
  lspconfig[server_name].setup(config)
end

-- Function to detach duplicate clients
local function detach_duplicates()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local seen_clients = {}
  local detached = {}

  for _, client in ipairs(clients) do
    if seen_clients[client.name] then
      vim.lsp.buf_detach_client(bufnr, client.id)
      table.insert(detached, string.format('%s (id: %d)', client.name, client.id))
    else
      seen_clients[client.name] = true
    end
  end

  if #detached > 0 then
    vim.notify('Detached duplicate LSP clients: ' .. table.concat(detached, ', '), vim.log.levels.INFO)
  end
end

-- Set up autocommand to automatically clean up duplicates
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LspDuplicateCleanup', { clear = true }),
  callback = function()
    vim.defer_fn(detach_duplicates, 1000) -- Wait 1 second after LSP attach
  end,
})

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

mason_lspconfig.setup({
  ensure_installed = vim.tbl_filter(function(server)
    return server ~= 'nil_ls' -- nil_ls installed by nix
  end, servers),
  automatic_installation = false, -- Disable automatic setup
  automatic_setup = false, -- Disable automatic setup
})

-- Emmet support
-- lsp_installer.setup({ ensure_installed = "emmet_ls" })
safe_server_setup('emmet_ls', {
  on_attach = require('user.lsp.handlers').on_attach,
  capabilities = require('user.lsp.handlers').capabilities,
  filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
})

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
  safe_server_setup(server, opts)
end
