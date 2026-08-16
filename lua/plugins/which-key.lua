local function stage_selected_hunk()
  require('gitsigns').stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
end

local function toggle_quickfix()
  for _, window in ipairs(vim.fn.getwininfo()) do
    if window.quickfix == 1 and window.loclist == 0 then
      vim.cmd.cclose()
      return
    end
  end

  vim.cmd.copen()
end

local function find_workspace_symbol_under_cursor()
  require('telescope.builtin').lsp_workspace_symbols {
    bufnr = vim.w.lsp_floating_bufnr or 0,
    query = vim.fn.expand '<cword>',
  }
end

return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      preset = 'modern',
    },
    keys = {
      { '<leader>F', group = 'Global Find' },
      {
        '<leader>FF',
        "<cmd>lua require('telescope.builtin').find_files({ cwd='~/dev'})<CR>",
        desc = 'Find File',
      },
      { '<leader>c', group = 'Quickfix' },
      {
        '<leader>cc',
        toggle_quickfix,
        desc = 'Toggle Quickfix',
      },
      { '<leader>d', group = 'Debug' },
      {
        '<leader>dB',
        "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
        desc = 'Set Conditional Breakpoint',
      },
      {
        '<leader>db',
        "<cmd>lua require'dap'.toggle_breakpoint()<CR>",
        desc = 'Toggle Breakpoint',
      },
      {
        '<leader>dc',
        "<cmd>lua require'dap'.continue()<CR>",
        desc = 'Continue/Run',
      },
      {
        '<leader>dd',
        "<cmd>lua require'dapui'.eval()<CR>",
        desc = 'DapUI Eval',
      },
      {
        '<leader>dj',
        "<cmd>lua require'dap'.step_into()<CR>",
        desc = 'Step Into',
      },
      {
        '<leader>dk',
        "<cmd>lua require'dap'.step_out()<CR>",
        desc = 'Step Out',
      },
      {
        '<leader>dl',
        "<cmd>lua require'dap'.step_over()<CR>",
        desc = 'Step Over',
      },
      {
        '<leader>du',
        "<cmd>lua require'dapui'.toggle()<CR>",
        desc = 'DapUI Toggle',
      },
      { '<leader>f', group = 'Find' },
      {
        '<leader>fb',
        "<cmd>lua require('telescope.builtin').buffers({ layout_config={ width=0.5 }})<CR>",
        desc = 'Find Buffers',
      },
      {
        '<leader>ff',
        '<cmd>Telescope find_files hidden=false<CR>',
        desc = 'Find File',
      },
      {
        '<leader>f ',
        '<cmd>Telescope find_files hidden=true no_ignore=true<CR>',
        desc = 'Find File',
      },
      {
        '<leader>fg',
        '<cmd>Telescope git_files hidden=true<CR>',
        desc = 'Find GIT files',
      },
      {
        '<leader>fl',
        '<cmd>Telescope live_grep use_regex=true<CR>',
        desc = 'LiveGrep',
      },
      { '<leader>g', group = 'GIT' },
      {
        '<leader>gg',
        '<cmd>Neogit<CR>',
        desc = 'Open Neogit',
      },
      {
        '<leader>gh',
        '<cmd>DiffviewFileHistory<CR>',
        desc = 'File History',
      },
      {
        '<leader>gs',
        '<cmd>Gitsigns stage_hunk<CR>',
        desc = 'Stage Hunk',
      },
      {
        '<leader>gs',
        stage_selected_hunk,
        desc = 'Stage Selected Hunk',
        mode = 'v',
      },
      {
        '<leader>gu',
        '<cmd>Gitsigns stage_hunk<CR>',
        desc = 'Unstage Hunk',
      },
      {
        '<leader>gu',
        stage_selected_hunk,
        desc = 'Unstage Selected Hunk',
        mode = 'v',
      },
      {
        '<leader>gx',
        '<cmd>DiffviewClose<CR>',
        desc = 'Close Diffview',
      },
      { '<leader>l', group = 'LSP' },
      {
        '<leader>lS',
        '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>',
        desc = 'Find Workspace Symbols',
      },
      { '<leader>la', group = 'Actions' },
      {
        '<leader>lao',
        '<cmd>lua vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.fn.expand("%:p")}})<CR>',
        desc = 'Typescript organize imports',
        remap = true,
        silent = false,
      },
      {
        '<leader>lar',
        '<cmd>lua vim.lsp.buf.rename()<CR>',
        desc = 'Rename with LSP',
        remap = true,
        silent = false,
      },
      {
        '<leader>ld',
        '<cmd>Telescope lsp_definitions<CR>',
        desc = 'Find Definitions',
      },
      {
        '<leader>lf',
        '<cmd>lua vim.lsp.buf.format({ async = true })<CR>',
        desc = 'Format File',
      },
      {
        '<leader>ll',
        '<cmd>Telescope diagnostics<CR>',
        desc = 'Show Diagnostics',
      },
      {
        '<leader>lo',
        '<cmd>AerialToggle<CR>',
        desc = 'Toggle Outline',
      },
      {
        '<leader>lr',
        '<cmd>Telescope lsp_references<CR>',
        desc = 'Find References',
      },
      {
        '<leader>ls',
        '<cmd>Telescope lsp_document_symbols<CR>',
        desc = 'Find Document Symbols',
      },
      {
        '<leader>lt',
        find_workspace_symbol_under_cursor,
        desc = 'Find Cursor Symbol in Workspace',
      },
      { '<leader>o', group = 'Obsidian' },
      {
        '<leader>on',
        '<cmd>Obsidian new<CR>',
        desc = 'New Note',
      },
      {
        '<leader>or',
        '<cmd>Obsidian rename<CR>',
        desc = 'Rename Note',
      },
      {
        ' a',
        '<cmd>AerialToggle<CR>',
        desc = 'Aerial Toggle',
      },
      {
        ' b',
        '<cmd>Neotree toggle source=buffers<CR>',
        desc = 'Buffers (neovim native)',
      },
      { ' d', group = 'Diffview' },
      {
        ' dc',
        '<cmd>DiffviewClose<CR>',
        desc = 'Diffview Open',
      },
      {
        ' dd',
        '<cmd>DiffviewOpen<CR>',
        desc = 'Diffview Open',
      },
      {
        ' dt',
        '<cmd>DiffviewToggleFiles<CR>',
        desc = 'Diffview Toggle Files',
      },
      {
        ' n',
        '<cmd>Navbuddy<CR>',
        desc = 'Navbuddy Toggle',
      },
    },
  },
}
