local ok, wk = pcall(require, "which-key")

if not ok then
  return
end

wk.register ({
  -- FIND
  f = {
    name="Find",
    f = { "<cmd>Telescope find_files hidden=true<cr>", "Find File" },
    b = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
    g = { "<cmd>Telescope git_files hidden=true<cr>", "Find GIT files" },
    l = { "<cmd>Telescope live_grep<cr>", "LiveGrep" }
  },

  -- LSP
  l = {
    name="LSP",
    l = { "<cmd>Telescope diagnostics<cr>", "Show Diagnostics" },
    a = {
      name = "Actions",
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", silent = false, noremap = false, "Rename with LSP" }
    },
    d = { "<cmd>Telescope lsp_definitions<cr>", "Find Definitions" },
    r = { "<cmd>Telescope lsp_references<cr>", "Find References" },
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
