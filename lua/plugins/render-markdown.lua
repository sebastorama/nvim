return {
  {
    -- Make sure to set this up properly if you have lazy=true
    'MeanderingProgrammer/render-markdown.nvim',
    enabled = true,
    opts = {
      file_types = { 'markdown', 'Avante' },
    },
    ft = { 'markdown', 'Avante' },
    config = function()
      require('render-markdown').setup({
        file_types = { 'markdown', 'Avante' },
      })
    end,
  },
}
