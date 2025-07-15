------------------------------------------------------------
-- PLUGIN INITIALIZATION
-- Load and configure all Neovim plugins in one place
------------------------------------------------------------

-- UI Enhancements
------------------------------------------------------------
-- Code outline sidebar (Aerial)
require("aerial").setup()

-- Onedark colorscheme
require('onedark').setup  {
    style = 'warmer',
    transparent = false,
    term_colors = true,
    ending_tildes = false,
    toggle_style_key = '<leader>ts',
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'},
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },
    colors = {},
    highlights = {},
    diagnostics = {
        darker = true,
        undercurl = true,
        background = true,
    },
}
require('onedark').load()
vim.cmd "colorscheme onedark"

-- Minimal UI utilities (mini.nvim)
local files_config = {
  windows = {
    preview = true,
    width_preview = 100,
  },
}
require('mini.files').setup(files_config)
require('mini.completion').setup()

-- LSP & Treesitter
------------------------------------------------------------
-- LSP config
local on_attach = function(client, bufnr)
  require "keymappings".on_lsp_attach(client, bufnr)
  require "lsp_signature".on_attach(require('plugins.configs.lsp_signature').get_config(), bufnr)
end

-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "rust", "javascript", "c_sharp", "markdown", "markdown_inline", "python", "toml", "go" },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
}

-- Rust tools and LSP
vim.g.rustaceanvim = {
  server = {
    on_attach = function(client, bufnr)
      if pcall(require, 'keymappings') then
        require('keymappings').on_lsp_attach(client, bufnr)
      else
        vim.notify("keymappings module not found", vim.log.levels.WARN)
      end
    end,
    settings = {
      ["rust-analyzer"] = {
        signatureInfo = { enable = true },
        assist = {
          importMergeBehavior = "last",
          importPrefix = "by_self",
        },
        diagnostics = {
          disabled = { "unresolved-import" }
        },
        cargo = {
            loadOutDirsFromCheck = true
        },
        procMacro = {
            enable = true
        },
        checkOnSave = {
            command = "clippy"
        },
      }
    }},
  dap = {},
}

-- Navigation & Search
------------------------------------------------------------
-- Fuzzy finder and picker (Telescope)
function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end
local telescope = require('telescope')
local actions = require('telescope.actions')
telescope.setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}

-- Fast navigation (Leap)
require('leap').set_default_mappings()

-- Editing & Productivity
------------------------------------------------------------
-- Commenting utility
require('Comment').setup()

-- Auto-close pairs
require('nvim-autopairs').setup()

-- Keybinding helper
require("which-key").setup({}) 