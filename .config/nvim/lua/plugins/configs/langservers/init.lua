local langservers = {}

function langservers.init(on_attach)
  require('plugins.configs.langservers.clangd').init(require('lspconfig'), require('coq'), on_attach)
  require('plugins.configs.langservers.rust').init(require('lspconfig'), require('coq'), on_attach)
  require('plugins.configs.langservers.omnisharp').init(require('lspconfig'), require('coq'), on_attach)
end

return langservers
