local M = {}

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

M.setup = function()
  -- Set <Space> as leader
  vim.g.mapleader = ' '
  local buffers = require("buffers")

  keymap('n', 'm', "<C-w>")
  keymap('n', 'qq', ":q<CR>")
  keymap('n', '<leader>q', ":q<CR>")

  keymap("x", "p", '"_dP', { noremap = true, silent = true })
  keymap("x", "P", '"_dP', { noremap = true, silent = true })
  
  ----- EXIT FROM TERMINAL STATE -----
  keymap('t', '<Esc>', '<C-\\><C-n>')
  keymap('n', '<Esc>', ":noh<CR>")
  
  ----- Open -----
  keymap('n', '<leader>of', function()
    local file_path = vim.api.nvim_buf_get_name(0)
    MiniFiles.open(file_path)
    end, opts, { desc = '[O]pen [F]iles' })
  keymap('n', '<leader>ot', ':terminal<CR>', opts, { desc = '[O]pen [T]erminal' })
  
  ----- Telescope -----
  keymap('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
  keymap('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp' })
  keymap('n', '<leader>fk', require('telescope.builtin').keymaps, { desc = '[F]ind [K]eymaps' })
  keymap('n', '<leader>fa', ':lua require"telescope.builtin".find_files({ hidden = true })<CR>', { desc = '[F]ind [A]ll files (including hidden)' })
  keymap('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind by [G]rep' })
  keymap('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind current [W]ord' })
  keymap('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
  keymap('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[F]ind [B]uffers' })
  
  ----- Diagnostic Keymaps -----
  keymap('n', '<leader>dd', vim.diagnostic.open_float, { desc = '[D]iagnostic [D]etails' })
  keymap('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = '[D]iagnostic [P]revious' })
  keymap('n', '<leader>dn', vim.diagnostic.goto_next, { desc = '[D]iagnostic [N]ext' })
  keymap('n', '<leader>dl', vim.diagnostic.setloclist, { desc = '[D]iagnostic [L]ist' })
  
  -- Severity filtering
  keymap('n', '<leader>dP', function()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, { desc = '[D]iagnostic previous [E]rror' })
  
  keymap('n', '<leader>dN', function()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, { desc = '[D]iagnostic [N]ext Error' })

  -- Buffers
  keymap('n', '<leader>bx', buffers.close_all_but_current, { desc = 'Close all buffers except current' })
  keymap('n', '<leader>bc', buffers.close_buffer_keep_window, { desc = 'Close buffer but keep window' })
  keymap('n', '<leader>bp', buffers.go_to_last_used_buffer, { desc = 'Go to last previous buffer' })
  keymap('n', '<leader>bn', buffers.go_to_next_mru_buffer, { desc = 'Go to next buffer' })
  keymap('n', '<leader>bm', buffers.show_modified_buffers, { desc = 'Show modified buffers' })

  ----- Comment.nvim Mappings -----
  -- Toggle current line (and visual selection)
  keymap('n', '<leader>cc', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', { desc = '[C]omment [C]urrent line' })
  keymap('x', '<leader>cc', '<esc><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = '[C]omment [C]urrent selection' })
  
  -- Toggle block comment (visual mode only)
  keymap('x', '<leader>cb', '<esc><cmd>lua require("Comment.api").toggle.blockwise(vim.fn.visualmode())<CR>', { desc = '[C]omment [B]lock selection' })
  
  -- Insert comment below/above
  keymap('n', '<leader>co', '<cmd>lua require("Comment.api").insert.linewise.below()<CR>', { desc = '[C]omment insert [O]pen below' })
  keymap('n', '<leader>cO', '<cmd>lua require("Comment.api").insert.linewise.above()<CR>', { desc = '[C]omment insert [O]pen above' })
  
  -- Extra: Toggle with count (e.g., 3<leader>cn comments 3 lines)
  keymap('n', '<leader>cn', '<cmd>lua require("Comment.api").toggle.linewise.count(vim.v.count)<CR>', { desc = '[C]omment [N] lines' })
  
  ----- Aerial.nvim Mappings -----
  keymap('n', '<leader>sy', '<cmd>AerialToggle!<CR>', { desc = '[S]ymbol [Y]iew toggle' })
  
  -- Navigation (using 's' prefix for [S]ymbol navigation)
  keymap('n', '<leader>sp', '<cmd>AerialPrev<CR>', { desc = '[S]ymbol [P]revious' })
  keymap('n', '<leader>sn', '<cmd>AerialNext<CR>', { desc = '[S]ymbol [N]ext' })
  keymap('n', '<leader>su', '<cmd>AerialPrevUp<CR>', { desc = '[S]ymbol [U]p (previous)' })
  keymap('n', '<leader>sd', '<cmd>AerialNextUp<CR>', { desc = '[S]ymbol [D]own (next)' })
  
  keymap('n', '<leader>so', '<cmd>AerialOpen<CR>', { desc = '[S]ymbol [O]pen' })
  keymap('n', '<leader>sj', '<cmd>AerialGo<CR>', { desc = '[S]ymbol [J]ump to location' })

  local git = require('git')
  keymap('n', '<leader>gb', git.blame, { desc = 'Show [G]it [B]lame for current line' })
  keymap('n', '<leader>gd', git.show_line_diff, { desc = 'Show [G]it [D]iff for current line change' })
end

----- LSP Keymaps (on_attach) -----
M.on_lsp_attach = function(client, bufnr)
  local keymap = vim.keymap.set
  local opts = { buffer = bufnr, silent = true }

  -- Enable completion
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Navigation
  keymap('n', '<leader>ld', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = '[L]SP [D]efinition' }))
  keymap('n', '<leader>lD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = '[L]SP [D]eclaration' }))
  keymap('n', '<leader>li', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = '[L]SP [I]mplementation' }))
  keymap('n', '<leader>lt', vim.lsp.buf.type_definition, vim.tbl_extend('force', opts, { desc = '[L]SP [T]ype definition' }))

  -- Documentation
  keymap('n', '<leader>lh', function()
    vim.cmd.RustLsp { 'hover', 'actions' }
  end, vim.tbl_extend('force', opts, { desc = '[L]SP Hover Actions' }))
  keymap('n', '<leader>ls', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = '[L]SP [S]ignature help' }))

  -- Workspace
  keymap('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, vim.tbl_extend('force', opts, { desc = '[L]SP [W]orkspace [A]dd' }))
  keymap('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, vim.tbl_extend('force', opts, { desc = '[L]SP [W]orkspace [R]emove' }))
  keymap('n', '<leader>lwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, vim.tbl_extend('force', opts, { desc = '[L]SP [W]orkspace [L]ist' }))

  -- Code actions
  keymap('n', '<leader>la', function()
    vim.cmd.RustLsp('codeAction')
  end, vim.tbl_extend('force', opts, { desc = '[L]SP Code [A]ction' }))
  keymap('v', '<leader>la', function()
    vim.cmd.RustLsp('codeAction')
  end, vim.tbl_extend('force', opts, { desc = '[L]SP Code [A]ction' }))

  -- References and rename
  keymap('n', '<leader>lr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = '[L]SP [R]eferences' }))
  keymap('n', '<leader>lR', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = '[L]SP [R]ename' }))

  -- Formatting
  keymap('n', '<leader>lf', function()
    vim.lsp.buf.format({ async = true })
  end, vim.tbl_extend('force', opts, { desc = '[L]SP [F]ormat' }))

  -- Document highlights
  local highlight_group = vim.api.nvim_create_augroup('LspDocumentHighlight', { clear = false })
  vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = bufnr })
  vim.api.nvim_create_autocmd('CursorHold', {
    group = highlight_group,
    buffer = bufnr,
    callback = vim.lsp.buf.document_highlight,
  })
  vim.api.nvim_create_autocmd('CursorMoved', {
    group = highlight_group,
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })
end

return M
