return require('packer').startup(function(use)
    -- let packer manage itself
    use 'wbthomason/packer.nvim'

    --[[ completion plugins ==================================================]]

    -- completion engine
    use {
        'hrsh7th/nvim-cmp',
        config = require 'plugins.nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-emoji',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'simrat39/rust-tools.nvim',
            'nvim-neorg/neorg',
            'windwp/nvim-autopairs',
        },
    }

    --[[ lsp plugins =========================================================]]

    -- configurations for popular language servers
    use {
        'neovim/nvim-lspconfig',
        requires = {
            'williamboman/nvim-lsp-installer',
            'hrsh7th/nvim-cmp',
        },
        config = require 'plugins.nvim-lspconfig',
    }

    -- easily viewable (and navigable) lsp diagnositcs
    use { 'folke/trouble.nvim', config = require 'plugins.trouble' }

    -- inject useful diagnostics and actions into builtin-lsp
    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = require 'plugins.null-ls',
    }

    --[[ aesthetic plugins ===================================================]]

    -- better syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {
            'windwp/nvim-ts-autotag',
        },
        run = ':TSUpdate',
        config = require 'plugins.nvim-treesitter',
    }

    -- onedark colorscheme with treesitter support
    use { 'ful1e5/onedark.nvim', config = require 'plugins.onedark' }

    -- statusline
    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
            'lewis6991/gitsigns.nvim',
            'ful1e5/onedark.nvim',
        },
        config = require 'plugins.lualine',
    }

    -- display git diff icons in sign column
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = require 'plugins.gitsigns',
    }

    -- buffer line
    use {
        'romgrk/barbar.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = require 'plugins.barbar',
    }

    -- colorizer
    use {
        'norcalli/nvim-colorizer.lua',
        config = require 'plugins.nvim-colorizer',
    }

    -- notifications
    use {
        'rcarriga/nvim-notify',
        config = require 'plugins.nvim-notify',
    }

    --[[ navigation plugins ==================================================]]

    -- fuzzy finding
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        },
        rocks = 'luafilesystem',
        config = require 'plugins.telescope',
    }

    -- file tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = require 'plugins.nvim-tree',
        cmd = 'NvimTreeToggle',
        keys = { '<leader>e' },
    }

    --[[ efficiency plugins ==================================================]]

    -- changing of surrounding delimiters
    use 'tpope/vim-surround'

    -- project manager
    use {
        'ahmedkhalf/project.nvim',
        requires = { 'nvim-telescope/telescope.nvim' },
        config = require 'plugins.project',
    }

    -- quick commenting and uncommenting
    use 'b3nj5m1n/kommentary'

    -- autopairs
    use { 'windwp/nvim-autopairs', config = require 'plugins.nvim-autopairs' }

    -- [[ debuggin plugins  ==================================================]]

    use { 'nvim-treesitter/playground', config = require 'plugins.playground' }

    -- [[ note-taking ======================================================= ]]
    use {
        'nvim-neorg/neorg',
        requires = {
            'nvim-lua/plenary.nvim',
            'hrsh7th/nvim-cmp',
        },
        after = 'nvim-treesitter',
        config = require 'plugins.neorg',
    }
end)
