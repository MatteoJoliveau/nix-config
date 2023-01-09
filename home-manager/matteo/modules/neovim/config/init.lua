-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

local packer = require('packer')

packer.startup(function(use)
    -- Package manager
    use 'wbthomason/packer.nvim'
  
    -- TreeSitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }

    -- Git stuff
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'lewis6991/gitsigns.nvim'

    -- Theme inspired by Atom
    use 'navarasu/onedark.nvim'

    -- File tree explorer
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
          'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    -- Fuzzy Finder (files, lsp, etc)
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

    -- Nice status bar
    use 'nvim-lualine/lualine.nvim'

    -- Add indentation guides even on blank lines
    use 'lukas-reineke/indent-blankline.nvim'

    -- LSP goodies
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
          -- LSP Support
          {'neovim/nvim-lspconfig'},
          {'williamboman/mason.nvim'},
          {'williamboman/mason-lspconfig.nvim'},
      
          -- Autocompletion
          {'hrsh7th/nvim-cmp'},
          {'hrsh7th/cmp-buffer'},
          {'hrsh7th/cmp-path'},
          {'saadparwaiz1/cmp_luasnip'},
          {'hrsh7th/cmp-nvim-lsp'},
          {'hrsh7th/cmp-nvim-lua'},
      
          -- Snippets
          {'L3MON4D3/LuaSnip'},
          -- Snippet Collection (Optional)
          {'rafamadriz/friendly-snippets'},
        }
      }

	use "Pocco81/auto-save.nvim"

    -- Useful status updates for LSP
    use 'j-hui/fidget.nvim'

    -- Additional lua configuration, makes nvim stuff amazing
    use 'folke/neodev.nvim'

    use "ahmedkhalf/project.nvim"
    
    use { 'mg979/vim-visual-multi', branch = "master" }

   -- Rust goodies
   use 'neovim/nvim-lspconfig'
   use 'simrat39/rust-tools.nvim'
   -- debugging
   use 'nvim-lua/plenary.nvim'
   use 'mfussenegger/nvim-dap'
end)

require('settings')
