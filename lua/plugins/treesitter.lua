return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup({
        install_dir = vim.fn.stdpath('data') .. '/site',
      })

      local parsers = {
        'bash', 'c', 'comment', 'cpp', 'css', 'diff', 'dockerfile',
        'go', 'gomod', 'gosum', 'gowork', 'graphql', 'html', 'javascript',
        'jsdoc', 'json', 'jsonc', 'lua', 'luadoc', 'luap', 'make',
        'markdown', 'markdown_inline', 'python', 'query', 'regex', 'rust',
        'scss', 'sql', 'toml', 'tsx', 'typescript', 'vim', 'vimdoc', 'yaml',
      }
      require('nvim-treesitter').install(parsers)

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(ev)
          local ft = ev.match
          local lang = vim.treesitter.language.get_lang(ft)
          if lang and vim.treesitter.language.add(lang) then
            pcall(vim.treesitter.start, ev.buf, lang)
            if ft ~= 'yaml' then
              vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
          end
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufRead',
    config = function()
      require('treesitter-context').setup({
        enable = true,
        max_lines = 0,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 3,
        trim_scope = 'outer',
        mode = 'cursor',
        separator = nil,
        zindex = 20,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    event = 'BufRead',
    config = function()
      local select = function(query)
        return function()
          require('nvim-treesitter-textobjects.select').select_textobject(query, 'textobjects')
        end
      end
      vim.keymap.set({ 'x', 'o' }, 'af', select('@function.outer'), { desc = 'Select outer function' })
      vim.keymap.set({ 'x', 'o' }, 'if', select('@function.inner'), { desc = 'Select inner function' })
      vim.keymap.set({ 'x', 'o' }, 'ac', select('@class.outer'), { desc = 'Select outer class' })
      vim.keymap.set({ 'x', 'o' }, 'ic', select('@class.inner'), { desc = 'Select inner class' })
      vim.keymap.set({ 'x', 'o' }, 'as', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@local.scope', 'locals')
      end, { desc = 'Select language scope' })
    end,
  },
}
