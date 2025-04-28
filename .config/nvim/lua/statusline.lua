local M = {}

local mode_names = {
  ['n'] = 'NORMAL',
  ['v'] = 'VISUAL',
  ['V'] = 'V-LINE',
  [''] = 'V-BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'S-LINE',
  [''] = 'S-BLOCK',
  ['i'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['c'] = 'COMMAND',
  ['r'] = 'PROMPT',
  ['!'] = 'SHELL',
  ['t'] = 'TERM',
}

local colors = {
  normal = '%#StatusLine#',
  mode = '%#StatusLineMode#',
  git = '%#StatusLineGit#',
  error = '%#StatusLineError#',
  warning = '%#StatusLineWarning#',
  signature = '%#StatusLineSignature#',
  signature_fn = '%#StatusLineSignatureFn#',
  signature_args = '%#StatusLineSignatureArgs#',
  file = '%#StatusLineFile#',
  percent = '%#StatusLinePercent#',
  line = '%#StatusLineLine#',
}

local signature_cache = {
  active = false,
  label = '',
  parameters = {},
}

local function update_signature()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  if #clients == 0 then
    signature_cache.active = false
    signature_cache.label = ''
    return
  end

  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, 'textDocument/signatureHelp', params, function(err, result, ctx)
    if err or not result or not result.signatures or #result.signatures == 0 then
      signature_cache.active = false
      signature_cache.label = ''
      M.update_statusline()
      return
    end

    local signature = result.signatures[1]
    if signature then
      signature_cache.active = true
      signature_cache.label = signature.label
      signature_cache.parameters = signature.parameters or {}
      M.update_statusline()
    end
  end)
end

local components = {
  mode = function()
    local mode = mode_names[vim.fn.mode()] or 'UNKNOWN'
    return colors.mode .. '[ ' .. mode .. ' ]' .. colors.normal
  end,

  git = function()
    if not vim.b.gitsigns_head then return '' end
    local status = vim.b.gitsigns_status_dict or {}
    local changes = ''
    
    if status.added and status.added > 0 then
      changes = changes .. '+' .. status.added .. ' '
    end
    if status.changed and status.changed > 0 then
      changes = changes .. '~' .. status.changed .. ' '
    end
    if status.removed and status.removed > 0 then
      changes = changes .. '-' .. status.removed .. ' '
    end
    
    if changes ~= '' then
      changes = ' ' .. changes:sub(1, -2)
    end
    
    return colors.git .. '[ ' .. (status.head or '') .. changes .. ' ]' .. colors.normal
  end,

  diagnostics = function()
    local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    
    local result = ''
    if errors > 0 then
      result = colors.error .. '[ E:' .. errors .. ' ]' .. colors.normal
    end
    if warnings > 0 then
      result = result .. colors.warning .. '[ W:' .. warnings .. ' ]' .. colors.normal
    end
    
    return result
  end,

  signature = function()
    if not signature_cache.active or signature_cache.label == '' then return '' end
    
    local fn, args = signature_cache.label:match('^([^(]+)(.*)$')
    if not fn then return '' end
    
    fn = fn:gsub('%s+$', '')
    
    return colors.signature .. '[ ' .. 
           colors.signature_fn .. fn .. colors.signature .. 
           colors.signature_args .. args .. colors.signature .. ' ]' .. colors.normal
  end,

  filepath = function()
    local fname = vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.')
    if fname == '' then return '' end
    return colors.file .. '[ ' .. fname .. ' ]' .. colors.normal
  end,

  percent = function()
    local line = vim.fn.line('.')
    local total = vim.fn.line('$')
    if total == 1 then return '' end
    local percent = math.floor((line * 100) / total)
    return colors.percent .. '[ ' .. percent .. '%% ]' .. colors.normal
  end,

  lines = function()
    local line = vim.fn.line('.')
    local total = vim.fn.line('$')
    return colors.line .. '[ ' .. line .. '/' .. total .. ' ]' .. colors.normal
  end,
}

function M.update_statusline()
  local left = table.concat({
    components.mode(),
    components.git(),
    components.diagnostics(),
    components.signature(),
  })
  
  local right = table.concat({
    components.filepath(),
    components.percent(),
    components.lines(),
  })
  
  vim.opt.statusline = left .. '%=' .. right
end

function M.setup()
  local group = vim.api.nvim_create_augroup('CustomStatusline', { clear = true })
  
  vim.api.nvim_create_autocmd({ 'ModeChanged', 'BufEnter', 'CursorMoved', 'CursorMovedI' }, {
    group = group,
    callback = function()
      
      update_signature()
      M.update_statusline()
    end,
  })

  vim.api.nvim_create_autocmd('User', {
    pattern = 'GitSignsUpdate',
    group = group,
    callback = M.update_statusline,
  })

  M.update_statusline()
end

return M
