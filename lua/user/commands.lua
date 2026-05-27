vim.api.nvim_create_user_command('Dfh', function(values)
  P(values.args)
  if values.args == nil then
    vim.cmd 'DiffviewFileHistory'
  else
    vim.cmd('DiffviewFileHistory ' .. values.args)
  end
end, { nargs = '*' })

vim.api.nvim_create_user_command('Dc', 'DiffviewClose', { nargs = 0 })
vim.api.nvim_create_user_command('Dd', 'DiffviewToggleFiles', { nargs = 0 })

vim.api.nvim_create_user_command('Do', function(values)
  if values.args == nil then
    vim.cmd 'DiffviewOpen'
  else
    vim.cmd('DiffviewOpen ' .. values.args)
  end
end, { nargs = '*' })

vim.api.nvim_create_user_command('Ao', 'AerialOpen', { nargs = 0 })
vim.api.nvim_create_user_command('Ac', 'AerialClose', { nargs = 0 })

vim.api.nvim_create_user_command('Toi', 'TypescriptOrganizeImports', { nargs = 0 })

vim.api.nvim_create_user_command('Gr', function(args)
  vim.cmd('GrepperRg ' .. args.args)
end, { nargs = '*' })

vim.api.nvim_create_user_command('Bov', function()
  local visible = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    visible[vim.api.nvim_win_get_buf(win)] = true
  end

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if not visible[buf] and vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, {})
    end
  end
end, { nargs = 0 })

vim.api.nvim_create_user_command('Bo', function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, {})
    end
  end
end, { nargs = 0 })

-- LSP info command (using native Neovim 0.11+ API)
vim.api.nvim_create_user_command('LspInfo', function()
  local clients = vim.lsp.get_clients()
  if #clients == 0 then
    print('No LSP clients attached')
    return
  end

  print('Active LSP clients:')
  for _, client in ipairs(clients) do
    local attached_buffers = client.attached_buffers or {}
    local buf_count = vim.tbl_count(attached_buffers)
    print(string.format('  • %s (id: %d, buffers: %d)', client.name, client.id, buf_count))
  end
end, { nargs = 0 })
