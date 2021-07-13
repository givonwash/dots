require('trouble').setup {
    mode = 'lsp_document_diagnostics',
    use_lsp_diagnostic_signs = true,
}

local nmap = require('keymaps').nmap

nmap('<localleader>tt', '<cmd>TroubleToggle<cr>')
nmap('<localleader>tw', '<cmd>TroubleToggle lsp_workspace_diagnostics<cr>')
nmap('<localleader>td', '<cmd>TroubleToggle lsp_document_diagnostics<cr>')
nmap('<localleader>tq', '<cmd>TroubleToggle quickfix<cr>')
nmap('<localleader>tl', '<cmd>TroubleToggle loclist<cr>')
