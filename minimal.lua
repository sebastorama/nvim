require("user.globals")

local modules = {
  "user.autopairs",
  "user.color",
  "user.diffview",
  "user.keymaps",
  "user.neogit",
  "user.ntree",
  -- "user.options",
  "user.plugins",
  "user.telescope",
  -- "user.treesitter",
  "user.which-key",
}

for k, v in pairs(modules) do
  package.loaded[v] = nil
  require(v)
end

vim.opt.swapfile = false -- creates a swapfile
vim.opt.tabstop = 4 -- insert 4 spaces for a tab
vim.opt.backup = false -- creates a backup file
vim.opt.wrap = false -- display lines as one long line

local ts_configs = require("nvim-treesitter.configs")

ts_configs.setup({
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "sql" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})

vim.cmd([[let g:ftplugin_sql_omni_key = '<C-s>']])
