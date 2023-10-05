-- --Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- require('marvin')
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local plugins = {
  { import = "marvin.plugins" },
  "wbthomason/packer.nvim", -- needed?
  "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim,
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins,
  "kyazdani42/nvim-web-devicons",

  -- themes
  'folke/tokyonight.nvim',
  { 'catppuccin/nvim', as = 'catppuccin' },

  -- extensions
  "preservim/vimux",
  'stevearc/aerial.nvim',
  "kyazdani42/nvim-tree.lua",
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },
  { 'akinsho/bufferline.nvim', version = "v2.*", dependencies = 'kyazdani42/nvim-web-devicons' },
  "moll/vim-bbye",
  "nvim-lualine/lualine.nvim",
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  },
  "voldikss/vim-floaterm",
  'akinsho/toggleterm.nvim',

  -- code addons
  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",
  "numToStr/Comment.nvim",
  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  'lewis6991/gitsigns.nvim',
  { 'akinsho/git-conflict.nvim', version = "*", config = function()
    require('git-conflict').setup()
  end },
  "norcalli/nvim-colorizer.lua",
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  },
  'ThePrimeagen/harpoon',
  'folke/todo-comments.nvim',
  'mbbill/undotree',

  -- lsp
  'hashivim/vim-terraform',
  "towolf/vim-helm",
  -- {,
  --   "williamboman/mason.nvim",
  --   "williamboman/mason-lspconfig.nvim",
  --   "neovim/nvim-lspconfig",
  -- }
  'github/copilot.vim',
  'tpope/vim-fugitive',
  -- { 'NeogitOrg/neogit', dependencies = 'nvim-lua/plenary.nvim' },
  'junegunn/gv.vim',
  'akinsho/flutter-tools.nvim',
  "jose-elias-alvarez/nvim-lsp-ts-utils",

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  },
  "onsails/lspkind.nvim",
  -- "hrsh7th/nvim-cmp",
  -- 'hrsh7th/cmp-nvim-lsp',
  -- 'hrsh7th/cmp-buffer',
  -- 'hrsh7th/cmp-path',
  -- 'hrsh7th/cmp-cmdline',
  -- { 'saadparwaiz1/cmp_luasnip' },
  -- 'L3MON4D3/LuaSnip',
  -- 'rafamadriz/friendly-snippets',
  -- -- 'hrsh7th/vim-vsnip',
  -- {,
  --   "ray-x/lsp_signature.nvim",
  --   tag = "v0.2.0"
  -- }
  "ray-x/lsp_signature.nvim",
  {
    "glepnir/lspsaga.nvim",
    config = function()
      require('lspsaga').setup({
        lightbulb = {
          enable = false,
          enable_in_insert = false,
          sign = false,
          sign_priority = 40,
          virtual_text = false,
        },
      })
    end
  },
  --
  -- DAP protocol
  "mfussenegger/nvim-dap",
  "leoluz/nvim-dap-go",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
  "nvim-telescope/telescope-dap.nvim"
}
require("lazy").setup(plugins, opts)
require("marvin")
