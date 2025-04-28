local M = {}

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

M.setup = function()
  -- Set <Space> as leader
  vim.g.mapleader = ' '

  keymap('n', 'm', "<C-w>")
  keymap('n', 'qq', ":q<CR>")
  keymap('n', '<leader>q', ":q<CR>")
  
  ----- EXIT FROM TERMINAL STATE -----
  keymap('t', '<Esc>', '<C-\\><C-n>')
  keymap('n', '<Esc>', ":noh<CR>")
  
  ----- Open -----
  keymap('n', '<leader>of', ':CHADopen<CR>', opts, { desc = '[O]pen [F]iles' })
  keymap('n', '<leader>ot', ':terminal<CR>', opts, { desc = '[O]pen [T]erminal' })
  
  ----- Telescope -----
  keymap('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
  keymap('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp' })
  keymap('n', '<leader>fk', require('telescope.builtin').keymaps, { desc = '[F]ind [K]eymaps' })
  keymap('n', '<leader>fa', ':lua require"telescope.builtin".find_files({ hidden = true })<CR>', { desc = '[F]ind [A]ll files (including hidden)' })
  keymap('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind by [G]rep' })
  keymap('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind current [W]ord' })
  keymap('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
  
  
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

  ----- Barbar (Buffer Management) -----
  -- Navigation
  keymap('n', '<leader>bp', ':BufferPrevious<CR>', opts, { desc = '[B]uffer [P]revious' })
  keymap('n', '<leader>bn', ':BufferNext<CR>', opts, { desc = '[B]uffer [N]ext' })
  keymap('n', '<leader>bmn', ':BufferMoveNext<CR>', opts, { desc = '[B]uffer [M]ove [N]ext' })
  keymap('n', '<leader>bmp', ':BufferMovePrevious<CR>', opts, { desc = '[B]uffer [M]ove [P]revious' })
  
  -- Go to buffer by number
  for i = 1, 9 do
    keymap('n', '<leader>b' .. i, ':BufferGoto ' .. i .. '<CR>', opts, { desc = '[B]uffer ' .. i })
  end
  keymap('n', '<leader>b0', ':BufferLast<CR>', opts, { desc = '[B]uffer 0 (Last)' })
  
  -- Close buffers
  keymap('n', '<leader>bc', ':BufferClose<CR>', opts, { desc = '[B]uffer [C]lose' })
  keymap('n', '<leader>bC', ':BufferCloseAllButCurrent<CR>', opts, { desc = '[B]uffer [C]lose Others' })
  
  -- Sorting
  keymap('n', '<leader>bb', ':BufferOrderByBufferNumber<CR>', opts, { desc = '[B]uffer Order by [B]uffer Number' })
  keymap('n', '<leader>bd', ':BufferOrderByDirectory<CR>', opts, { desc = '[B]uffer Order by [D]irectory' })
  keymap('n', '<leader>bl', ':BufferOrderByLanguage<CR>', opts, { desc = '[B]uffer Order by [L]anguage' })
  
  -- Pick buffer
  keymap('n', '<leader>bf', ':BufferPick<CR>', opts, { desc = '[B]uffer [F]uzzy Pick' })
  
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
  
  -- Bonus: Open and jump (if needed)
  keymap('n', '<leader>so', '<cmd>AerialOpen<CR>', { desc = '[S]ymbol [O]pen' })
  keymap('n', '<leader>sj', '<cmd>AerialGo<CR>', { desc = '[S]ymbol [J]ump to location' })
end

----- LSP Keymaps (on_attach) -----
M.on_lsp_attach = function(client, bufnr)
  print("lsp attached")
  -- Enable completion
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Navigation
  keymap('n', '<leader>ld', vim.lsp.buf.definition, { buffer = bufnr, desc = '[L]SP [D]efinition' })
  keymap('n', '<leader>lD', vim.lsp.buf.declaration, { buffer = bufnr, desc = '[L]SP [D]eclaration' })
  keymap('n', '<leader>li', vim.lsp.buf.implementation, { buffer = bufnr, desc = '[L]SP [I]mplementation' })
  keymap('n', '<leader>lt', vim.lsp.buf.type_definition, { buffer = bufnr, desc = '[L]SP [T]ype definition' })

  -- Documentation
  keymap('n', '<leader>lh', vim.lsp.buf.hover, { buffer = bufnr, desc = '[L]SP [H]over' })
  keymap('n', '<leader>ls', vim.lsp.buf.signature_help, { buffer = bufnr, desc = '[L]SP [S]ignature help' })

  -- Workspace
  keymap('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc = '[L]SP [W]orkspace [A]dd' })
  keymap('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, desc = '[L]SP [W]orkspace [R]emove' })
  keymap('n', '<leader>lwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { buffer = bufnr, desc = '[L]SP [W]orkspace [L]ist' })

  -- Code actions
  keymap('n', '<leader>la', vim.lsp.buf.code_action, { buffer = bufnr, desc = '[L]SP Code [A]ction' })
  keymap('v', '<leader>la', vim.lsp.buf.code_action, { buffer = bufnr, desc = '[L]SP Code [A]ction' })

  -- References
  keymap('n', '<leader>lr', vim.lsp.buf.references, { buffer = bufnr, desc = '[L]SP [R]eferences' })
  keymap('n', '<leader>lR', vim.lsp.buf.rename, { buffer = bufnr, desc = '[L]SP [R]ename' })

  -- Formatting
  keymap('n', '<leader>lf', function()
    vim.lsp.buf.format({ async = true })
  end, { buffer = bufnr, desc = '[L]SP [F]ormat' })

  -- Inlay hints (if supported)
  if client.supports_method('textDocument/inlayHint') then
    keymap('n', '<leader>lh', function()
      local current = vim.lsp.inlay_hint.is_enabled(bufnr)
      vim.lsp.inlay_hint.enable(bufnr, not current)
    end, { buffer = bufnr, desc = '[L]SP toggle [H]ints' })
  end

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
