return function()
    local nmap = require('keymaps').nmap

    nmap('<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>')
    nmap('<leader>fk', '<cmd>lua require("telescope.builtin").keymaps()<cr>')
    nmap('<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>')
    nmap('<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>')
    nmap('<leader>fm', '<cmd>lua require("telescope.builtin").man_pages()<cr>')
    nmap('<leader>fr', '<cmd>lua require("telescope.builtin").live_grep()<cr>')
    nmap(
        '<leader>fw',
        '<cmd>lua require("telescope.builtin").file_browser({ cwd = vim.fn.expand "%:p:h" })<cr>'
    )
    nmap('<leader>ft', '<cmd>lua require("telescope.builtin").builtin()<cr>')

    local actions = require 'telescope.actions'

    require('telescope').setup {
        defaults = {
            prompt_prefix = ':: 🐵 :: ',
            selection_caret = '→ ',
            path_display = { 'smart' },
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
        pickers = {
            find_files = {
                hidden = true,
            },
            file_browser = {
                hidden = true,
            },
            man_pages = {
                sections = { 'ALL' },
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = 'smart_case',
            },
        },
    }

    require('telescope').load_extension 'fzf'
end
