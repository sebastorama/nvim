local M = {}

M.setup = function()
  require("neorg").setup {
    load = {
      ["core.defaults"] = {}, -- Loads default behaviour
      ["core.concealer"] = {}, -- Adds pretty icons to your documents
      ["core.tangle"] = {}, -- Tangle codeblocks to files
      ["core.dirman"] = { -- Manages Neorg workspaces
        config = {
          workspaces = {
            main = "~/norg",
          },
        },
      },
    },
  }
end

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.norg"},
  command = "set conceallevel=3"
})

return M
