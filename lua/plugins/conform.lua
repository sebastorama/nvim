return {
  {
    'stevearc/conform.nvim',
    ft = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'python', 'lua' },
    opts = {},
    config = function()
      local conform = require('conform')

      conform.setup {
        formatters_by_ft = {
          lua = { 'stylua' },
          -- Conform will run multiple formatters sequentially
          python = { 'isort', 'black' },
          -- Use a sub-list to run only the first available formatter
          javascript = { 'prettier' },
          typescript = { 'prettier' },
          typescriptreact = { 'prettier' },
          javascriptreact = { 'prettier' },
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          lsp_fallback = false,
        },
      }

      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*',
        callback = function(args)
          require('conform').format({ bufnr = args.buf })
        end,
      })
    end,
  },
}
