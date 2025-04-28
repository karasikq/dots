local on_attach = function(client, bufnr)
  require "keymappings".on_lsp_attach(client, bufnr)
  require "lsp_signature".on_attach(require('plugins.configs.lsp_signature').get_config(), bufnr)
end

require('plugins.configs.langservers').init(on_attach)
