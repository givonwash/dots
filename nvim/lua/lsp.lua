local fn = vim.fn

_G.__config__.hover = function()
    local api = vim.api
    local ft = api.nvim_buf_get_option(0, 'filetype')

    if ft == 'help' or ft == 'vim' then
        local cword = fn.expand '<cword>'
        api.nvim_command('help ' .. cword)
    elseif ft == 'man' then
        local cword = fn.expand '<cword>'
        api.nvim_command('Man ' .. cword)
    else
        vim.lsp.buf.hover()
    end
end

fn.sign_define {
    { name = 'DiagnosticSignError', text = '', numhl = 'LspDiagnosticsError' },
    { name = 'DiagnosticSignWarn', text = '', numhl = 'LspDiagnosticsWarning' },
    { name = 'DiagnosticSignInfo', text = '', numhl = 'LspDiagnosticsInformation' },
    { name = 'DiagnosticSignHint', text = '', numhl = 'LspDiagnosticsHint' },
}

return {
    on_attach = function(client)
        local nmap = require('keymaps').mapper('n', nil, true)
        local imap = require('keymaps').mapper('i', nil, true)

        nmap('gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
        nmap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
        imap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
        nmap('ga', '<cmd>lua vim.lsp.buf.code_action()<cr>')
        nmap('gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
        nmap('gr', '<cmd>lua vim.lsp.buf.rename()<cr>')
        nmap('K', '<cmd>call v:lua.__config__.hover()<cr>')

        if client.resolved_capabilities.document_formatting then
            vim.cmd [[au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
        end
    end,
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
