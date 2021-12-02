return function()
    require('nvim-tree').setup {}
    local nmap = require('keymaps').nmap
    nmap('<leader>e', '<cmd>NvimTreeToggle<cr>')
end
