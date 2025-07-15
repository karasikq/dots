vim.o.termguicolors = true
vim.o.number = true
vim.o.ruler = true
vim.o.mouse = 'a'
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.laststatus = 2
vim.opt.background = "dark"
vim.opt.updatetime = 1000

require("keymappings").setup()
