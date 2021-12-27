return function()
    require('trouble').setup {
        mode = 'document_diagnostics',
        use_diagnostic_signs = true,
    }

    local nmap = require('keymaps').nmap

    nmap('<leader>t', '<cmd>TroubleToggle<cr>')
end
