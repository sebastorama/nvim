local cat_ok, catppuccin = pcall(require, "catppuccin")

if not cat_ok then
  return
end

vim.o.background = "dark"
vim.cmd([[color catppuccin-frappe]])
