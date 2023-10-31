local server = {}

function server.init(lspconfig, coq, on_attach)
  lspconfig.tsserver.setup(coq.lsp_ensure_capabilities({
      on_attach = on_attach
  }))
end

return server
