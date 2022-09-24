local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/dev/dap/vscode-chrome-debug/out/src/chromeDebug.js" }, -- TODO set as ENV VAR?
}

dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/dev/dap/vscode-node-debug2/out/src/nodeDebug.js" },
}

-- change this to javascript if needed
dap.configurations.javascriptreact = {
  {
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}",
  },
}

dap.configurations.typescriptreact = { -- change to typescript if needed
  {
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}",
  },
}

dap.configurations.typescript = { -- change to typescript if needed
  {
    name = "Launch",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = "Attach to process",
    type = "node2",
    sourceMaps = true,
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
}

dap.adapters.ruby = function(callback, config)
  callback({
    type = "server",
    host = "127.0.0.1",
    port = 38697,
  })
end

dap.adapters.ruby = {
  type = "executable",
  command = "bundle",
  args = { "exec", "readapt", "stdio" },
}

dap.configurations.ruby = {
  {
    type = "ruby",
    request = "launch",
    name = "Rails",
    program = "bundle",
    programArgs = { "exec", "rails", "s" },
    useBundler = true,
  },
}
