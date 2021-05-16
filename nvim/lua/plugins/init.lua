return require('packer').startup(function(use)
    -- let packer manage itself
    use 'wbthomason/packer.nvim'

    --[[ lsp-related plugins ================================================]]

    -- default configurations for popular language servers
    use {
        'neovim/nvim-lspconfig',
        config = function()
            require 'plugins.lspconfig'
        end,
    }

    -- rust inlay hints
    use {
        'nvim-lua/lsp_extensions.nvim',
        config = function()
            require 'plugins.lsp_extensions'
        end,
    }

    -- enhanced completion engine
    use {
        'hrsh7th/nvim-compe',
        config = function()
            require 'plugins.compe'
        end,
    }

    -- snippet support for language servers
    use {
        'norcalli/snippets.nvim',
        config = function()
            require 'plugins.snippets'
        end
    }

    --  show function signature while in insert mode
    use {
        'ray-x/lsp_signature.nvim',
        config = function()
            require 'plugins.lsp_signature'
        end
    }

    --[[ aesthetics =========================================================]]

    -- better syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require 'plugins.treesitter'
        end,
    }

    -- onedark colorscheme with treesitter support
    use {
        'Th3Whit3Wolf/onebuddy',
        requires = { 'tjdevries/colorbuddy.nvim' },
        config = function()
            require 'plugins.onebuddy'
        end,
    }

    -- statusline
    use {
        'glepnir/galaxyline.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require 'plugins.galaxyline'
        end,
    }

    -- display git diff icons in sign column
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        after = 'onebuddy',
        config = function()
            require 'plugins.gitsigns'
        end,
    }

    -- pretty ui for lsp actions
    use {
        'glepnir/lspsaga.nvim',
        config = function()
            require 'plugins.lspsaga'
        end
    }

    -- icons for completion items
    use {
        "onsails/lspkind-nvim",
        config = function()
            require 'plugins.lspkind'
        end,
    }

    --[[navigation ==========================================================]]

    -- fuzzy finding
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
        rocks = 'luafilesystem',
        config = function()
            require 'plugins.telescope'
        end
    }

    -- workspace and document diagnostic navigation
    use {
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require 'plugins.trouble'
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
            require 'plugins.autopairs'
        end
    }

    --formatting
    use {
        'mhartington/formatter.nvim',
        config = function()
            require 'plugins.formatter'
        end
    }
end)
