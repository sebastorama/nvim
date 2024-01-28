local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local exts = { "javascript", "javascriptreact", "typescript", "typescriptreact" }

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}", --let both ports be the same for now...
  executable = {
    command = "node",
    -- -- 💀 Make sure to update this path to point to your installation
    args = { vim.fn.stdpath('data') .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
    -- command = "js-debug-adapter",
    -- args = { "${port}" },
  },
}

dap.adapters["pwa-chrome"] = {
  type = "executable",
  command = "node",
  port = "${port}",
  args = { vim.fn.stdpath('data') .. "/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js", "${port}" },
}

for i, ext in ipairs(exts) do
  dap.configurations[ext] = {
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach Program (pwa-node)',
      cwd = vim.fn.getcwd(),
      processId = require('dap.utils').pick_process,
      skipFiles = { '<node_internals>/**' },
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Auto Attach",
      cwd = vim.fn.getcwd()
    },
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Launch Chrome with \"localhost\"",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}"
    }
  }
end

