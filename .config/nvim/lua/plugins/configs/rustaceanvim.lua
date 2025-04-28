vim.g.rustaceanvim = {
  server = coq.lsp_ensure_capabilities({
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
    }}),
  dap = {
  },
}
