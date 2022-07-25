P = function(inspectable)
  print(vim.inspect(inspectable))
end

PB = function(inspectable)
  local buffer = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_lines(buffer, 0, 0, true, vim.split(string.rep(vim.inspect(inspectable), 1), "\n"))
  vim.cmd([[vsplit]])
  vim.api.nvim_win_set_buf(0, buffer)
end
