local M = {}

local states = {
  unchanged = { icon = '', label = 'Unchanged', highlight = 'Comment' },
  staged = { icon = '󰄬', label = 'Staged', highlight = 'DiagnosticOk' },
  partial = { icon = '󰘻', label = 'Partial', highlight = 'DiagnosticWarn' },
  unstaged = { icon = '󰄱', label = 'Unstaged', highlight = 'DiagnosticError' },
}

function M.git_status()
  local cache = package.loaded['gitsigns.cache']
  if not cache then
    return ''
  end

  local winid = tonumber(vim.g.statusline_winid) or vim.api.nvim_get_current_win()
  if not vim.api.nvim_win_is_valid(winid) then
    return ''
  end

  local entry = cache.cache[vim.api.nvim_win_get_buf(winid)]
  if not entry then
    return ''
  end

  local has_staged = entry.hunks_staged and #entry.hunks_staged > 0
  local has_unstaged = entry.hunks and #entry.hunks > 0
  local state

  if has_staged and has_unstaged then
    state = states.partial
  elseif has_staged then
    state = states.staged
  elseif has_unstaged then
    state = states.unstaged
  else
    state = states.unchanged
  end

  return ('%%#%s#%s %s%%*'):format(state.highlight, state.icon, state.label)
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'GitSignsUpdate',
  callback = function()
    -- `!` covers every window: a buffer whose hunks changed may be shown in a
    -- split that is not current, and plain `redrawstatus` would leave it stale.
    vim.cmd 'redrawstatus!'
  end,
})

return M
