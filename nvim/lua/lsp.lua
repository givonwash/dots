local lsp = require 'lspconfig'
local fn = vim.fn

--[[================================= lua ===================================]]
local lua = lsp.sumneko_lua
local lua_ls_bin  = '/usr/bin/lua-language-server'
local lua_ls_main = '/usr/share/lua-language-server/main.lua'

lua.setup {
    cmd = { lua_ls_bin, '-E', lua_ls_main},
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = {
                    [fn.expand('$VIMRUNTIME/lua')] = true,
                    [fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                }
            },
            telemetry = {
                enable = false,
            }
        }
    }
}

--[[================================= rust ==================================]]
-- local rust_analyzer = lsp.rust_analyzer

-- rust_analyzer.setup()

--[[================================= html ==================================]]
local html = lsp.html
local html_bin = '/usr/bin/vscode-html-languageserver'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

html.setup {
    capabilities = capabilities,
    cmd = { html_bin, '--stdio' },
}

