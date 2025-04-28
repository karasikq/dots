-- Custom Neovim Statusline in Lua (plugin-free version with updated LSP API)

-- Helper functions
local M = {}

-- Mode names cache
local mode_names = {
  ['n'] = 'NORMAL',
  ['no'] = 'OP-PENDING',
  ['nov'] = 'OP-PENDING',
  ['noV'] = 'OP-PENDING',
  ['no'] = 'OP-PENDING',
  ['niI'] = 'NORMAL',
  ['niR'] = 'NORMAL',
  ['niV'] = 'NORMAL',
  ['nt'] = 'NORMAL',
  ['v'] = 'VISUAL',
  ['vs'] = 'VISUAL',
  ['V'] = 'V-LINE',
  ['Vs'] = 'V-LINE',
  [''] = 'V-BLOCK',
  ['s'] = 'V-BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'SELECT',
  [''] = 'SELECT',
  ['i'] = 'INSERT',
  ['ic'] = 'INSERT',
  ['ix'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['Rc'] = 'REPLACE',
  ['Rx'] = 'REPLACE',
  ['Rv'] = 'V-REPLACE',
  ['Rvc'] = 'V-REPLACE',
  ['Rvx'] = 'V-REPLACE',
  ['c'] = 'COMMAND',
  ['cv'] = 'COMMAND',
  ['ce'] = 'COMMAND',
  ['r'] = 'PROMPT',
  ['rm'] = 'MORE',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL',
}

-- Color definitions
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
  lines = '%#StatusLineLines#',
}

-- Setup highlight groups
local function setup_highlight_groups()
  vim.cmd([[
    " Mode highlight
    hi StatusLineMode guibg=#5f87af guifg=#ffffff gui=bold
    
    " Git highlight
    hi StatusLineGit guibg=#5f875f guifg=#ffffff
    
    " Error/Warning highlights
    hi StatusLineError guibg=#ff0000 guifg=#ffffff
    hi StatusLineWarning guibg=#ffaf00 guifg=#000000
    
    " Signature highlights
    hi StatusLineSignature guibg=#5f5f87 guifg=#ffffff
    hi StatusLineSignatureFn guibg=#5f5f87 guifg=#ffff00 gui=bold
    hi StatusLineSignatureArgs guibg=#5f5f87 guifg=#87ffff
    
    " Right side highlights
    hi StatusLineFile guibg=#444444 guifg=#ffffff
    hi StatusLinePercent guibg=#5f87af guifg=#ffffff
    hi StatusLineLines guibg=#5f875f guifg=#ffffff
    
    " Default statusline background
    hi StatusLine guibg=#303030 guifg=#ffffff
  ]])
end

-- Get current mode
local function get_mode()
  local mode = vim.api.nvim_get_mode().mode
  return mode_names[mode] or mode:upper()
end

-- Get git branch (plugin-free version)
local function get_git_info()
  -- First try using built-in :Git command (if available)
  local branch = vim.fn.trim(vim.fn.system('git branch --show-current 2>/dev/null'))
  if branch == '' or vim.v.shell_error ~= 0 then
    -- Fallback to checking .git/HEAD file directly
    local git_head = vim.fn.finddir('.git', '.;' .. vim.fn.expand('~')) .. '/HEAD'
    if git_head ~= '/HEAD' and vim.fn.filereadable(git_head) == 1 then
      local head = vim.fn.readfile(git_head)[1]
      if head then
        branch = head:match('ref: refs/heads/(.+)$') or ''
      end
    end
  end
  
  if branch == '' then return '' end
  
  -- Get git changes (simplified version without plugin)
  local changes = ''
  local added = tonumber(vim.fn.system('git diff --numstat | wc -l')) or 0
  if added > 0 then
    changes = string.format(' [+%d]', added)
  end
  
  return string.format(' %s%s ', branch, changes)
end

-- Get LSP diagnostics (updated for new LSP API)
local function get_diagnostics()
  if not vim.diagnostic then return '', '' end
  
  local bufnr = vim.api.nvim_get_current_buf()
  local diagnostics = vim.diagnostic.get(bufnr)
  if not diagnostics or #diagnostics == 0 then return '', '' end
  
  local errors = 0
  local warnings = 0
  
  for _, d in ipairs(diagnostics) do
    if d.severity == vim.diagnostic.severity.ERROR then
      errors = errors + 1
    elseif d.severity == vim.diagnostic.severity.WARN then
      warnings = warnings + 1
    end
  end
  
  local error_str = errors > 0 and string.format(' E:%d ', errors) or ''
  local warning_str = warnings > 0 and string.format(' W:%d ', warnings) or ''
  
  return error_str, warning_str
end

-- Get LSP signature help (updated for new LSP API)
local function get_signature_help()
  if not vim.lsp.buf.signature_help then return '' end
  
  local ok, signature_help = pcall(vim.lsp.buf.signature_help)
  if not ok or not signature_help or not signature_help.signatureHelp then return '' end
  
  local active_signature = signature_help.signatureHelp.activeSignature or 0
  if active_signature < 0 then return '' end
  
  local signatures = signature_help.signatureHelp.signatures
  if not signatures or #signatures == 0 then return '' end
  
  local signature = signatures[active_signature + 1]
  if not signature.label then return '' end
  
  -- Simple parsing
  local label = signature.label
  local fn_name_end = label:find('(')
  if not fn_name_end then return colors.signature .. ' ' .. label .. ' ' end
  
  local fn_name = label:sub(1, fn_name_end - 1)
  local args = label:sub(fn_name_end)
  
  return string.format('%s %s%s%s%s%s ',
    colors.signature,
    colors.signature_fn, fn_name, colors.signature,
    colors.signature_args, args
  )
end

-- Get file path information
local function get_file_info()
  local file = vim.fn.expand('%:p:~:.')
  if file == '' then return '' end
  
  local modified = vim.bo.modified and ' [+]' or ''
  local readonly = vim.bo.readonly and ' [RO]' or ''
  
  return string.format(' %s%s%s ', file, modified, readonly)
end

-- Get line information
local function get_line_info()
  local line = vim.fn.line('.')
  local total = vim.fn.line('$')
  local percent = math.floor((line / total) * 100)
  
  return string.format(' %d%%%%  %d/%d ', percent, line, total)
end

-- Main statusline function
function M.setup()
  setup_highlight_groups()
  
  vim.o.statusline = '%!v:lua.require\'statusline\'.statusline()'
end

function M.statusline()
  -- Left side components
  local mode = colors.mode .. ' ' .. get_mode() .. ' ' .. colors.normal
  local git = get_git_info()
  if git ~= '' then git = colors.git .. git .. colors.normal end
  
  local errors, warnings = get_diagnostics()
  if errors ~= '' then errors = colors.error .. errors .. colors.normal end
  if warnings ~= '' then warnings = colors.warning .. warnings .. colors.normal end
  
  local signature = get_signature_help()
  
  -- Right side components
  local file = colors.file .. get_file_info()
  local lines = colors.lines .. get_line_info()
  local percent = colors.percent
  
  -- Combine all components
  return table.concat({
    mode, git, errors, warnings, signature,
    '%=', -- Right/left separator
    file, percent, lines
  })
end

return M
