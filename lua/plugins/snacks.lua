return {
  {
    'folke/snacks.nvim',
    keys = {
      {
        '<leader>ss',
        function()
          Snacks.scratch()
        end,
        desc = 'Toggle Scratch Buffer',
      },
      {
        '<leader>sf',
        function()
          Snacks.scratch.select()
        end,
        desc = 'Select Scratch Buffer',
      },
    },

    opts = {
      scratch = {
        ft = 'markdown',
      },
    },
  },
}
