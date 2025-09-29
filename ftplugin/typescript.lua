vim.cmd [[set foldmethod=expr]]

-- ESLint fix: trigger LSP code action 'source.fixAll.eslint'
local function fix_all_eslint()
  -- Ensure eslint LSP client is attached before requesting actions
  local has_eslint = false
  for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
    if client.name == 'eslint' then
      has_eslint = true
      break
    end
  end
  if not has_eslint then
    return
  end

  -- Prefer the eslint-specific fixAll; fallback to generic fixAll
  vim.lsp.buf.code_action({
    context = { only = { 'source.fixAll.eslint' } },
    apply = true,
  })
end

-- Map <localleader>f to run the ESLint fix action (buffer-local)
vim.keymap.set(
  'n',
  '<localleader>f',
  fix_all_eslint,
  { desc = 'Fix all ESLint problems', buffer = true, silent = true }
)

-- Auto-run the same action on save
vim.api.nvim_create_autocmd('BufWritePre', {
  buffer = 0,
  callback = function()
    fix_all_eslint()
  end,
})
