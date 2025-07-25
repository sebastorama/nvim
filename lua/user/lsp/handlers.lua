local M = {}
local navbuddy = require('nvim-navbuddy')

M.setup = function()
  local config = {
    -- enable/disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '',
        [vim.diagnostic.severity.WARN] = '',
        [vim.diagnostic.severity.INFO] = '',
        [vim.diagnostic.severity.HINT] = '',
      },
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  }

  vim.diagnostic.config(config)
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  vim.o.updatetime = 250
  -- vim.cmd([[
  --   augroup lsp_open_float
  --   autocmd! * <buffer>
  --   autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})
  --   augroup END
  -- ]])

  if client.server_capabilities.documentHighlightProvider then
    vim.cmd([[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]])
  end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', function()
    vim.lsp.buf.hover({ border = 'rounded' })
  end, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-K>', function()
    vim.lsp.buf.signature_help({ border = 'rounded' })
  end, opts)
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  vim.keymap.set('n', '<leader>.', vim.lsp.buf.code_action, opts)

  vim.keymap.set('n', '<c-p>', function()
    vim.diagnostic.jump({ count = -1, float = { border = 'rounded' } })
  end, opts)

  vim.keymap.set('n', 'gl', function()
    vim.diagnostic.open_float(nil, { focus = false, border = 'rounded' })
  end, opts)

  vim.keymap.set('n', '<c-n>', function()
    vim.diagnostic.jump({ count = 1, float = { border = 'rounded' } })
  end, opts)

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
  vim.cmd [[ command! Format execute "lua vim.lsp.buf.format({ async = true })" ]]
end

local attach_navbuddy = function(client, bufnr)
  local navbuddyClients = { 'ts_ls' }

  for _, v in ipairs(navbuddyClients) do
    if client.name == v then
      navbuddy.attach(client, bufnr)
    end
  end
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)

  attach_navbuddy(client, bufnr)
end

M.format_if_not_present = function(client)
  local active_clients = MAP(vim.lsp.get_clients(), function(v)
    return v.name
  end)

  if HAS_VALUE(active_clients, client) then
    return
  end

  vim.lsp.buf.format()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

M.capabilities = capabilities

return M
