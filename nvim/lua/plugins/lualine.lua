return function()
    require('lualine').setup {
        options = { theme = 'onedark-nvim' },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'b:gitsigns_head', 'b:gitsigns_status' },
            lualine_c = {
                { 'diagnostics', sources = { 'nvim_diagnostic' } },
                'filename',
            },
        },
    }
end
