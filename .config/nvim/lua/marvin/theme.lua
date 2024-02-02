local catppuccin = require("catppuccin")
catppuccin.setup {
  flavour = "mocha",
  transparent_background = true,
}
vim.cmd[[colorscheme catppuccin]]
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_italic_functions = true
