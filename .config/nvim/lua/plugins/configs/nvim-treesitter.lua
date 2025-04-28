require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "rust", "javascript", "c_sharp", "markdown", "markdown_inline", "python", "toml", "go" },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
}
