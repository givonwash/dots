return function()
    local g = vim.g
    local nmap = require('keymaps').nmap

    -- navigate buffers
    nmap('gb', '<cmd>BufferNext<cr>')
    nmap('gB', '<cmd>BufferPrevious<cr>')

    -- move buffers
    nmap('gmp', '<cmd>BufferMovePrevious<cr>')
    nmap('gmn', '<cmd>BufferMoveNext<cr>')

    -- goto buffers
    nmap('g1', '<cmd>BufferGoto 1<cr>')
    nmap('g2', '<cmd>BufferGoto 2<cr>')
    nmap('g3', '<cmd>BufferGoto 3<cr>')
    nmap('g4', '<cmd>BufferGoto 4<cr>')
    nmap('g5', '<cmd>BufferGoto 5<cr>')
    nmap('g6', '<cmd>BufferGoto 6<cr>')
    nmap('g7', '<cmd>BufferGoto 7<cr>')
    nmap('g8', '<cmd>BufferGoto 8<cr>')
    nmap('gl', '<cmd>BufferLast<cr>')
    nmap('gp', '<cmd>BufferPick<cr>')

    -- sort buffers
    nmap('god', '<cmd>BufferOrderByDirectory<cr>')
    nmap('gol', '<cmd>BufferOrderByLanguage<cr>')

    -- close buffers
    nmap('g.', '<cmd>BufferClose<cr>')

    -- options
    g.bufferline = {
        animation = false,
        auto_hide = true,
        tabpages = true,
        closable = true,
        clickable = true,
        icons = true,
        icon_custom_colors = false,
        icon_separator_active = '▎',
        icon_separator_inactive = '▎',
        icon_close_tab = '',
        icon_close_tab_modified = '●',
        maximum_padding = 4,
        maximum_length = 30,
        semantic_letters = true,
        letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
        no_name_title = nil,
    }
end
