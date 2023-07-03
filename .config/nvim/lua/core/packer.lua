require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'neovim/nvim-lspconfig'
  use 'airblade/vim-gitgutter'
  use 'ryanoasis/vim-devicons'
  use 'nvim-lualine/lualine.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'navarasu/onedark.nvim'
  use 'scrooloose/syntastic' 
  use 'nvim-lua/plenary.nvim'
  use 'tami5/lspsaga.nvim'
  use 'romgrk/barbar.nvim'
  use 'numToStr/Comment.nvim'
  use 'yamatsum/nvim-cursorline'
  use 'windwp/nvim-autopairs'
  use 'ggandor/lightspeed.nvim'
  use { 'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps' }
  use 'goolord/alpha-nvim'
  use { 'ms-jpq/coq_nvim', branch = 'coq' }
  use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'ray-x/lsp_signature.nvim'
  use 'stevearc/aerial.nvim'
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } } 
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable "make" == 1 }
  -- Language tools
  use 'simrat39/rust-tools.nvim'
  use 'cdelledonne/vim-cmake'
end)

