return function()
    require('trouble').setup {
        mode = 'document_diagnostics',
    }

    local nmap = require('keymaps').nmap

    nmap('<leader>t', '<cmd>TroubleToggle<cr>')
end
