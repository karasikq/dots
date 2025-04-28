require('lazy').setup({
  {
    "folke/which-key.nvim",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  'neovim/nvim-lspconfig',
  "ray-x/lsp_signature.nvim",
  'lewis6991/gitsigns.nvim',
  'nvim-lualine/lualine.nvim',
  'nvim-tree/nvim-web-devicons',
  'navarasu/onedark.nvim',
  'mfussenegger/nvim-lint',
  'nvim-lua/plenary.nvim',
  'nvimdev/lspsaga.nvim',
  'stevearc/aerial.nvim',
  'romgrk/barbar.nvim',
  'numToStr/Comment.nvim',
  'yamatsum/nvim-cursorline',
  'windwp/nvim-autopairs',
  'ggandor/leap.nvim',
  { 'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps' },
  { 'ms-jpq/coq_nvim', branch = 'coq' },
  { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
  'mfussenegger/nvim-dap',
  'rcarriga/nvim-dap-ui',
  { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } },
  { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable "make" == 1 },
  'mrcjkb/rustaceanvim',
})
