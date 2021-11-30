return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'nvim-lualine/lualine.nvim'
  
use {
  "folke/which-key.nvim",
  config = function()
    require("which-key").setup {
    }
  end
}
  use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

  --TODO : snippet
  use "windwp/nvim-autopairs"
  use {
    'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
    config = function() 
	    require'nvim-tree'.setup {} 
    end
}
use 'tpope/vim-fugitive'
use {
  'lewis6991/gitsigns.nvim',
  requires = {
    'nvim-lua/plenary.nvim'
  },
}
use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} }
}
use {
  'lervag/vimtex',
} 
use {'neovim/nvim-lspconfig'}
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use {'p00f/nvim-ts-rainbow'}
use {'nvim-treesitter/nvim-treesitter-textobjects'}
use {'kassio/neoterm'}
use {'hrsh7th/nvim-compe'}
use {'glepnir/lspsaga'}
use {'windwp/nvim-spectre', requires = {'nvim-lua/plenary.nvim'}}

  end)
