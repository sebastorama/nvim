return {
  {
    'tpope/vim-dadbod',
    ft = { 'sql', 'mysql', 'plsql' },
    config = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.cmd [[
        autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
      ]]
    end,
  },
  { 'kristijanhusak/vim-dadbod-ui', event = 'VeryLazy' },
  { 'kristijanhusak/vim-dadbod-completion', event = 'VeryLazy' },
  { 'vim-scripts/dbext.vim', event = 'VeryLazy' },
}
