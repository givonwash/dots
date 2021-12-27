return function()
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

    -- special hover
    _G.__config__.hover = function()
        local api = vim.api
        local fn = vim.fn

        local ft = api.nvim_buf_get_option(0, 'filetype')

        if ft == 'help' or ft == 'vim' then
            local cword = fn.expand '<cword>'
            api.nvim_command('help ' .. cword)
        elseif ft == 'man' then
            local cword = fn.expand '<cword>'
            api.nvim_command('Man ' .. cword)
        else
            -- vim.cmd 'Lspsaga hover_doc'
            vim.lsp.buf.hover()
        end
    end

    local defaults = {
        on_attach = function()
            local nmap = require('keymaps').mapper('n', nil, true)
            local imap = require('keymaps').mapper('i', nil, true)

            nmap('gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
            nmap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
            imap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
            nmap('ga', '<cmd>lua vim.lsp.buf.code_action()<cr>')
            nmap('gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
            nmap('gr', '<cmd>lua vim.lsp.buf.rename()<cr>')
            nmap('K', '<cmd>call v:lua.__config__.hover()<cr>')

            vim.cmd [[au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
        end,
        capabilities = require('cmp_nvim_lsp').update_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        ),
        handlers = {
            ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = 'rounded',
            }),
            ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = 'rounded',
                close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
            }),
        },
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
                tsserver = {},
            }

            server:setup(vim.tbl_extend('keep', config[server.name], defaults))
        end
    end)
end
