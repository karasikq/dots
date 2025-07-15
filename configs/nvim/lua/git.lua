local M = {}

function M.blame()
  local line = vim.fn.line('.')
  local file = vim.fn.expand('%:p')
  
  if file == '' then
    vim.notify('No file name', vim.log.levels.WARN)
    return
  end
  
  local cmd = string.format('git blame -L %d,%d --porcelain -- %s', line, line, vim.fn.shellescape(file))
  local handle = io.popen(cmd)
  
  if not handle then
    vim.notify('Failed to run git blame', vim.log.levels.ERROR)
    return
  end
  
  local result = handle:read('*a')
  handle:close()
  
  local commit_hash = result:match('^(%x+)')
  if not commit_hash then
    vim.notify('No git history for this line', vim.log.levels.INFO)
    return
  end
  
  local author = result:match('author (.+)\n')
  local author_time = result:match('author%-time (%d+)\n')
  local summary = result:match('summary (.+)\n')
  
  if author_time then
    author_time = os.date('%Y-%m-%d %H:%M:%S', tonumber(author_time))
  end
  
  local message = string.format(
    'Last change by: %s\nCommit: %s\nDate: %s\nSummary: %s',
    author or 'Unknown',
    commit_hash:sub(1,7),
    author_time or 'Unknown',
    summary or 'No message'
  )
  
  vim.notify(message, vim.log.levels.INFO, {
    title = 'Git Blame',
    timeout = 8000
  })
end

function M.show_line_diff()
  local line = vim.fn.line('.')
  local file = vim.fn.expand('%:p')
  
  if file == '' then
    vim.notify('No file name', vim.log.levels.WARN)
    return
  end

  local cmd = string.format('git blame -L %d,%d --porcelain -- %s', line, line, vim.fn.shellescape(file))
  local handle = io.popen(cmd)
  if not handle then
    vim.notify('Failed to run git blame', vim.log.levels.ERROR)
    return
  end

  local result = handle:read('*a')
  handle:close()
  local commit_hash = result:match('^(%x+)')
  if not commit_hash then
    vim.notify('No git history for this line', vim.log.levels.INFO)
    return
  end

  vim.cmd('vsplit')
  vim.cmd('term git show '..commit_hash..' -- '..vim.fn.shellescape(file))
  
  vim.cmd('startinsert')
  vim.api.nvim_buf_set_keymap(0, 't', '<Esc>', '<C-\\><C-n>:q<CR>', {noremap = true})
end

return M
