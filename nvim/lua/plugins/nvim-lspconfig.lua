return function()
    local lsp = require 'lsp'
    local lsp_installer = require 'nvim-lsp-installer'

    local LUA_PATH = (function()
        local path = vim.split(package.path, ';')
        table.insert(path, 'lua/?.lua')
        table.insert(path, 'lua/?/init.lua')
        return path
    end)()

    local LUA_LIBRARIES = (function()
        local libraries = {}

        local function add_library(path)
            for _, p in pairs(vim.fn.expand(path, false, true)) do
                local real_path = vim.loop.fs_realpath(p)
                libraries[real_path] = true
            end
        end

        add_library '$VIMRUNTIME'
        add_library '~/.config/nvim'
        add_library '~/.local/share/nvim/site/pack/packer/start/*'
        return libraries
    end)()

    local defaults = {
        on_attach = lsp.on_attach,
        capabilities = require('cmp_nvim_lsp').update_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        ),
        handlers = lsp.handlers,
    }

    local is_available, rust_analyzer =
        require('nvim-lsp-installer.servers').get_server 'rust_analyzer'

    if is_available then
        require('rust-tools').setup {
            hover_with_actions = false,
            server = vim.tbl_extend('force', rust_analyzer:get_default_options(), defaults),
        }
    end

    lsp_installer.on_server_ready(function(server)
        if server.name ~= 'rust_analyzer' then
            local config = {
                cssls = {},
                eslint = {},
                html = {},
                pyright = {
                    settings = {
                        python = { analysis = { typeCheckingMode = 'strict' } },
                    },
                },
                sumneko_lua = {
                    on_new_config = function(config, root)
                        local libraries = vim.tbl_deep_extend(
                            'force',
                            {},
                            config.settings.Lua.workspace.library
                        )
                        libraries[vim.loop.fs_realpath(root) .. '/lua'] = nil
                        libraries[vim.loop.fs_realpath(root)] = nil
                        config.settings.Lua.workspace.library = libraries
                        return config
                    end,
                    settings = {
                        Lua = {
                            runtime = { version = 'LuaJIT', path = LUA_PATH },
                            diagnostics = { globals = { 'vim' } },
                            workspace = {
                                library = LUA_LIBRARIES,
                                maxPreload = 1000,
                                preloadFileSize = 150,
                            },
                            telemetry = { enable = false },
                        },
                    },
                },
                texlab = {},
                tsserver = {
                    on_attach = function(client)
                        client.resolved_capabilities.document_formatting = false
                        client.resolved_capabilities.document_range_formatting = false
                        lsp.on_attach(client)
                    end,
                },
            }

            server:setup(vim.tbl_extend('keep', config[server.name], defaults))
        end
    end)
end
