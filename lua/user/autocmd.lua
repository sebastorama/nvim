-- autocommands
--- This function is taken from https://github.com/norcalli/nvim_utils
local function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup ' .. group_name)
    vim.api.nvim_command 'autocmd!'
    for _, def in ipairs(definition) do
      local command = table.concat(vim.iter({ 'autocmd', def }):flatten():totable(), ' ')
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command 'augroup END'
  end
end

local autocmds = {
  global = {
    { 'BufRead', 'env.*', 'setlocal filetype=sh' },
    { 'BufNewFile', 'env.*', 'setlocal filetype=sh' },
    { 'CmdWinEnter', '*', 'startinsert' },
  },
  terminal_job = {
    { 'TermOpen', '*', [[tnoremap <buffer> <Esc> <c-\><c-n>]] },
    { 'TermOpen', '*', 'startinsert' },
    { 'TermOpen', '*', 'setlocal listchars= nonumber norelativenumber' },
  },
  remember_folds = {
    { 'BufwinLeave', '*.*', 'mkview' },
    { 'BufWinEnter', '*.*', 'silent! loadview' },
  },
}

nvim_create_augroups(autocmds)

-- Auto-reload routeTree.gen.ts when changed externally
vim.api.nvim_create_autocmd("FileChangedShell", {
  pattern = "**/src/routeTree.gen.ts",
  callback = function()
    -- Automatically choose to load the file
    vim.v.fcs_choice = "reload"
    -- Notify LSP about the file change
    vim.schedule(function()
      vim.cmd("silent! edit")
      -- Force LSP to re-analyze the file
      vim.lsp.buf_notify(0, "textDocument/didChange", {
        textDocument = {
          uri = vim.uri_from_bufnr(0),
          version = vim.lsp.util.buf_versions[0] or 0
        }
      })
    end)
  end,
})

-- Also handle when the file is changed while we're focused on it
vim.api.nvim_create_autocmd({"FocusGained", "BufEnter"}, {
  pattern = "**/src/routeTree.gen.ts",
  callback = function()
    vim.cmd("silent! checktime")
  end,
})
-- autocommands END
