local ok, wk = pcall(require, 'which-key')

if not ok then
  return
end

wk.register ({
  f = {
    name='Find',
    f = { '<cmd>Telescope find_files<cr>', 'Find File' }, -- create a binding with label
    b = { '<cmd>Telescope buffers<cr>', 'Find Buffers' },
    g = { '<cmd>Telescope find_files<cr>', 'Find GIT files' }, -- create a binding with label
  },
  l = {
    name='LSP',
    l = { '<cmd>Telescope diagnostics<cr>', 'Show Diagnostics' },
    a = {
      name = 'Actions',
      r = { '<cmd>lua vim.lsp.buf.rename()<cr>', silent = false, noremap = false, 'Rename with LSP' }
    },
    d = { '<cmd>Telescope lsp_definitions<cr>', 'Find Definitions' }, -- create a binding with label
    r = { '<cmd>Telescope lsp_references<cr>', 'Find References' }, -- create a binding with label
  },
  g = {
    name = 'GIT',
    g = { '<cmd>Neogit<cr>', 'Open Neogit' }
  }
}, { prefix = '<leader>' })
