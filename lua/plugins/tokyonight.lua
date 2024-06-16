return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    enabled = true,
    config = function()
      local tokyonight = require('tokyonight')

      tokyonight.setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = 'moon',         -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        transparent = false,    -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = 'transparent',       -- style for sidebars, see below
          floats = 'transparent',         -- style for floating windows
        },
        sidebars = { 'qf', 'help' },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.1,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = true,              -- dims inactive windows
        lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold
        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        on_colors = function(colors)
          colors.border = '#333333'
        end,
        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        on_highlights = function(hl, colors)
          local lines_fg = "#666666";
          hl.LineNr = {
            fg = colors.yellow
          }
          hl.LineNrAbove = {
            fg = lines_fg
          }
          hl.LineNrBelow = {
            fg = lines_fg
          }
          hl.GitGutterAddLineNr = {
            fg = lines_fg
          }
        end,
      }

      vim.cmd [[set bg=dark]]
      vim.cmd [[colorscheme tokyonight-moon]]
      vim.cmd [[hi Substitute guibg=#ffaaaa guifg=#666666]]

      vim.cmd [[hi RustInlayHints guifg=#535C7E]]
    end,
  },
}
