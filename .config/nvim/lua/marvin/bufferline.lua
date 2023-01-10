require('bufferline').setup {
  options = {
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    -- separator_style = "slant",
  },
  highlights = {
    buffer_selected = {
      fg = '#a6e3a1',
      bg = 'none',
      bold = true,
      italic = false,
    },
    close_button_selected = {
      bg = 'none',
    },
    modified_selected = {
      bg = 'none',
    },
    indicator_selected = {
      bg = 'none',
    },
    -- pick_selected = {
    --   bold = true,
    --   bg = 'none',
    -- },
    separator_selected = {
      bg = 'none',
    },
    duplicate_selected = {
      bg = 'none',
    },
    background = {
      bg = 'none',
    }
  }
}
