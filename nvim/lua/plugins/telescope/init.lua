local nmap = require('keymaps').nmap

nmap('<localleader>fa', '<cmd>lua require("telescope.builtin").builtin()<cr>')
nmap('<localleader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>')
nmap('<localleader>fc', '<cmd>lua require("telescope.builtin").commands()<cr>')
nmap('<localleader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>')
nmap('<localleader>fg', '<cmd>lua require("telescope.builtin").git_files()<cr>')
nmap('<localleader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>')
nmap('<localleader>fk',
     '<cmd>lua require("telescope.builtin").grep_string()<cr>')
nmap('<localleader>fm', '<cmd>lua require("telescope.builtin").man_pages()<cr>')
nmap('<localleader>fo',
     '<cmd>lua require("telescope.builtin").file_browser()<cr>')
nmap('<localleader>fp', '<cmd>lua require("telescope.builtin").live_grep()<cr>')
nmap('<localleader>fr', '<cmd>lua require("telescope.builtin").reloader()<cr>')
nmap('<localleader>fs',
     '<cmd>lua require("telescope.builtin").lsp_document_symbols()<cr>')
nmap('<localleader>fv',
     '<cmd>lua require("telescope.builtin").vim_options()<cr>')
nmap('<localleader>fw',
     '<cmd>lua require("telescope.builtin").lsp_workspace_symbols()<cr>')

local actions = require('telescope.actions')

require('telescope').setup {
    defaults = {
        vimgrep_arguments = {
            'rg', '--color=never', '--no-heading', '--with-filename',
            '--line-number', '--column', '--smart-case',
        },
        prompt_position = 'bottom',
        prompt_prefix = ':: 🐵 :: ',
        selection_caret = '→ ',
        entry_prefix = '  ',
        initial_mode = 'insert',
        scroll_strategy = 'cycle',
        selection_strategy = 'reset',
        sorting_strategy = 'descending',
        layout_strategy = 'horizontal',
        layout_defaults = {
            horizontal = { mirror = false },
            vertical = { mirror = false },
        },
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        file_ignore_patterns = {},
        generic_sorter = require('telescope.sorters').get_fzy_sorter,
        shorten_path = true,
        winblend = 0,
        width = 0.75,
        preview_cutoff = 120,
        results_height = 1,
        results_width = 0.8,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        color_devicons = true,
        use_less = true,
        set_env = nil,
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
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
