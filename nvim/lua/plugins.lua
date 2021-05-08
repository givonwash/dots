return require('packer').startup(function(use)
    -- let packer manage itself
    use 'wbthomason/packer.nvim'

    --[[ lsp-related plugins ================================================]]

    -- default configurations for popular language servers
    use {
        'neovim/nvim-lspconfig',
        config = function()
            require 'lsp'
        end,
    }

    -- rust inlay hints
    use {
        'nvim-lua/lsp_extensions.nvim',
        config = function()
            local autocmd = require 'autocmds'

            autocmd.augroup({
                {
                    'InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost',
                    '*.rs',
                    'lua require("lsp_extensions").inlay_hints { highlight = "Comment", prefix = " → ", aligned = false, only_current_line = false, enabled = { "ChainingHint", "TypeHint", "ParameterHint" } }',
                }
            }, 'inlay_hints')
        end,
    }

    -- enhanced completion engine
    use {
        'hrsh7th/nvim-compe',
        config = function()
            local opt = require 'options'
            opt.gset('completeopt', 'menuone,noselect')
            opt.gset('shortmess', 'filnxtToOFc')

            local imap = require('keymaps').imap
            local expr = require('utils').map_opts.expr
            imap('<cr>', 'compe#confirm(\'<cr>\')', expr)

            require('compe').setup {
                source = {
                    buffer = true,
                    path = true,
                    spell = true,
                    calc = true,
                    nvim_lsp = true,
                    nvim_lua = true,
                    snippets_nvim = true,
                }
            }
        end,
    }

    -- snippet support for language servers
    use {
        'norcalli/snippets.nvim',
        config = function()
            local imap = require('keymaps').imap

            imap('<C-j>', '<cmd>lua return require("snippets").expand_or_advance(1)<cr>')
            imap('<C-k>', '<cmd>lua return require("snippets").expand_or_advance(-1)<cr>')
        end
    }

    --[[ aesthetics =========================================================]]

    -- better syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter/configs').setup {
                ensure_installed = 'maintained',
                highlight = {
                    enable = true,
                }
            }
        end,
    }

    -- onedark colorscheme with treesitter support
    use {
        'Th3Whit3Wolf/onebuddy',
        requires = { 'tjdevries/colorbuddy.nvim' },
        config = function()
            require('colorbuddy').colorscheme('onebuddy')
        end,
    }

    -- statusline
    use {
        'glepnir/galaxyline.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require 'statusline'
        end,
    }

    -- display git diff icons in sign column
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        after = 'onebuddy',
        config = function()
            require('gitsigns').setup {
                signs = {
                    add          = {hl = 'GitGutterAdd'   , text = '+', numhl='GitGutterAdd'   , linehl='GitGutterAdd'},
                    change       = {hl = 'GitGutterChange', text = '~', numhl='GitGutterChange', linehl='GitGutterChange'},
                    delete       = {hl = 'GitGutterDelete', text = '-', numhl='GitGutterDelete', linehl='GitGutterDelete'},
                    topdelete    = {hl = 'GitGutterDelete', text = '≏', numhl='GitGutterDelete', linehl='GitGutterDelete'},
                    changedelete = {hl = 'GitGutterChange', text = '≁', numhl='GitGutterChange', linehl='GitGutterChange'},
                },
                numhl = false,
                linehl = false,
                keymaps = {
                    noremap = true,
                    buffer = true,
                    ['n <localleader>gn'] = '<cmd>lua require("gitsigns").next_hunk()<cr>',
                    ['n <localleader>gp'] = '<cmd>lua require("gitsigns").prev_hunk()<cr>',
                    ['o ih'] = ':<C-U>lua require("gitsigns").select_hunk()<cr>',
                    ['x ih'] = ':<C-U>lua require("gitsigns").select_hunk()<cr>',
                },
                watch_index = {
                    interval = 1000
                },
                current_line_blame = false,
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil,
                use_decoration_api = true,
                use_internal_diff = true,
            }
        end,
    }

    -- pretty ui for lsp actions
    use {
        'glepnir/lspsaga.nvim',
        config = function()
            local api = vim.api
            local fn = vim.fn
            local nmap = require('keymaps').nmap
            local vmap = require('keymaps').vmap

            nmap('ga', '<cmd>lua require("lspsaga.codeaction").code_action()<cr>')
            vmap('ga', '<cmd>lua require("lspsaga.codeaction").code_action()<cr>')
            nmap('gs', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<cr>')
            nmap('gr', '<cmd>lua require("lspsaga.rename").rename()<cr>')
            nmap('gd', '<cmd>lua require("lspsaga.provider").preview_definition()<cr>')
            nmap('gl', '<cmd>lua require("lspsaga.diagnostic").show_line_diagnostics()<cr>')
            nmap('gc', '<cmd>lua require("lspsaga.diagnostic").show_cursor_diagnostics()<cr>')
            nmap('gJ', '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<cr>')
            nmap('gK', '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<cr>')
            nmap('<C-f>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<cr>')
            nmap('<C-b>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<cr>')

            _G.on_hover = function()
                local ft = api.nvim_buf_get_option(0, 'filetype')
                if ft == 'help' or ft == 'vim' then
                    local cword = fn.expand('<cword>')
                    api.nvim_command('help ' .. cword)
                elseif ft == 'man' then
                    local cword = fn.expand('<cword>')
                    api.nvim_command('Man ' .. cword)
                else
                    require('lspsaga.hover').render_hover_doc()
                end
            end

            nmap('K', '<cmd>call v:lua.on_hover()<cr>')

            require('lspsaga').init_lsp_saga {
                use_saga_diagnostic_sign = true,
                error_sign = '',
                warn_sign = '',
                hint_sign = '',
                infor_sign = '',
                dianostic_header_icon = '   ',
                code_action_icon = ' ',
                code_action_prompt = {
                  enable = true,
                  sign = true,
                  sign_priority = 20,
                  virtual_text = true,
                },
                max_preview_lines = 10,
                code_action_keys = {
                  quit = '<esc>',
                  exec = '<cr>'
                },
                rename_action_keys = {
                  quit = '<esc>',
                  exec = '<cr>'
                },
                definition_preview_icon = '  ',
                border_style = "single",
                rename_prompt_prefix = '➤',
            }
        end
    }

    --[[navigation ==========================================================]]

    -- fuzzy finding
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
        config = function()
            local nmap = require('keymaps').nmap
            nmap('<localleader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>')
            nmap('<localleader>fc', '<cmd>lua require("telescope.builtin").grep_string()<cr>')
            nmap('<localleader>fg', '<cmd>lua require("telescope.builtin").git_files()<cr>')
            nmap('<localleader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>')
            nmap('<localleader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>')
            nmap('<localleader>fo', '<cmd>lua require("telescope.builtin").file_browser()<cr>')
            nmap('<localleader>fr', '<cmd>lua require("telescope.builtin").live_grep()<cr>')

            local actions = require('telescope.actions')

            require('telescope').setup {
                defaults = {
                    vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case'
                    },
                    prompt_position = 'bottom',
                    prompt_prefix = ' ',
                    selection_caret = '> ',
                    entry_prefix = '  ',
                    initial_mode = 'insert',
                    scroll_strategy = 'cycle',
                    selection_strategy = 'reset',
                    sorting_strategy = 'descending',
                    layout_strategy = 'horizontal',
                    layout_defaults = {
                        horizontal = {
                            mirror = false,
                        },
                        vertical = {
                            mirror = false,
                        },
                    },
                    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
                    file_ignore_patterns = {},
                    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
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
                    set_env = { ['COLORTERM'] = 'truecolor' },
                    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
                    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
                    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
                    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
                    mappings = {
                        i = {
                            ['<C-c>'] = false,
                            ['<Esc>'] = actions.close,
                            ['<C-s>'] = actions.toggle_selection,
                        }
                    }
                }
            }
        end
    }

    --[[Efficiency ==========================================================]]

    -- changing of surrounding delimiters
    use 'tpope/vim-surround'

    -- switch director to root of project
    use 'airblade/vim-rooter'

    -- quick commenting and uncommenting
    use 'b3nj5m1n/kommentary'
    -- autopairs
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup()
        end
    }
end)
