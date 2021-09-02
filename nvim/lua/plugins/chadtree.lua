return function()
    local nmap = require('keymaps').nmap

    local chadtree_settings = { keymap = { delete = { 'DD' }, open_sys = nil } }
    vim.g.chadtree_settings = chadtree_settings

    nmap('<leader>rr', '<cmd>CHADopen<cr>')
end
