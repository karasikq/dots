local M = {}

local mru_buffers = {}
local mru_index = 1

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    mru_buffers = vim.tbl_filter(function(b) return b ~= buf end, mru_buffers)
    table.insert(mru_buffers, 1, buf)
    mru_index = 1
  end,
})

function M.close_all_but_current()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end

function M.close_buffer_keep_window()
  local current_buf = vim.api.nvim_get_current_buf()
  local alt_buf = vim.fn.bufnr('#')

  if alt_buf > 0 and vim.api.nvim_buf_is_loaded(alt_buf) then
    vim.cmd('buffer #')
  else
    vim.cmd('enew')
  end

  vim.api.nvim_buf_delete(current_buf, { force = true })
end

function M.go_to_last_used_buffer()
  local alt = vim.fn.bufnr('#')
  if alt > 0 and vim.api.nvim_buf_is_loaded(alt) then
    vim.cmd('buffer #')
  else
    vim.notify("No previous buffer", vim.log.levels.INFO)
  end
end

function M.go_to_next_mru_buffer()
  if #mru_buffers <= 1 then
    vim.notify("No other buffers", vim.log.levels.INFO)
    return
  end

  mru_index = mru_index + 1
  if mru_index > #mru_buffers then mru_index = 1 end

  local buf = mru_buffers[mru_index]
  if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
    vim.api.nvim_set_current_buf(buf)
  else
    vim.notify("Next MRU buffer is not valid", vim.log.levels.WARN)
  end
end

function M.show_modified_buffers()
  local modified = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf)
      and vim.api.nvim_buf_get_option(buf, 'modified') then
      local name = vim.api.nvim_buf_get_name(buf)
      table.insert(modified, name ~= '' and name or '[No Name]')
    end
  end

  if #modified == 0 then
    vim.notify("No modified buffers", vim.log.levels.INFO)
  else
    vim.notify("Modified buffers:\n- " .. table.concat(modified, "\n- "), vim.log.levels.WARN)
  end
end

return M
