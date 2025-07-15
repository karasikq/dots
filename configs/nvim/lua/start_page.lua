vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      local buf = vim.api.nvim_create_buf(false, false)
      vim.api.nvim_set_current_buf(buf)
      vim.api.nvim_create_autocmd('BufNew', {
        buffer = buf,
        callback = function()
          vim.schedule(function()
            vim.api.nvim_buf_delete(buf, { force = true })
          end)
        end
      })
      
      local width = vim.api.nvim_win_get_width(0)
      
      local function center_block(lines)
        local width = vim.api.nvim_win_get_width(0)
        local max_len = 0
        
        for _, line in ipairs(lines) do
          max_len = math.max(max_len, #line)
        end
        
        local left_pad = math.floor((width - max_len) / 2)
        
        local centered = {}
        for _, line in ipairs(lines) do
          centered[#centered + 1] = string.rep(' ', left_pad) .. line
        end
        
        return centered
      end 

      local lines = center_block({
        "       Hello 🍄🍄🍄     ",
        "",
        "<Leader> is *Space*",
        "Quick Actions:",
        "<Leader>ff - Find files",
        "<Leader>fk - Find keymaps",
        "",
        "Basic Commands:",
        ":e <file>    - Edit file",
        ":q           - Quit",
        "",
        "Config: " .. vim.fn.stdpath("config"),
        "Version: " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch,
      })
      
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      
      vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
      vim.api.nvim_buf_set_option(buf, "swapfile", false)
      vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
      vim.api.nvim_buf_set_option(buf, "modifiable", false)
      
      local opts = { noremap = true, silent = true, buffer = buf }
      vim.keymap.set("n", "q", ":q<CR>", opts)
      vim.keymap.set("n", "<ESC>", ":q<CR>", opts)
    end
  end
})
