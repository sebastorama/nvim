local cat_ok, catppuccin = pcall(require, "catppuccin")

if not cat_ok then
  return
end

vim.o.background = "light"

catppuccin.setup({
  flavour = "latte", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false,
  show_end_of_buffer = false, -- show the '~' characters after the end of buffers
  term_colors = false,
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  no_italic = false, -- Force no italic
  no_bold = false, -- Force no bold
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  color_overrides = {
    all = {
      text = "#000000",
      base = "#FFFFFF",
      lavender = "#3F56D4",
      peach = "#D7621E",
    },
  },
  custom_highlights = function()
    return {
      Comment = { fg = "#999999" },
      ["@comment"] = { fg = "#999999" },
    }
  end,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    telescope = true,
    notify = false,
    mini = false,
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
})

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")

vim.cmd([[hi LspReferenceText guibg=#F3F3AA]])
vim.cmd([[hi LspReferenceRead guibg=#F3F3AA]])
vim.cmd([[hi LspReferenceWrite guibg=#F3F3AA]])
vim.cmd([[hi DiffviewFilePanelFileName guifg=#000000]])
vim.cmd([[hi DiffviewFilePanelTitle guifg=#333333]])
vim.cmd([[hi DiffviewFilePanelCounter guifg=#333333]])
vim.cmd([[hi NeogitHunkHeader guibg=NONE]])
vim.cmd([[hi NeogitHunkHeaderHighlight guibg=NONE]])
vim.cmd([[hi NeogitDiffContextHighlight guibg=#F5F5F5]])

local ib_ok, indent_blankline = pcall(require, "indent_blankline")

vim.cmd([[hi IndentBlanklineIndent1 guibg=#FFFFFF guifg=#F3F3FA gui=nocombine]])
vim.cmd([[hi NonText guibg=#FFFFFF guifg=#DDDDDD]])

indent_blankline.setup({
  show_end_of_line = false,
  show_current_context = false,
  show_current_context_start = false,
  char_highlight_list = {
    "IndentBlanklineIndent1",
  },
  space_char_highlight_list = {
    "IndentBlanklineIndent1",
  },
})

if not ib_ok then
  return
end
