local saga = require 'lspsaga'
saga.init_lsp_saga()

local action = require("lspsaga.codeaction")
vim.keymap.set("n", "ca", action.code_action, { silent = true })
vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })
