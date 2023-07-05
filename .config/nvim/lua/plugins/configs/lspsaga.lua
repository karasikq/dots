require("lspsaga").setup({
  lightbulb = {
    enable = false,
    enable_in_insert = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
})

local keymap = vim.keymap.set
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")
keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
keymap("n", "gr", "<cmd>Lspsaga rename<CR>")
keymap("n", "gr", "<cmd>Lspsaga rename ++project<CR>")
keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
keymap("n","gd", "<cmd>Lspsaga goto_definition<CR>")
keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")
keymap("n","gt", "<cmd>Lspsaga goto_type_definition<CR>")
keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")
keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
keymap("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")
keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
keymap("n", "[E", function()
  require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
keymap("n", "]E", function()
  require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end)
keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>")
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")
keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")
keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
keymap({"n", "t"}, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
