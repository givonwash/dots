local html = require('lspconfig').html
local capabilities = require('plugins.lspconfig.utils').capabilities
local html_bin = '/usr/bin/vscode-html-languageserver'

html.setup { capabilities = capabilities, cmd = { html_bin, '--stdio' } }
