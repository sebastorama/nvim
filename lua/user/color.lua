vim.g.tokyonight_style = "storm"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.g.tokyonight_day_brightness = 0.1
vim.g.tokyonight_transparent = false
vim.g.tokyonight_colors = { border = "yellow" }

vim.cmd([[set bg=dark]])
-- require("colorbuddy").colorscheme("gruvbuddy")
vim.cmd([[colorscheme codedark]])
-- vim.cmd([[hi Comment guifg=#6874A9]])
vim.cmd([[hi LineNr guifg=#cccccc]])
vim.cmd([[hi Substitute guibg=#ffaaaa guifg=#666666]])
