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
  "nvim-lua/popup.nvim",   -- An implementation of the Popup API from vim in Neovim,
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins,

  -- themes
  'folke/tokyonight.nvim',
  { 'catppuccin/nvim',        as = 'catppuccin' },

  -- extensions
  "preservim/vimux",
  "moll/vim-bbye",
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
  {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = function()
      require('git-conflict').setup()
    end
  },
  "norcalli/nvim-colorizer.lua",
  'ThePrimeagen/harpoon',
  'folke/todo-comments.nvim',
  'mbbill/undotree',

  -- lsp
  'hashivim/vim-terraform',
  "towolf/vim-helm",
  'github/copilot.vim',
  'tpope/vim-fugitive',
  'junegunn/gv.vim',
  'akinsho/flutter-tools.nvim',
  "jose-elias-alvarez/nvim-lsp-ts-utils",
  "onsails/lspkind.nvim",
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
