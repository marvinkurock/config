return {
  { "numToStr/Comment.nvim" },
  { "catppuccin/nvim" },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  },
  { "preservim/vimux" },
  { "voldikss/vim-floaterm" },
  {
    'sindrets/diffview.nvim',
    config = function()
      require("diffview").setup({
        enhanced_diff_hl = true,
      })
    end
  },
  { "towolf/vim-helm" },
  { 'ThePrimeagen/harpoon' },
  { 'mbbill/undotree' },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      vim.opt.termguicolors = true
      require("colorizer").setup()
    end
  },
  { "jose-elias-alvarez/nvim-lsp-ts-utils" },


  --   -- extensions
  --   "preservim/vimux",
  --   "moll/vim-bbye",
  --   {
  --     "folke/which-key.nvim",
  --     config = function()
  --       require("which-key").setup {}
  --     end
  --   },
  --   "voldikss/vim-floaterm",
  --   'akinsho/toggleterm.nvim',
  --
  --   -- code addons
  --   "windwp/nvim-autopairs",
  --   "windwp/nvim-ts-autotag",
  --   "numToStr/Comment.nvim",
  --   { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  --   {
  --     'akinsho/git-conflict.nvim',
  --     version = "*",
  --     config = function()
  --       require('git-conflict').setup()
  --     end
  --   },
  --   "norcalli/nvim-colorizer.lua",
  --   'ThePrimeagen/harpoon',
  --   'folke/todo-comments.nvim',
  --   'mbbill/undotree',
  --
  --   -- lsp
  --   "towolf/vim-helm",
  --   -- 'github/copilot.vim',
  --   "onsails/lspkind.nvim",
  --   "ray-x/lsp_signature.nvim",
  --   --
  --   -- DAP protocol
  --   --   "mfussenegger/nvim-dap",
  --   --   "leoluz/nvim-dap-go",
  --   --   "rcarriga/nvim-dap-ui",
  --   --   "theHamsta/nvim-dap-virtual-text",
  --   config = function()
  --     require("Comment").setup()
  --
  --     require('nvim-autopairs').setup()
  --
  --     print("Autipairs setups")
  --
  --     require("colorizer").setup()
  --
  --     require("diffview").setup {
  --       enhanced_diff_hl = true,
  --     }
  --   end
}
