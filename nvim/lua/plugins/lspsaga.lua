return function()
    local api = vim.api
    local fn = vim.fn
    local nmap = require('keymaps').nmap
    local vmap = require('keymaps').vmap

    nmap('ga', '<cmd>lua require("lspsaga.codeaction").code_action()<cr>')
    vmap('ga', '<cmd>lua require("lspsaga.codeaction").code_action()<cr>')
    nmap('gs', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<cr>')
    nmap('gr', '<cmd>lua require("lspsaga.rename").rename()<cr>')
    nmap('gD', '<cmd>lua require("lspsaga.provider").preview_definition()<cr>')
    nmap('gl',
         '<cmd>lua require("lspsaga.diagnostic").show_line_diagnostics()<cr>')
    nmap('gc',
         '<cmd>lua require("lspsaga.diagnostic").show_cursor_diagnostics()<cr>')
    nmap('gJ',
         '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<cr>')
    nmap('gK',
         '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<cr>')
    nmap('<C-f>',
         '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<cr>')
    nmap('<C-b>',
         '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<cr>')

    local my_globals = _G.my_globals

    my_globals.on_hover = function()
        local ft = api.nvim_buf_get_option(0, 'filetype')
        if ft == 'help' or ft == 'vim' then
            local cword = fn.expand('<cword>')
            api.nvim_command('help ' .. cword)
        elseif ft == 'man' then
            local cword = fn.expand('<cword>')
            api.nvim_command('Man ' .. cword)
        else
            require('lspsaga.hover').render_hover_doc()
        end
    end

    nmap('K', '<cmd>call v:lua.my_globals.on_hover()<cr>')

    require('lspsaga').init_lsp_saga {
        use_saga_diagnostic_sign = true,
        error_sign = '',
        warn_sign = '',
        hint_sign = '',
        infor_sign = '',
        dianostic_header_icon = '   ',
        code_action_icon = ' ',
        code_action_prompt = {
            enable = true,
            sign = true,
            sign_priority = 20,
            virtual_text = true,
        },
        max_preview_lines = 10,
        code_action_keys = { quit = '<esc>', exec = '<cr>' },
        rename_action_keys = { quit = '<esc>', exec = '<cr>' },
        definition_preview_icon = '  ',
        border_style = "single",
        rename_prompt_prefix = '➤',
    }
end
