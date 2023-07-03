local server = {}

function server.init(lspconfig, coq, on_attach)
  local pid = vim.fn.getpid()
  local omnisharp_bin = "/usr/bin/omnisharp"
  lspconfig.omnisharp.setup(coq.lsp_ensure_capabilities({
      on_attach = on_attach,
      cmd = { "mono", omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) }
  }))
end

return server
