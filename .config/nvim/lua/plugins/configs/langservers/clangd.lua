local server = {}

function server.init(lspconfig, coq, on_attach)
  lspconfig.clangd.setup(coq.lsp_ensure_capabilities({ default_config = { 
          capabilities = capabilities; 
          cmd = { "clangd", "--background-index", "--pch-storage=memory", "--clang-tidy", "--suggest-missing-includes", "--cross-file-rename" }, 
          filetypes = {"c", "cpp", "tpp", "h", "hpp", "objc", "objcpp"}, 
          init_options = { clangdFileStatus = true, usePlaceholders = true, completeUnimported = true, semanticHighlighting = true }, 
          root_dir = require'lspconfig'.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", "CMakeLists.txt") }, 
          on_attach = on_attach 
}))
end

return server
