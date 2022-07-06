local ok, wk = pcall(require, "which-key")

if not ok then
  return
end

wk.register({
  -- QUICKFIX
  c = {
    name ="Quickfix",
    c = { "<cmd>ccl<cr>", "Close Quickfix"}
  },
  -- FIND
  f = {
    name = "Find",
    f = { "<cmd>Telescope find_files hidden=false<cr>", "Find File" },
    b = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
    g = { "<cmd>Telescope git_files hidden=true<cr>", "Find GIT files" },
    l = { "<cmd>Telescope live_grep<cr>", "LiveGrep" }
  },

  -- LSP
  l = {
    name = "LSP",
    a = {
      name = "Actions",
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", silent = false, noremap = false, "Rename with LSP" }
    },
    f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format File" },
    d = { "<cmd>Telescope lsp_definitions<cr>", "Find Definitions" },
    l = { "<cmd>Telescope diagnostics<cr>", "Show Diagnostics" },
    r = { "<cmd>Telescope lsp_references<cr>", "Find References" },
    o = { "<cmd>SymbolsOutline<cr>", "Toggle Outline" }
  },

  -- GIT
  g = {
    name = "GIT",
    g = { "<cmd>Neogit<cr>", "Open Neogit" },
    s = { "<cmd>DiffviewOpen<cr>", "File History" },
    h = { "<cmd>DiffviewFileHistory<cr>", "File History" },
    x = { "<cmd>DiffviewClose<cr>", "Close Diffview" },
  }
}, { prefix = "<leader>" })
