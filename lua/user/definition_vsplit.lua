-- Open the LSP definition under the cursor in a vertical split.
-- If a second file split already exists, the rightmost one is reused.
local M = {}

local function is_file_window(win)
  local is_floating = vim.api.nvim_win_get_config(win).relative ~= ''
  if is_floating then
    return false
  end

  local buf = vim.api.nvim_win_get_buf(win)
  local is_regular_buffer = vim.bo[buf].buftype == ''
  return is_regular_buffer
end

local function row_span(win)
  local top = vim.fn.win_screenpos(win)[1]
  local bottom = top + vim.api.nvim_win_get_height(win) - 1
  return top, bottom
end

-- True when the two windows overlap vertically, so they sit side by side
-- rather than one above the other.
local function shares_rows(win, other)
  local top, bottom = row_span(win)
  local other_top, other_bottom = row_span(other)
  local starts_below = other_top > bottom
  local ends_above = other_bottom < top
  return not starts_below and not ends_above
end

-- Returns the rightmost file window in the same row as the source window,
-- but only when there are two or more of them. Sidebars (neo-tree, outline,
-- oil...) and windows above or below the source (e.g. beside the quickfix)
-- are ignored.
local function rightmost_file_window(source_win)
  local file_windows = {}
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local is_candidate = is_file_window(win) and shares_rows(source_win, win)
    if is_candidate then
      table.insert(file_windows, win)
    end
  end

  local has_second_split = #file_windows >= 2
  if not has_second_split then
    return nil
  end

  local rightmost = nil
  local rightmost_col = -1
  for _, win in ipairs(file_windows) do
    local col = vim.fn.win_screenpos(win)[2]
    if col > rightmost_col then
      rightmost = win
      rightmost_col = col
    end
  end
  return rightmost
end

function M.open()
  local source_win = vim.api.nvim_get_current_win()
  local source_buf = vim.api.nvim_get_current_buf()
  local target_win = rightmost_file_window(source_win)

  if target_win == nil then
    require('telescope.builtin').lsp_definitions {
      jump_type = 'vsplit',
      attach_mappings = function()
        local actions = require 'telescope.actions'
        actions.select_default:replace(actions.select_vertical)
        return true
      end,
    }
    return
  end

  -- Reuse the rightmost split: the LSP request still comes from the source
  -- window, but the result opens in the target window.
  vim.api.nvim_set_current_win(target_win)
  require('telescope.builtin').lsp_definitions {
    winnr = source_win,
    bufnr = source_buf,
    -- any value other than tab/split/vsplit opens in the current window
    jump_type = 'current',
  }
end

return M
