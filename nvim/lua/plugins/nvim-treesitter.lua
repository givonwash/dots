return function()
    local parsers = require('nvim-treesitter.parsers').get_parser_configs()

    parsers.norg = {
        install_info = {
            url = 'https://github.com/nvim-neorg/tree-sitter-norg',
            files = { 'src/parser.c', 'src/scanner.cc' },
            branch = 'main',
        },
    }

    require('nvim-treesitter.configs').setup {
        ensure_installed = 'maintained',
        autotag = {
            enable = true,
        },
        highlight = { enable = true },
    }
end
