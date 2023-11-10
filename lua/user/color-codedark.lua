vim.o.background = "dark"

vim.cmd([[hi RustInlayHints guifg=#444444]])
require("vscode").setup({
  transparent = true,
})

require("vscode").load()
