return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      local autopairs = require('nvim-autopairs')

      local cfg = {
        disable_filetype = { 'TelescopePrompt' },
        disable_in_macro = false, -- disable when recording or executing a macro
        disable_in_visualblock = false, -- disable when insert after visual block mode
        ignored_next_char = string.gsub([[ [%w%%%"%[%"%.] ]], '%s+', ''),
        enable_moveright = true,
        enable_afterquote = true, -- add bracket pairs after quote
        enable_check_bracket_line = true, --- check bracket in same line
        enable_bracket_in_quote = true, --
        check_ts = false,
        map_cr = true,
        map_bs = true, -- map the <BS> key
        map_c_h = false, -- Map the <C-h> key to delete a pair
        map_c_w = false, -- map <c-w> to delete a pair if possible
      }

      autopairs.setup(cfg)
    end,
  },
}
