local rust_opts = {
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = true,
      show_parameter_hints = true,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },
  server = {
    standalone = true,
  },
}

require("rust-tools").setup(rust_opts)

local server = {}

function server.init(lspconfig, coq, on_attach)
  lspconfig.rust_analyzer.setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
    settings = {
      ["rust-analyzer"] = {
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
    }})) 
end

return server
