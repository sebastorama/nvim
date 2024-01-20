local ok, wk = pcall(require, "which-key")

if not ok then
  return
end

wk.register({
  -- QUICKFIX
  c = {
    name = "Quickfix",
    c = { "<cmd>ccl<CR>", "Close Quickfix" },
    o = { "<cmd>copen<CR>", "Open Quickfix" },
  },
  d = {
    name = "Debug",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
    c = { "<cmd>lua require'dap'.continue()<CR>", "Continue/Run" },
    k = { "<cmd>lua require'dapui'.eval()<CR>", "DapUI Eval" },
  },
  -- FIND
  f = {
    name = "Find",
    f = { "<cmd>Telescope find_files hidden=false<CR>", "Find File" },
    b = { "<cmd>lua require('telescope.builtin').buffers({ layout_config={ width=0.5 }})<CR>", "Find Buffers" },
    g = { "<cmd>Telescope git_files hidden=true<CR>", "Find GIT files" },
    l = { "<cmd>Telescope live_grep use_regex=true<CR>", "LiveGrep" },
  },
  F = {
    name = "Global Find",
    F = { "<cmd>lua require('telescope.builtin').find_files({ cwd='~/dev'})<CR>", "Find File" },
  },
  -- GIT
  g = {
    name = "GIT",
    g = { "<cmd>Neogit<CR>", "Open Neogit" },
    s = { "<cmd>DiffviewOpen<CR>", "File History" },
    h = { "<cmd>DiffviewFileHistory<CR>", "File History" },
    x = { "<cmd>DiffviewClose<CR>", "Close Diffview" },
  },
  -- LSP
  l = {
    name = "LSP",
    a = {
      name = "Actions",
      r = { "<cmd>lua vim.lsp.buf.rename()<CR>", silent = false, noremap = false, "Rename with LSP" },
      o = {
        '<cmd>lua vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.fn.expand("%:p")}})<CR>',
        silent = false,
        noremap = false,
        "Typescript organize imports",
      },
    },
    f = { "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", "Format File" },
    d = { "<cmd>Telescope lsp_definitions<CR>", "Find Definitions" },
    l = { "<cmd>Telescope diagnostics<CR>", "Show Diagnostics" },
    r = { "<cmd>Telescope lsp_references<CR>", "Find References" },
    o = { "<cmd>AerialToggle<CR>", "Toggle Outline" },
  },
  o = {
    name = "Obsidian",
    n = { "<cmd>ObsidianNew<CR>", "New Note" },
    r = { "<cmd>ObsidianRename<CR>", "Rename Note" },
  },
  t = {
    name = "Typescript",
    o = { "<cmd>TypescriptOrganizeImports<CR>", "Organize Imports" },
  },
}, { prefix = "<leader>" })

wk.register({
  a = {
    name = "Aerial",
    a = { "<cmd>AerialToggle<CR>", "Diffview Open" },
  },
  d = {
    name = "Diffview",
    d = { "<cmd>DiffviewOpen<CR>", "Diffview Open" },
    c = { "<cmd>DiffviewClose<CR>", "Diffview Open" },
  },
  b = {
    "<cmd>buffers<CR>", "Buffers (neovim native)"
  },
}, { prefix = "," })
