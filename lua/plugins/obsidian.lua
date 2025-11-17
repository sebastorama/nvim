return {
  'obsidian-nvim/obsidian.nvim',
  enabled = false,
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = false,
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',

    -- see below for full list of optional dependencies 👇
  },

  config = function()
    require('obsidian').setup({
      workspaces = {
        {
          name = 'Main',
          path = '~/obsidian/Main',
        },
      },
      ui = {
        enable = false,
      },

      daily_notes = {
        folder = 'daily/',
      },

      legacy_commands = false,
    })

    local opts = { noremap = true, silent = true }

    Keymap('n', '<leader>ob', ':Obsidian backlinks<CR>', opts)
    Keymap('n', '<leader>od', ':Obsidian dailies<CR>', opts)

    -- gf follows links, or is passed through to the next handler if not a link
    vim.keymap.set('n', 'gf', function()
      if require('obsidian').util.cursor_on_markdown_link() then
        return ':Obsidian follow_link<CR>'
      else
        return 'gf'
      end
    end, opts)
  end,
}
