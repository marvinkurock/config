require('bufferline').setup {
  options = {
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    -- separator_style = "slant",
  },
  highlights = {
    buffer_selected = {
      fg = '#a6e3a1',
      bg = '#313244',
      bold = true,
      italic = false,
    },
    close_button_selected = {
      bg = '#313244',
    },
    modified_selected = {
      bg = '#313244',
    },
    indicator_selected = {
      bg = '#313244',
    },
    -- pick_selected = {
    --   bold = true,
    --   bg = '#313244',
    -- },
    separator_selected = {
      bg = '#313244',
    },
    duplicate_selected = {
      bg = '#313244',
    },
    background = {
      bg = "#1e1e2e"
    }
  }
}
