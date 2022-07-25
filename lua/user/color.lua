vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.g.tokyonight_day_brightness = 0.1
vim.g.tokyonight_transparent = true

vim.cmd([[set bg=dark]])
-- require("colorbuddy").colorscheme("gruvbuddy")
vim.cmd([[colorscheme tokyonight]])
vim.cmd([[hi Comment guifg=#6874A9]])
vim.cmd([[hi LineNr guifg=#4d4f5d]])
