return function()
    require('gitsigns').setup {
        signs = {
            add = {
                hl = 'GitGutterAdd',
                text = '+',
                numhl = 'GitGutterAdd',
                linehl = 'GitGutterAdd',
            },
            change = {
                hl = 'GitGutterChange',
                text = '~',
                numhl = 'GitGutterChange',
                linehl = 'GitGutterChange',
            },
            delete = {
                hl = 'GitGutterDelete',
                text = '-',
                numhl = 'GitGutterDelete',
                linehl = 'GitGutterDelete',
            },
            topdelete = {
                hl = 'GitGutterDelete',
                text = '≏',
                numhl = 'GitGutterDelete',
                linehl = 'GitGutterDelete',
            },
            changedelete = {
                hl = 'GitGutterChange',
                text = '≁',
                numhl = 'GitGutterChange',
                linehl = 'GitGutterChange',
            },
        },
        numhl = false,
        linehl = false,
        keymaps = {
            noremap = true,
            buffer = true,
            ['n <leader>gb'] = '<cmd>lua require("gitsigns").blame_line()<cr>',
            ['n <leader>gj'] = '<cmd>lua require("gitsigns").next_hunk()<cr>',
            ['n <leader>gk'] = '<cmd>lua require("gitsigns").prev_hunk()<cr>',
            ['n <leader>gp'] = '<cmd>lua require("gitsigns").preview_hunk()<cr>',
            ['n <leader>gr'] = '<cmd>lua require("gitsigns").reset_hunk()<cr>',
            ['v <leader>gr'] = '<cmd>lua require("gitsigns").reset_hunk()<cr>',
            ['o ih'] = ':<C-u>lua require("gitsigns").select_hunk()<cr>',
            ['x ih'] = ':<C-u>lua require("gitsigns").select_hunk()<cr>',
        },
        watch_index = { interval = 1000 },
        current_line_blame = false,
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        use_internal_diff = true,
    }
end
