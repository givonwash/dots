return function()
    require('gitsigns').setup {
        signs = {
            add = { text = '❙' },
            change = { text = '❙' },
            delete = { text = '❙' },
            topdelete = { text = '⤒' },
            changedelete = { text = '↹' },
        },
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
    }
end
