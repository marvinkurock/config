require('nvim-tree').setup {
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
  },
  actions = {
    open_file = {
      quit_on_open = true,
    }
  }
}
local function open_nvim_tree(data)

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
