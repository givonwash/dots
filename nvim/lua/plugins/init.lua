return require('packer').startup(function(use)
    -- let packer manage itself
    use 'wbthomason/packer.nvim'

    --[[ lsp-related plugins ================================================]]

    -- default configurations for popular language servers
    use {
        'neovim/nvim-lspconfig',
        after = 'coq_nvim',
        requires = { { 'kabouzeid/nvim-lspinstall' }, { 'ms-jpq/coq_nvim' } },
        config = require 'plugins.nvim-lspconfig',
    }

    -- completion engine
    use {
        'ms-jpq/coq_nvim',
        branch = 'coq',
        run = ':COQDeps',
        config = require 'plugins.coq_nvim',
    }

    -- LSP snippet capabilities
    use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }

    -- rust inlay hints
    use {
        'nvim-lua/lsp_extensions.nvim',
        config = require 'plugins.lsp_extensions',
    }

    use { 'folke/trouble.nvim', config = require 'plugins.trouble' }

    --[[ aesthetics =========================================================]]

    -- better syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = require 'plugins.nvim-treesitter',
    }

    -- onedark colorscheme with treesitter support
    use {
        'Th3Whit3Wolf/onebuddy',
        requires = { 'tjdevries/colorbuddy.nvim' },
        config = require 'plugins.onebuddy',
    }

    -- statusline
    use {
        'glepnir/galaxyline.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = require 'plugins.galaxyline',
    }

    -- display git diff icons in sign column
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        after = 'onebuddy',
        config = require 'plugins.gitsigns',
    }

    -- pretty ui for lsp actions
    use { 'glepnir/lspsaga.nvim', config = require 'plugins.lspsaga' }

    -- buffer line
    use {
        'romgrk/barbar.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = require 'plugins.barbar',
    }

    --[[ navigation =========================================================]]

    -- fuzzy finding
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
        rocks = 'luafilesystem',
        config = require 'plugins.telescope',
    }

    -- file tree
    use {
        'ms-jpq/chadtree',
        branch = 'chad',
        run = ':CHADdeps',
        config = require 'plugins.chadtree',
    }

    --[[ efficiency =========================================================]]

    -- changing of surrounding delimiters
    use 'tpope/vim-surround'

    -- project manager
    use {
        'ahmedkhalf/project.nvim',
        requires = { 'nvim-telescope/telescope.nvim' },
        config = require('plugins.project'),
    }

    -- quick commenting and uncommenting
    use 'b3nj5m1n/kommentary'

    -- autopairs
    use { 'windwp/nvim-autopairs', config = require 'plugins.nvim-autopairs' }

    -- formatting
    use { 'mhartington/formatter.nvim', config = require 'plugins.formatter' }
end)
