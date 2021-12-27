return function()
    require('neorg').setup {
        load = {
            ['core.defaults'] = {},
            ['core.norg.concealer'] = {},
            ['core.norg.dirman'] = {
                config = {
                    workspaces = { notes = '~/.local/share/neorg/notes' },
                    autodetect = true,
                    autochdir = true,
                },
            },
            ['core.norg.completion'] = { config = { engine = 'nvim-cmp' } },
        },
    }
end
