local cssls = require('lspconfig').cssls
local capabilities = require('plugins.lspconfig.utils').capabilities

cssls.setup { capabilities = capabilities }
