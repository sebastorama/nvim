return {
  {
    'TimUntersberger/neogit',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = 'Neogit',
    config = function()
      local neogit = require('neogit')

      neogit.setup {
        disable_signs = false,
        disable_hint = false,
        disable_context_highlighting = true,
        disable_commit_confirmation = false,
        -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
        -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
        auto_refresh = true,
        disable_builtin_notifications = false,
        use_magit_keybindings = false,
        commit_popup = {
          kind = 'split',
        },
        -- Change the default way of opening neogit
        kind = 'tab',
        -- customize displayed signs
        signs = {
          -- { CLOSED, OPENED }
          section = { '>', 'v' },
          item = { '>', 'v' },
          hunk = { '', '' },
        },
        integrations = {
          -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
          -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
          --
          -- Requires you to have `sindrets/diffview.nvim` installed.
          -- use {
          --   "TimUntersberger/neogit",
          --   requires = {
          --     "nvim-lua/plenary.nvim",
          --     "sindrets/diffview.nvim"
          --   }
          -- }
          --
          diffview = true,
        },
        -- Setting any section to `false` will make the section not render at all
        sections = {
          untracked = {
            folded = false,
          },
          unstaged = {
            folded = false,
          },
          staged = {
            folded = false,
          },
          stashes = {
            folded = true,
          },
          unpulled = {
            folded = true,
            hidden = false,
          },
          unmerged = {
            folded = false,
            hidden = false,
          },
          recent = {
            folded = true,
          },
        },
        -- override/add mappings
        mappings = {
          -- modify status buffer mappings
          status = {
            -- Adds a mapping with "B" as key that does the "BranchPopup" command
            --["B"] = "BranchPopup",
            -- Removes the default mapping of "s"
            --["s"] = "",
          },
        },
      }
    end,
  },
}
