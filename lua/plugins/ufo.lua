return {
  {
    'kevinhwang91/nvim-ufo',
    event = 'BufEnter',
    dependencies = 'kevinhwang91/promise-async',

    config = function()
      local ufo = require('ufo')

      vim.o.foldcolumn = '0' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      local treesitter_fts = { 'norg', 'lua', 'markdown' }
      ufo.setup {
        provider_selector = function(bufnr, filetype, buftype)
          if vim.tbl_contains(treesitter_fts, filetype) then
            return 'treesitter'
          end
          return { 'lsp', 'indent' }
        end,
      }
    end,
  },
}
