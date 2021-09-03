return function()
    require('trouble').setup {
        mode = 'lsp_document_diagnostics',
        use_lsp_diagnostic_signs = true,
    }

    local nmap = require('keymaps').nmap

    nmap('<leader>tt', '<cmd>TroubleToggle<cr>')
end
