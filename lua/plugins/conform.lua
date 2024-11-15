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
          javascript = { 'prettierd' },
          typescript = { 'prettierd' },
          typescriptreact = { 'prettierd' },
          javascriptreact = { 'prettierd' },
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 50,
          lsp_fallback = true,
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
