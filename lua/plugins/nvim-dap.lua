return {
  {
    'mfussenegger/nvim-dap',
    event = 'BufEnter',
    config = function()
      local dap = require('dap')

      local exts = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }

      dap.adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}', --let both ports be the same for now...
        executable = {
          command = 'node',
          -- -- 💀 Make sure to update this path to point to your installation
          args = {
            vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
            '${port}',
          },
          -- command = "js-debug-adapter",
          -- args = { "${port}" },
        },
      }

      dap.adapters['pwa-chrome'] = {
        type = 'executable',
        command = 'node',
        port = '${port}',
        args = { vim.fn.stdpath('data') .. '/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js', '${port}' },
      }

      dap.adapters['pwa-msedge'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          args = {
            vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
            '${port}',
          },
        },
      }

      for i, ext in ipairs(exts) do
        dap.configurations[ext] = {
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Auto Attach',
            cwd = vim.fn.getcwd(),
          },
          {
            type = 'pwa-msedge',
            request = 'launch',
            name = 'Launch Edge with "localhost"',
            url = function()
              return vim.fn.input('Enter the url to open: ')
            end,
            webRoot = '${workspaceFolder}',
            runtimeExecutable = '/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge',
            runtimeArgs = { '--disable-gpu' },
          },
          {
            type = 'pwa-chrome',
            request = 'launch',
            name = 'Launch Chrome with "localhost"',
            url = function()
              return vim.fn.input('Enter the url to open: ')
            end,
            webRoot = '${workspaceFolder}',
            runtimeArgs = { '--disable-gpu' },
          },
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach Program (pwa-node)',
            cwd = vim.fn.getcwd(),
            processId = require('dap.utils').pick_process,
            skipFiles = { '<node_internals>/**' },
          },
        }
      end

      vim.cmd [[hi DapBreakpointLine ctermbg=0 guibg=#222436]]
      vim.cmd [[hi DapLogPointLine ctermbg=0 guibg=#222436]]
      vim.cmd [[hi DapStoppedLine ctermbg=0 guibg=#222436]]

      vim.cmd [[hi DapBreakpointNum ctermbg=0 guifg=#993939 guibg=#222436]]
      vim.cmd [[hi DapLogPointNum ctermbg=0 guifg=#61afef guibg=#222436]]
      vim.cmd [[hi DapStoppedNum ctermbg=0 guifg=#98c379 guibg=#222436]]

      vim.fn.sign_define(
        'DapBreakpoint',
        { text = '', texthl = 'DapBreakpointNum', linehl = 'DapBreakpointLine', numhl = 'DapBreakpointNum' }
      )
      vim.fn.sign_define(
        'DapBreakpointCondition',
        { text = 'ﳁ', texthl = 'DapBreakpointNum', linehl = 'DapBreakpointLine', numhl = 'DapBreakpointNum' }
      )
      vim.fn.sign_define(
        'DapBreakpointRejected',
        { text = '', texthl = 'DapBreakpointNum', linehl = 'DapBreakpointLine', numhl = 'DapBreakpointNum' }
      )
      vim.fn.sign_define(
        'DapLogPoint',
        { text = '', texthl = 'DapLogPointNum', linehl = 'DapLogPointLine', numhl = 'DapLogPointNum' }
      )
      vim.fn.sign_define(
        'DapStopped',
        { text = '', texthl = 'DapStoppedNum', linehl = 'DapStoppedLine', numhl = 'DapStoppedNum' }
      )

      -- Keymaps
      local opts = { noremap = true, silent = true }
      Keymap('n', '<M-S-h>', "<cmd>lua require('dap').continue()<CR>", { noremap = true, silent = true })
      Keymap('n', '<M-S-j>', "<cmd>lua require('dap').step_into()<CR>", { noremap = true, silent = true })
      Keymap('n', '<M-S-k>', "<cmd>lua require('dap').step_out()<CR>", { noremap = true, silent = true })
      Keymap('n', '<M-S-l>', "<cmd>lua require('dap').step_over()<CR>", { noremap = true, silent = true })
    end,
  },
}
