-- Clipboard providers for environments where Neovim can't auto-detect one.
if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
elseif vim.env.SSH_TTY or vim.env.SSH_CONNECTION then
  -- Over SSH there is no X11/Wayland clipboard tool, so send yanks through
  -- OSC 52 and let the local terminal (kitty, ghostty, herdr) own the clipboard.
  -- Table form instead of `vim.g.clipboard = 'osc52'` so it also works on
  -- Neovim 0.10. Paste returns what we last copied: terminal multiplexers
  -- such as herdr never answer OSC 52 read requests, and waiting on one hangs.
  local osc52 = require('vim.ui.clipboard.osc52')
  local last = { ['+'] = {}, ['*'] = {} }

  local function copy(reg)
    local send = osc52.copy(reg)
    return function(lines, regtype)
      last[reg] = lines
      send(lines, regtype)
    end
  end

  local function paste(reg)
    return function()
      return { last[reg], 'v' }
    end
  end

  vim.g.clipboard = {
    name = 'OSC 52 (ssh)',
    copy = { ['+'] = copy('+'), ['*'] = copy('*') },
    paste = { ['+'] = paste('+'), ['*'] = paste('*') },
  }
end
