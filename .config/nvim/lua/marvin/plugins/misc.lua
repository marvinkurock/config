return {
  "nvim-lua/popup.nvim",   -- An implementation of the Popup API from vim in Neovim,
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins,

  -- themes
  'folke/tokyonight.nvim',
  'catppuccin/nvim',

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
  -- 'github/copilot.vim',
  'tpope/vim-fugitive',
  'junegunn/gv.vim',
  'akinsho/flutter-tools.nvim',
  "jose-elias-alvarez/nvim-lsp-ts-utils",
  "onsails/lspkind.nvim",
  "ray-x/lsp_signature.nvim",
  --
  -- DAP protocol
  "mfussenegger/nvim-dap",
  "leoluz/nvim-dap-go",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
  "nvim-telescope/telescope-dap.nvim"
}
