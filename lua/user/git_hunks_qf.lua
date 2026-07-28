local M = {}

local function git(root, args)
  local command = { 'git', '-C', root }
  vim.list_extend(command, args)

  local result = vim.system(command, { text = true }):wait()
  if result.code ~= 0 then
    return nil, (result.stderr or ''):gsub('%s+$', '')
  end

  return result.stdout or ''
end

local function git_root()
  if vim.bo.buftype == 'quickfix' then
    local context = vim.fn.getqflist({ context = 1 }).context
    if type(context) == 'table' and context.git_root then
      return context.git_root
    end
  end

  local name = vim.api.nvim_buf_get_name(0)
  local cwd = name ~= '' and vim.fs.dirname(name) or vim.uv.cwd()
  local output, err = git(cwd, { 'rev-parse', '--show-toplevel' })
  if not output then
    return nil, err
  end

  return vim.trim(output)
end

local function changed_files(root, args)
  local output, err = git(root, args)
  if not output then
    return nil, err
  end

  return vim.split(output, '\0', { plain = true, trimempty = true })
end

local function parse_hunks(patch)
  local hunks = {}
  local current

  for _, line in ipairs(vim.split(patch, '\n', { plain = true })) do
    local old_start, old_count, new_start, new_count = line:match '^@@ %-(%d+),?(%d*) %+(%d+),?(%d*) @@'
    if old_start then
      old_count = old_count == '' and 1 or tonumber(old_count)
      new_count = new_count == '' and 1 or tonumber(new_count)
      current = {
        head = line,
        removed = { start = tonumber(old_start), count = old_count, lines = {} },
        added = { start = tonumber(new_start), count = new_count, lines = {} },
      }
      hunks[#hunks + 1] = current
    elseif current then
      local prefix = line:sub(1, 1)
      if prefix == '+' then
        current.added.lines[#current.added.lines + 1] = line:sub(2)
      elseif prefix == '-' then
        current.removed.lines[#current.removed.lines + 1] = line:sub(2)
      end
    end
  end

  return hunks
end

local function hunks_for_file(root, path, staged)
  local args = { 'diff' }
  if staged then
    args[#args + 1] = '--cached'
  end
  vim.list_extend(args, { '--no-ext-diff', '--no-color', '--unified=0', '--', path })

  local patch, err = git(root, args)
  if not patch then
    return nil, err
  end

  return parse_hunks(patch)
end

local function map_index_line_to_worktree(line, unstaged_hunks)
  local offset = 0

  for _, hunk in ipairs(unstaged_hunks) do
    local old_start = hunk.removed.start
    local old_count = hunk.removed.count
    local old_end = old_start + math.max(old_count - 1, 0)

    if old_count > 0 and line >= old_start and line <= old_end then
      local relative_line = math.min(line - old_start, math.max(hunk.added.count - 1, 0))
      return math.max(hunk.added.start + relative_line, 1)
    end

    if line > old_end then
      offset = offset + hunk.added.count - old_count
    end
  end

  return math.max(line + offset, 1)
end

local function hunk_kind(hunk)
  if hunk.removed.count == 0 then
    return 'Added'
  elseif hunk.added.count == 0 then
    return 'Removed'
  end
  return 'Changed'
end

local function add_hunks(items, root, path, hunks, state, unstaged_hunks)
  local filename = vim.fs.joinpath(root, path)
  -- A path deleted in the worktree has nothing to jump to: a quickfix entry
  -- pointing at it would open an empty buffer that recreates the file if
  -- written. Such hunks are listed without a location instead.
  local exists = vim.uv.fs_stat(filename) ~= nil

  for _, hunk in ipairs(hunks) do
    local line = hunk.added.start
    if state == 'staged' then
      line = map_index_line_to_worktree(line, unstaged_hunks)
    end

    local preview = hunk.added.lines[1] or hunk.removed.lines[1] or hunk.head
    local text = ('[%s] %-7s %s'):format(state, hunk_kind(hunk), preview)

    if exists then
      items[#items + 1] = {
        filename = filename,
        lnum = math.max(line, 1),
        col = 1,
        text = text,
      }
    else
      items[#items + 1] = {
        valid = 0,
        text = ('%s: [%s] Deleted %s'):format(path, state, preview),
      }
    end
  end
end

function M.open(filter)
  filter = filter or 'all'
  if filter ~= 'all' and filter ~= 'staged' and filter ~= 'unstaged' then
    vim.notify('Git hunk filter must be: all, staged, or unstaged', vim.log.levels.ERROR)
    return
  end

  local root, root_err = git_root()
  if not root then
    vim.notify(root_err ~= '' and root_err or 'Not inside a Git repository', vim.log.levels.ERROR)
    return
  end

  local unstaged_files, unstaged_err = changed_files(root, { 'diff', '--name-only', '-z' })
  local staged_files, staged_err = changed_files(root, { 'diff', '--cached', '--name-only', '-z' })
  local untracked_files, untracked_err = changed_files(root, { 'ls-files', '--others', '--exclude-standard', '-z' })
  local error_message = unstaged_err or staged_err or untracked_err
  if error_message then
    vim.notify(error_message, vim.log.levels.ERROR)
    return
  end

  local items = {}
  local unstaged_by_file = {}

  for _, path in ipairs(unstaged_files) do
    local hunks, err = hunks_for_file(root, path, false)
    if not hunks then
      vim.notify(err, vim.log.levels.ERROR)
      return
    end
    unstaged_by_file[path] = hunks
    if filter ~= 'staged' then
      add_hunks(items, root, path, hunks, 'unstaged', hunks)
    end
  end

  if filter ~= 'unstaged' then
    for _, path in ipairs(staged_files) do
      local hunks, err = hunks_for_file(root, path, true)
      if not hunks then
        vim.notify(err, vim.log.levels.ERROR)
        return
      end
      add_hunks(items, root, path, hunks, 'staged', unstaged_by_file[path] or {})
    end
  end

  if filter ~= 'staged' then
    for _, path in ipairs(untracked_files) do
      items[#items + 1] = {
        filename = vim.fs.joinpath(root, path),
        lnum = 1,
        col = 1,
        text = '[unstaged] Added   untracked file',
      }
    end
  end

  -- Deleted paths carry no filename or lnum, so fall back to empty/zero rather
  -- than comparing nil.
  table.sort(items, function(a, b)
    local a_name, b_name = a.filename or '', b.filename or ''
    if a_name ~= b_name then
      return a_name < b_name
    end

    local a_lnum, b_lnum = a.lnum or 0, b.lnum or 0
    if a_lnum ~= b_lnum then
      return a_lnum < b_lnum
    end

    return a.text < b.text
  end)

  vim.fn.setqflist({}, ' ', {
    title = 'Git hunks (' .. filter .. ')',
    context = { git_root = root, git_filter = filter },
    items = items,
  })

  if #items == 0 then
    vim.notify('No ' .. filter .. ' Git hunks found', vim.log.levels.INFO)
    return
  end

  vim.cmd 'copen'
end

return M
