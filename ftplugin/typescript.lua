vim.cmd [[set foldmethod=expr]]
-- setup localleader + f to run EslintFixAll
vim.api.nvim_set_keymap('n', '<localleader>f', ':EslintFixAll<CR>', { noremap = true, silent = true })

-- Auto-run EslintFixAll on save
vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = 0,
  callback = function()
    vim.cmd("EslintFixAll")
  end,
})
