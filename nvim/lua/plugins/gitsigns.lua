return function()
    require('gitsigns').setup {
        signs = {
            add = { text = '❙' },
            change = { text = '❙' },
            delete = { text = '❙' },
            topdelete = { text = '⤒' },
            changedelete = { text = '↹' },
        },
        on_attach = function()
            local mapper = require('keymaps').mapper

            local nmap = mapper('n', nil, true)
            local vmap = mapper('v', nil, true)
            local omap = mapper('o', nil, true)

            nmap('<leader>gb', '<cmd>lua require("gitsigns").blame_line()<cr>')
            nmap('<leader>gj', '<cmd>lua require("gitsigns").next_hunk()<cr>')
            nmap('<leader>gk', '<cmd>lua require("gitsigns").prev_hunk()<cr>')
            nmap('<leader>gp', '<cmd>lua require("gitsigns").preview_hunk()<cr>')
            nmap('<leader>gr', '<cmd>lua require("gitsigns").reset_hunk()<cr>')
            vmap('<leader>gr', '<cmd>lua require("gitsigns").reset_hunk()<cr>')
            vmap('ih', ':<C-u>lua require("gitsigns").select_hunk()<cr>')
            omap('ih', ':<C-u>lua require("gitsigns").select_hunk()<cr>')
        end,
    }
end
