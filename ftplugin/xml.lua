if vim.b.did_user_xml_ftplugin then
  return
end
vim.b.did_user_xml_ftplugin = true

local function format_xml()
  if vim.fn.executable 'xmlstarlet' ~= 1 then
    vim.notify('xmlstarlet is not installed', vim.log.levels.ERROR)
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local input = table.concat(lines, '\n')
  if vim.bo.endofline then
    input = input .. '\n'
  end

  local has_declaration = input:match '^%s*<%?xml%s' ~= nil
  local command = { 'xmlstarlet', 'format', '--indent-spaces', '2' }
  local result = vim.system(command, { stdin = input, text = true }):wait()
  if result.code ~= 0 then
    local message = (result.stderr or ''):gsub('%s+$', '')
    vim.notify(message ~= '' and message or 'xmlstarlet failed to format the buffer', vim.log.levels.ERROR)
    return
  end

  local output = result.stdout or ''
  if not has_declaration then
    output = output:gsub('^<%?xml[^?]*%?>\r?\n?', '', 1)
  end

  local has_endofline = output:sub(-1) == '\n'
  if has_endofline then
    output = output:sub(1, -2)
  end

  local formatted_lines = output == '' and {} or vim.split(output, '\n', { plain = true })
  local view = vim.fn.winsaveview()
  vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted_lines)
  vim.bo.endofline = has_endofline
  vim.fn.winrestview(view)
end

vim.api.nvim_buf_create_user_command(0, 'FormatXml', format_xml, {
  desc = 'Format the current XML buffer with xmlstarlet',
})

require('user.context_menu').attach('XmlFormat', {
  { name = '󰗀 Format XML', cmd = 'FormatXml', priority = 40 },
})
