-- Context menus, built on Neovim's native `PopUp` menu ('mousemodel=popup_setpos').
--
-- Everything menu-related lives here: the buffer menu, the per-filetype entries
-- that ftplugins attach, and the Neo-tree menu. Plugin and ftplugin files only
-- call into this module.
--
-- Neovim opens `PopUp` on its own; all we do is hook `MenuPopup` to rebuild the
-- context-dependent entries. Never call `:popup PopUp` by hand: `:popup` does not
-- trigger `MenuPopup`, so it would show a stale menu.
--
-- Priorities follow a convention: each block owns a decade (.10-.19, .20-.29, …)
-- and closes with a `<Nop>` separator at its last slot, so blocks stay grouped
-- and visually divided no matter which ones are present.

local M = {}

-- Range captured while the popup was requested from Visual mode, so Stage/Unstage
-- act on the selection (menu items run after Neovim has already left Visual mode).
local selection

-- Menu items we disabled for the current mode, to be re-enabled on the next popup.
local disabled = {}

local function escape(name)
  return (name:gsub('([ .\\|])', '\\%1'))
end

local function path(name)
  return 'PopUp.' .. escape(name)
end

local function unmenu(...)
  for _, item in ipairs { ... } do
    vim.cmd('silent! aunmenu ' .. item)
  end
end

--- The `<Nop>` separator that closes the decade `priority` falls in (20 -> 29).
local function separator_priority(priority)
  return math.floor(priority / 10) * 10 + 9
end

--------------------------------------------------------------------------------
-- Buffer menu
--------------------------------------------------------------------------------

--- Entries that always exist.
---
--- The hunks-to-quickfix choices live in their own top-level `]GitHunksQf` menu
--- rather than as a `PopUp` submenu: Neovim's popup menu cannot descend into a
--- nested submenu, it just tries to execute the parent node, which has no mapping
--- in any mode and so fails with E335. `PopUp` therefore gets a single leaf entry
--- that opens `]GitHunksQf` as a second popup.
---
--- `anoremenu` defines the shared `PopUp` entries for every mode, while Copy
--- Location Reference is Visual-only because it operates on the selected lines.
---
--- Stock Neovim ships conditional `PopUp` entries (Go to definition, diagnostics,
--- Open in web browser) managed by its `nvim.popupmenu` MenuPopup handler. Our
--- LSP block supersedes "Go to definition", and removing an entry makes the stock
--- handler error (its `amenu disable` is not `silent!`), so we clear that augroup
--- and manage the surviving stock entries in `update_stock_items` instead.
local function define_static()
  vim.api.nvim_create_augroup('nvim.popupmenu', { clear = true })
  vim.cmd [[
    silent! aunmenu PopUp.Go\ to\ definition
    xnoremenu <silent> .01 PopUp.󰆏\ Copy\ Location\ Reference <Cmd>lua require('user.context_menu').copy_location_reference()<CR>
    xnoremenu <silent> .09 PopUp.-CopyLocationEnd- <Nop>
    anoremenu <silent> .30 PopUp.󰁨\ Git\ Hunks\ to\ Quickfix… <Cmd>lua require('user.context_menu').open_hunks_qf(false)<CR>
    anoremenu <silent> .39 PopUp.-GitQuickfixEnd- <Nop>
    anoremenu <silent> .40 PopUp.󰚀\ Toggle\ Zen\ Mode <Cmd>ZenMode<CR>
    anoremenu <silent> .49 PopUp.-ZenModeEnd- <Nop>

    silent! aunmenu ]GitHunksQf
    anoremenu <silent> .10 ]GitHunksQf.󰄛\ All      <Cmd>GitHunksQf all<CR>
    anoremenu <silent> .20 ]GitHunksQf.󰄬\ Staged   <Cmd>GitHunksQf staged<CR>
    anoremenu <silent> .30 ]GitHunksQf.󰄱\ Unstaged <Cmd>GitHunksQf unstaged<CR>
  ]]
end

--- Gitsigns hunk under `line` of `bufnr`, or nil. Returns whether it is staged.
local function hunk_at(bufnr, line)
  local ok, cache = pcall(require, 'gitsigns.cache')
  local entry = ok and cache.cache[bufnr]
  if not entry then
    return nil
  end

  local hunks = require 'gitsigns.hunks'
  local count = vim.api.nvim_buf_line_count(bufnr)
  local unstaged = hunks.find_hunk(line, entry.hunks or {}, count)
  local staged = hunks.find_hunk(line, entry.hunks_staged or {}, count)
  if not unstaged and not staged then
    return nil
  end

  return unstaged == nil
end

local function clear_hunk_items()
  selection = nil
  unmenu(
    [[PopUp.󰄬\ Stage\ Hunk]],
    [[PopUp.󰅖\ Unstage\ Hunk]],
    [[PopUp.󰍉\ Visualize\ Hunk]],
    'PopUp.-GitHunkEnd-'
  )
end

local function add_hunk_items(staged)
  local action = staged and [[PopUp.󰅖\ Unstage\ Hunk]] or [[PopUp.󰄬\ Stage\ Hunk]]
  vim.cmd(([[
    anoremenu <silent> .10 %s <Cmd>lua require('user.context_menu').stage()<CR>
    anoremenu <silent> .11 PopUp.󰍉\ Visualize\ Hunk <Cmd>Gitsigns preview_hunk_inline<CR>
    anoremenu <silent> .19 PopUp.-GitHunkEnd- <Nop>
  ]]):format(action))
end

--- Stage (or unstage) the hunk the popup was opened on, honouring a Visual selection.
function M.stage()
  require('gitsigns').stage_hunk(selection)
end

--- Copy a reference to the selected lines, matching the `<localleader>c` mapping.
function M.copy_location_reference()
  if not selection then
    return
  end

  local first = math.min(selection[1], selection[2])
  local last = math.max(selection[1], selection[2])
  vim.fn.setreg('*', ('@%s#L%d-%d'):format(vim.fn.expand '%:~:.', first, last))
end

-- LSP entries, present only when an attached client supports the method.
local lsp_items = {
  {
    method = 'textDocument/definition',
    priority = 20,
    name = [[󰁔\ Go\ to\ Definition]],
    cmd = 'lua vim.lsp.buf.definition()',
  },
  {
    method = 'textDocument/definition',
    priority = 21,
    name = [[󰁔\ Go\ to\ Definition\ (vsplit)]],
    cmd = [[lua require('user.context_menu').definition_vsplit()]],
  },
  {
    method = 'textDocument/references',
    priority = 22,
    name = [[󰈞\ Find\ References]],
    cmd = [[lua require('user.context_menu').references()]],
  },
}

local function clear_lsp_items()
  for _, item in ipairs(lsp_items) do
    unmenu('PopUp.' .. item.name)
  end
  unmenu 'PopUp.-LspEnd-'
end

local function add_lsp_items(bufnr)
  local added = false
  for _, item in ipairs(lsp_items) do
    if next(vim.lsp.get_clients { bufnr = bufnr, method = item.method }) then
      vim.cmd(('anoremenu <silent> .%d PopUp.%s <Cmd>%s<CR>'):format(item.priority, item.name, item.cmd))
      added = true
    end
  end

  if added then
    vim.cmd 'anoremenu <silent> .29 PopUp.-LspEnd- <Nop>'
  end
end

--- Open the definition in a vertical split. Deferred because creating a window
--- synchronously while the popup is still up hits textlock (E565).
function M.definition_vsplit()
  vim.schedule(function()
    vim.cmd 'vsplit'
    vim.lsp.buf.definition()
  end)
end

--- Open the references picker from a menu item. Deferred because Telescope
--- opens its windows synchronously, which hits textlock (E565) while the
--- popup is still up.
function M.references()
  vim.schedule(function()
    vim.cmd 'Telescope lsp_references'
  end)
end

--- Enable the stock conditional entries that apply to the current context,
--- mirroring the `nvim.popupmenu` handler that `define_static` cleared.
local function update_stock_items()
  vim.cmd [[
    amenu disable PopUp.Open\ in\ web\ browser
    anoremenu disable PopUp.Show\ Diagnostics
    anoremenu disable PopUp.Show\ All\ Diagnostics
    anoremenu disable PopUp.Configure\ Diagnostics
  ]]

  local url = require('vim.ui')._get_urls()[1]
  if url and vim.startswith(url, 'http') then
    vim.cmd [[amenu enable PopUp.Open\ in\ web\ browser]]
  end

  local diagnostic = next(vim.diagnostic.get(0, { lnum = vim.fn.line '.' - 1 })) ~= nil
  if diagnostic then
    vim.cmd [[anoremenu enable PopUp.Show\ Diagnostics]]
  end
  if diagnostic or next(vim.diagnostic.count(0)) ~= nil then
    vim.cmd [[
      anoremenu enable PopUp.Show\ All\ Diagnostics
      anoremenu enable PopUp.Configure\ Diagnostics
    ]]
  end
end

--- Grey out entries that have no mapping for `mode`.
--- Activating such an entry is what raises "E335: Menu not defined for <mode> mode";
--- Neovim's stock PopUp has Visual-only items (Cut/Copy/Delete) and a Normal/Insert-only
--- one (Select All). Disabled items cannot be activated, so the error becomes unreachable.
local function disable_for_mode(mode)
  for _, item in ipairs(disabled) do
    vim.cmd('silent! amenu enable ' .. item)
  end
  disabled = {}

  for _, name in ipairs(vim.fn.menu_info('PopUp', mode).submenus or {}) do
    local item = path(name)
    local info = vim.fn.menu_info(item, mode)
    -- Parent nodes report no per-mode info but are always navigable.
    if not info.submenus and vim.tbl_isempty(info) then
      vim.cmd('silent! amenu disable ' .. item)
      disabled[#disabled + 1] = item
    end
  end
end

local function on_menu_popup(args)
  local mode = args.match

  clear_hunk_items()
  clear_lsp_items()

  if mode == 'n' or mode == 'v' then
    if mode == 'v' then
      selection = { vim.fn.line 'v', vim.fn.line '.' }
    end

    -- 'mousemodel=popup_setpos' moves the cursor to the click before MenuPopup fires,
    -- so the cursor is the click position (and works when the menu is opened by keyboard).
    local staged = hunk_at(vim.api.nvim_get_current_buf(), vim.fn.line '.')
    if staged ~= nil then
      add_hunk_items(staged)
    end
  end

  if mode == 'n' then
    add_lsp_items(vim.api.nvim_get_current_buf())
  end

  update_stock_items()
  disable_for_mode(mode)
end

--- Open the hunks-to-quickfix menu, from a `PopUp` entry or a Lualine click.
--- Deferred because a menu item runs while the first popup is still up, and
--- opening another one from there hits textlock (E565).
---
--- `mouse` picks the anchor: a Lualine click has no meaningful cursor position,
--- while a `PopUp` entry may have been reached from the keyboard, where the
--- recorded mouse position is stale.
function M.open_hunks_qf(mouse)
  vim.schedule(function()
    vim.cmd(mouse and 'popup! ]GitHunksQf' or 'popup ]GitHunksQf')
  end)
end

--- Open `PopUp` at the cursor from the keyboard.
--- `:popup` does not fire `MenuPopup`, so trigger it ourselves first to get the
--- same context-dependent entries a right-click would build.
--- Plain `:popup` (no `!`) anchors to the cursor; `:popup!` would use the mouse
--- pointer, which on this path is wherever it was last left.
function M.open()
  local mode = vim.fn.mode():sub(1, 1)
  mode = (mode == 'v' or mode == 'V' or mode == '\22') and 'v' or mode
  vim.api.nvim_exec_autocmds('MenuPopup', { pattern = mode })
  vim.cmd 'popup PopUp'
end

--------------------------------------------------------------------------------
-- Per-buffer entries (for ftplugins)
--------------------------------------------------------------------------------

--- Add `items` to `PopUp` for the current buffer only, for the whole time it is
--- current. `PopUp` is global, so the entries are added on BufEnter and removed
--- on BufLeave rather than defined once.
---
--- `group` names the block (it labels the trailing separator); each item is
--- `{ name = <label>, cmd = <ex command>, priority = <menu priority> }`.
---
--- Decades .10-.49 are reserved for the built-in blocks; use .50 and up.
---
---     require('user.context_menu').attach('XmlFormat', {
---       { name = '󰗀 Format XML', cmd = 'FormatXml', priority = 50 },
---     })
function M.attach(group, items)
  local terminator = ('PopUp.-%sEnd-'):format(group)
  local last = 0

  local function add()
    for _, item in ipairs(items) do
      unmenu(path(item.name))
      vim.cmd(('anoremenu <silent> .%d %s <Cmd>%s<CR>'):format(item.priority, path(item.name), item.cmd))
      last = math.max(last, item.priority)
    end

    vim.cmd(('anoremenu <silent> .%d %s <Nop>'):format(separator_priority(last), terminator))
  end

  local function remove()
    for _, item in ipairs(items) do
      unmenu(path(item.name))
    end
    unmenu(terminator)
  end

  add()

  -- One shared augroup rather than one per buffer: the autocommands below are
  -- buffer-local, so Neovim drops them with the buffer, while a per-buffer
  -- augroup would linger in the registry for every file opened this session.
  -- Not cleared per buffer: several ftplugins may attach different blocks to the
  -- same buffer, and `add`/`remove` are idempotent, so a repeat attach is benign.
  local group_id = vim.api.nvim_create_augroup('user_context_menu_attach', { clear = false })
  vim.api.nvim_create_autocmd('BufEnter', { group = group_id, buffer = 0, callback = add })
  vim.api.nvim_create_autocmd('BufLeave', { group = group_id, buffer = 0, callback = remove })
end

--------------------------------------------------------------------------------
-- Neo-tree menu
--------------------------------------------------------------------------------

-- Neo-tree state the menu was opened from; menu items run after the fact and
-- need it to resolve the source's commands and the node under the cursor.
local neo_tree_state

--- Define the `]NeoTree` menu and the command its entries run.
--- Called from the Neo-tree plugin config.
function M.setup_neo_tree()
  vim.api.nvim_create_user_command('NeoTreeContextAction', function(args)
    local state = neo_tree_state
    local action = state and state.commands[args.args]
    if not action then
      return
    end

    -- Menu actions run while :popup is still active. Defer them until it closes,
    -- otherwise commands that prompt or change windows fail with E565.
    vim.schedule(function()
      if not vim.api.nvim_win_is_valid(state.winid) then
        return
      end

      vim.api.nvim_set_current_win(state.winid)
      action(state)
    end)
  end, { nargs = 1, force = true })

  vim.cmd [[
    silent! aunmenu PopUp.How-to\ disable\ mouse
    silent! aunmenu ]NeoTree
    nnoremenu <silent> .10 ]NeoTree.Stage <Cmd>NeoTreeContextAction git_add_file<CR>
    nnoremenu <silent> .11 ]NeoTree.Unstage <Cmd>NeoTreeContextAction git_unstage_file<CR>
    nnoremenu <silent> .19 ]NeoTree.-GitEnd- <Nop>
    nnoremenu <silent> .20 ]NeoTree.Refresh <Cmd>NeoTreeContextAction refresh<CR>
    nnoremenu <silent> .30 ]NeoTree.Rename <Cmd>NeoTreeContextAction rename<CR>
    nnoremenu <silent> .40 ]NeoTree.Delete <Cmd>NeoTreeContextAction delete<CR>
  ]]
end

--- Open the Neo-tree menu for the node under the cursor in `state`.
--- With `mouse`, the click position wins and the cursor moves to it first;
--- otherwise the cursor is used as-is (the keyboard path, where the recorded
--- mouse position is stale).
function M.open_neo_tree(state, mouse)
  if mouse then
    local pos = vim.fn.getmousepos()
    if pos.winid ~= state.winid or pos.line < 1 then
      return
    end

    vim.api.nvim_set_current_win(pos.winid)
    vim.api.nvim_win_set_cursor(pos.winid, { pos.line, math.max(pos.column - 1, 0) })
  elseif vim.api.nvim_get_current_win() ~= state.winid then
    return
  end

  local node = state.tree:get_node()
  if not node or node.type == 'message' then
    return
  end

  neo_tree_state = state
  -- `!` anchors to the mouse pointer, which is only meaningful for a right-click.
  vim.cmd(mouse and 'popup! ]NeoTree' or 'popup ]NeoTree')
end

--------------------------------------------------------------------------------

function M.setup()
  define_static()
  clear_hunk_items()
  clear_lsp_items()

  vim.api.nvim_create_autocmd('MenuPopup', {
    group = vim.api.nvim_create_augroup('user_context_menu', { clear = true }),
    pattern = '*',
    callback = on_menu_popup,
  })
end

return M
