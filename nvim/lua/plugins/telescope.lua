return function()
    local nmap = require('keymaps').nmap

    nmap('<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>')
    nmap('<leader>fc', '<cmd>lua require("telescope.builtin").commands()<cr>')
    nmap('<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>')
    nmap('<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>')
    nmap('<leader>fm', '<cmd>lua require("telescope.builtin").man_pages()<cr>')
    nmap('<leader>fr', '<cmd>lua require("telescope.builtin").live_grep()<cr>')

    local actions = require('telescope.actions')

    require('telescope').setup {
        defaults = {
            vimgrep_arguments = {
                'rg', '--color=never', '--no-heading', '--with-filename',
                '--line-number', '--column', '--smart-case',
            },
            prompt_prefix = ':: 🐵 :: ',
            selection_caret = '→ ',
            entry_prefix = '  ',
            initial_mode = 'insert',
            scroll_strategy = 'cycle',
            selection_strategy = 'reset',
            sorting_strategy = 'descending',
            layout_strategy = 'horizontal',
            layout_config = {
                horizontal = { mirror = false },
                vertical = { mirror = false },
                width = 0.75,
                prompt_position = 'bottom',
                preview_cutoff = 120,
            },
            file_sorter = require('telescope.sorters').get_fzy_sorter,
            file_ignore_patterns = {},
            generic_sorter = require('telescope.sorters').get_fzy_sorter,
            path_display = { "absolute" },
            winblend = 0,
            border = {},
            borderchars = {
                '─', '│', '─', '│', '╭', '╮', '╯', '╰',
            },
            color_devicons = true,
            use_less = true,
            set_env = nil,
            file_previewer = require('telescope.previewers').vim_buffer_cat.new,
            grep_previewer = require('telescope.previewers').vim_buffer_vimgrep
                .new,
            qflist_previewer = require('telescope.previewers').vim_buffer_qflist
                .new,
            buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
            mappings = {
                i = {
                    ['<C-c>'] = false,
                    ['<C-n>'] = false,
                    ['<C-p>'] = false,
                    ['<Esc>'] = actions.close,
                    ['<C-s>'] = actions.toggle_selection,
                    ['<C-j>'] = actions.move_selection_next,
                    ['<C-k>'] = actions.move_selection_previous,
                },
            },
        },
    }
end
