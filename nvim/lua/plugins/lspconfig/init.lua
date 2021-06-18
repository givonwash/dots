local lsp = require 'lspconfig'

--[[============================= capabilities ==============================]]
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

--[[================================= lua ===================================]]
local lua = lsp.sumneko_lua

lua.setup(require('plugins.lspconfig.sumneko_lua'))

--[[================================= rust ==================================]]
local rust_analyzer = lsp.rust_analyzer

rust_analyzer.setup { settings = { checkOnSave = { command = 'clippy' } } }

--[[================================ python =================================]]
local pyright = lsp.pyright

pyright.setup {
    settings = { python = { analysis = { typeCheckingMode = 'strict' } } },
}

--[[================================= html ==================================]]
local html = lsp.html
local html_bin = '/usr/bin/vscode-html-languageserver'

html.setup { capabilities = capabilities, cmd = { html_bin, '--stdio' } }

--[[================================= css ===================================]]
local cssls = lsp.cssls

cssls.setup { capabilities = capabilities }

--[[============================== typescript ===============================]]
local tsserver = lsp.tsserver

tsserver.setup {}
