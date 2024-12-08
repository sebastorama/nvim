return {
  {
    'echasnovski/mini.notify',
    version = '*',
    config = function()
      require('mini.notify').setup()

      vim.notify = require('mini.notify').make_notify()
    end,
  },
}
