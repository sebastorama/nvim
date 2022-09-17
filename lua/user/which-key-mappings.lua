local ok, wk = pcall(require, "which-key")

if not ok then
  return
end

wk.register({
  -- QUICKFIX
  c = {
    name = "Quickfix",
    c = { "<cmd>ccl<cr>", "Close Quickfix" },
    o = { "<cmd>copen<cr>", "Open Quickfix" },
  },
  d = {
    name = "Debug",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue/Run" },
    k = { "<cmd>lua require'dapui'.eval()<cr>", "DapUI Eval" },
  },

  -- FIND
  f = {
    name = "Find",
    f = { "<cmd>Telescope find_files hidden=false<cr>", "Find File" },
    b = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
    g = { "<cmd>Telescope git_files hidden=true<cr>", "Find GIT files" },
    l = { "<cmd>Telescope live_grep use_regex=true<cr>", "LiveGrep" },
  },

  F = {
    name = "Global Find",
    F = { "<cmd>lua require('telescope.builtin').find_files({ cwd='~/dev'})<cr>", "Find File" },
  },

  -- GIT
  g = {
    name = "GIT",
    g = { "<cmd>Neogit<cr>", "Open Neogit" },
    s = { "<cmd>DiffviewOpen<cr>", "File History" },
    h = { "<cmd>DiffviewFileHistory<cr>", "File History" },
    x = { "<cmd>DiffviewClose<cr>", "Close Diffview" },
  },

  -- LSP
  l = {
    name = "LSP",
    a = {
      name = "Actions",
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", silent = false, noremap = false, "Rename with LSP" },
      o = {
        '<cmd>lua vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.fn.expand("%:p")}})<cr>',
        silent = false,
        noremap = false,
        "Typescript organize imports",
      },
    },
    f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format File" },
    d = { "<cmd>Telescope lsp_definitions<cr>", "Find Definitions" },
    l = { "<cmd>Telescope diagnostics<cr>", "Show Diagnostics" },
    r = { "<cmd>Telescope lsp_references<cr>", "Find References" },
    o = { "<cmd>AerialToggle<cr>", "Toggle Outline" },
  },

  t = {
    name = "Typescript",
    o = { "<cmd>TypescriptOrganizeImports<cr>", "Organize Imports" },
  },
}, { prefix = "<leader>" })
