-- runs after the built-in ftplugin, which sets formatoptions+=t
-- never auto-insert line breaks while typing
vim.opt_local.formatoptions:remove("t")
vim.opt_local.formatoptions:remove("a")
