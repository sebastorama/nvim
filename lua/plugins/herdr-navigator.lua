return {
  {
    'willfish/herdr-navigator.nvim',
    config = function()
      require('herdr-navigator').setup {
        mappings = {
          left = '<C-h>',
          down = '<C-j>',
          up = '<C-k>',
          right = '<C-l>',
        },
      }
    end,
  },
}
