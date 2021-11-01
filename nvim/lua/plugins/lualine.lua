return function()
    require('lualine').setup {
        options = { theme = 'onedark' },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'b:gitsigns_head', 'b:gitsigns_status' },
            lualine_c = {
                { 'diagnostics', sources = { 'nvim_lsp' } }, 'filename',
            },
        },
    }
end
