return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufEnter',
    config = function()
      local gitsigns = require('gitsigns')
      local color = require('gitsigns.color')

      local function highlight_staged_signs()
        local visual_background = vim.api.nvim_get_hl(0, { name = 'Visual', link = false }).bg
        local normal_background = vim.api.nvim_get_hl(0, { name = 'Normal', link = false }).bg
          or vim.api.nvim_get_color_by_name(vim.g.terminal_color_0 or '#000000')
        local staged_background =
          color.rgb_to_int(color.blend(color.int_to_rgb(normal_background), color.int_to_rgb(visual_background), 0.45))

        for _, type in ipairs { 'Add', 'Change', 'Delete', 'Topdelete', 'Changedelete' } do
          local highlight = vim.api.nvim_get_hl(0, { name = 'GitSigns' .. type, link = false })
          highlight.bg = staged_background
          highlight.bold = true
          vim.api.nvim_set_hl(0, 'GitSignsStaged' .. type, highlight)
        end
      end

      gitsigns.setup {
        signs = {
          add = { text = '│' },
          change = { text = '│' },
          delete = { text = '▾', show_count = true },
          topdelete = { text = '▴', show_count = true },
          changedelete = { text = '~', show_count = true },
          untracked = { text = '┆' },
        },
        signs_staged = {
          add = { text = '┃' },
          change = { text = '┃' },
          delete = { text = '▼', show_count = true },
          topdelete = { text = '▲', show_count = true },
          changedelete = { text = '≈', show_count = true },
        },
        signs_staged_enable = true,
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1,
        },
      }

      highlight_staged_signs()
      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('gitsigns_staged_highlights', { clear = true }),
        callback = highlight_staged_signs,
      })
    end,
  },
}
