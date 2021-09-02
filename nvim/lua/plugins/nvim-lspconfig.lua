return function()
    local lspinstall = require('lspinstall')
    local servers = lspinstall.installed_servers()

    local LUA_PATH = require('utils').LUA_PATH
    local LUA_LIBRARIES = require('utils').LUA_LIBRARIES

    local lsp_opts = {
        css = {},
        html = {},
        python = {
            settings = { python = { analysis = { typeCheckingMode = 'strict' } } },
        },
        rust = { settings = { checkOnSave = { command = 'clippy' } } },
        lua = {
            on_new_config = function(config, root)
                local libraries =
                    vim.tbl_deep_extend("force", {}, LUA_LIBRARIES)
                libraries[root] = nil
                config.settings.Lua.workspace.library = libraries
                return config
            end,
            settings = {
                Lua = {
                    runtime = { version = 'LuaJIT', path = LUA_PATH },
                    diagnostics = { globals = { 'vim' } },
                    workspace = {
                        library = LUA_LIBRARIES,
                        maxPreload = 2000,
                        preloadFileSize = 50000,
                    },
                    telemetry = { enable = false },
                },
            },
        },
        typescript = {},
    }

    local lspconfig = require 'lspconfig'
    local coq_lsp = require('coq').lsp_ensure_capabilities

    lspinstall.setup()
    for _, server in pairs(servers) do
        lspconfig[server].setup(coq_lsp(lsp_opts[server] or {}))
    end
end
