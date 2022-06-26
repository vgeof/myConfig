return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'nvim-lualine/lualine.nvim'
    use 'cstrahan/vim-capnp'

    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
    use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

    -- TODO : snippet
    use "windwp/nvim-autopairs"

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons' -- optional, for file icon
        },
        config = function() require'nvim-tree'.setup {} end
    }
    use 'tpope/vim-fugitive'
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}}
    }
    use {'lervag/vimtex'}
    use {'neovim/nvim-lspconfig'}
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

    use {'p00f/nvim-ts-rainbow'}
    use {'nvim-treesitter/nvim-treesitter-textobjects'}
    use {'kassio/neoterm'}
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
            'hrsh7th/cmp-vsnip', 'hrsh7th/vim-vsnip','hrsh7th/cmp-nvim-lsp-signature-help'
        }
    }
    use {'tami5/lspsaga.nvim'}
    use {'windwp/nvim-spectre', requires = {'nvim-lua/plenary.nvim'}}
    use "lukas-reineke/indent-blankline.nvim"
    use {"mhartington/formatter.nvim"}
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use {'ray-x/lsp_signature.nvim'}
    use {'folke/trouble.nvim', requires = {'nvim-web-devicons'}}
    use {'sakhnik/nvim-gdb'}

end)
