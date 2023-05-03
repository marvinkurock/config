local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set('n', '<C-e>', '', { buffer = bufnr })
  vim.keymap.del('n', '<C-e>', { buffer = bufnr })
end

require('nvim-tree').setup {
  view = {
    adaptive_size= true,
  },
  git = {
    enable = true,
    ignore = false
  },
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
  },
  on_attach = my_on_attach
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
