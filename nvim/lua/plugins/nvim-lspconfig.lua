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

        add_library('$VIMRUNTIME')
        add_library('~/.config/nvim')
        add_library("~/.local/share/nvim/site/pack/packer/start/*")
        return libraries
    end)()

    require('lspsaga').init_lsp_saga {
        code_action_keys = { quit = '<esc>', exec = '<cr>' },
        rename_action_keys = { quit = '<esc>', exec = '<cr>' },
    }

    -- special hover
    _G.__config__.hover = function()
        local api = vim.api
        local fn = vim.fn

        local ft = api.nvim_buf_get_option(0, 'filetype')

        if ft == 'help' or ft == 'vim' then
            local cword = fn.expand('<cword>')
            api.nvim_command('help ' .. cword)
        elseif ft == 'man' then
            local cword = fn.expand('<cword>')
            api.nvim_command('Man ' .. cword)
        else
            vim.cmd 'Lspsaga hover_doc'
        end
    end

    local defaults = {
        on_attach = function()
            local nmap = require('keymaps').mapper('n', nil, true)

            nmap('gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
            nmap('ga',
                 '<cmd>lua require("lspsaga.codeaction").code_action()<cr>')
            nmap('gs',
                 '<cmd>lua require("lspsaga.signaturehelp").signature_help()<cr>')
            nmap('gr', '<cmd>lua require("lspsaga.rename").rename()<cr>')
            nmap('gD',
                 '<cmd>lua require("lspsaga.provider").preview_definition()<cr>')
            nmap('gR', '<cmd>lua require("lspsaga.provider").lsp_finder()<cr>')
            nmap('gJ',
                 '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<cr>')
            nmap('gK',
                 '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<cr>')
            nmap('<C-f>',
                 '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<cr>')
            nmap('<C-b>',
                 '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<cr>')

            nmap('K', '<cmd>call v:lua.__config__.hover()<cr>')

            vim.cmd [[au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
        end,
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                       .protocol
                                                                       .make_client_capabilities()),
    }

    lsp_installer.on_server_ready(function(server)
        if server.name == 'rust_analyzer' then
            require('rust-tools').setup {
                hover_with_actions = false,
                server = defaults,
            }
        else
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
                        local libraries =
                            vim.tbl_deep_extend('force', {}, config.settings.Lua
                                                    .workspace.library)
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

            vim.cmd [[ do User LspAttachBuffers ]]
        end
    end)
end
