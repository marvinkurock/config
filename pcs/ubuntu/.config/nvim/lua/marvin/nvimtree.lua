require('nvim-tree').setup {
  hijack_netrw = true,
  view = {
    adaptive_size= true,
    mappings = {
      list = {
        { key = {"<C-g>"},    action = "cd" },
      }
    }
  },
  git = {
    enable = true,
    ignore = false
  },
  remove_keymaps = { "<C-e>" },
  filters = {
    dotfiles = false,
    custom = {
      "node_modules",
      ".DS_Store"
    },
    exclude = {}
  }
}
