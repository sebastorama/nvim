P = function(inspectable)
  print(vim.inspect(inspectable))
end

PB = function(inspectable)
  local buffer = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_lines(buffer, 0, 0, true, vim.split(string.rep(vim.inspect(inspectable), 1), "\n"))
  vim.cmd([[vsplit]])
  vim.api.nvim_win_set_buf(0, buffer)
end

function MAP(tbl, f)
  local t = {}
  for k, v in pairs(tbl) do
    t[k] = f(v)
  end
  return t
end

function HAS_VALUE(tab, val)
  for _index, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end
