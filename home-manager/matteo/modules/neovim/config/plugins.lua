return {
  'navarasu/onedark.nvim',
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "nvim-lua/plenary.nvim", lazy = true },
  "folke/which-key.nvim",
  "folke/trouble.nvim",
  {
      "folke/todo-comments.nvim",
      dependencies = {"nvim-lua/plenary.nvim"},
  },
  'neovim/nvim-lspconfig',
  'williamboman/mason-lspconfig.nvim',
  {
      "williamboman/mason.nvim",
      build = ":MasonUpdate",
  },
  'nvim-lualine/lualine.nvim',
  'nanotee/sqls.nvim',
  {
      'nvim-treesitter/nvim-treesitter',
      cmd = 'TSUpdate',
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim', 
    build = "make",
  },
  'nvim-telescope/telescope.nvim',
  "debugloop/telescope-undo.nvim",
  {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      dependencies = { 
          "MunifTanjim/nui.nvim",
      },
  },
  {
      "utilyre/barbecue.nvim",
      dependencies = {
        "SmiteshP/nvim-navic",
      },
  },
  {
    'TimUntersberger/neogit',
    dependencies = {
      "sindrets/diffview.nvim",
    },
  },
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-nvim-lsp',
  'dcampos/nvim-snippy',
  'dcampos/cmp-snippy',
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
  },
  {
      "kristijanhusak/vim-dadbod-ui",
      dependencies = {"tpope/vim-dadbod"},
  },
  'Pocco81/auto-save.nvim',
  'simrat39/rust-tools.nvim',
  'terrortylor/nvim-comment',
  'JoosepAlviste/nvim-ts-context-commentstring',
  'lewis6991/gitsigns.nvim',
  'lukas-reineke/indent-blankline.nvim',
  'ahmedkhalf/project.nvim',
  'IndianBoy42/tree-sitter-just',
  'NvChad/nvterm',
  'f-person/git-blame.nvim',
  {
    'saecki/crates.nvim',
    dependencies = {'nvim-lua/plenary.nvim'},
  },
  'tpope/vim-abolish',
}
