return {
  {
    'windwp/nvim-ts-autotag',
    event = 'VeryLazy',
    config = function()
      local autotag = require('nvim-ts-autotag')

      local filetypes = {
        'html',
        'javascript',
        'typescript',
        'javascriptreact',
        'typescriptreact',
        'svelte',
        'vue',
        'tsx',
        'jsx',
        'rescript',
        'xml',
        'php',
        'markdown',
        'glimmer',
        'handlebars',
        'hbs',
      }

      local skip_tags = {
        'area',
        'base',
        'br',
        'col',
        'command',
        'embed',
        'hr',
        'img',
        'slot',
        'input',
        'keygen',
        'link',
        'meta',
        'param',
        'source',
        'track',
        'wbr',
        'menuitem',
      }

      autotag.setup {
        filetypes = filetypes,
        skip_tags = skip_tags,
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
      }
    end,
  },
}
