require("Comment").setup()

require('nvim-autopairs').setup{}

require("colorizer").setup()

local neogit = require("neogit")

neogit.setup {
  disable_commit_confirmation = false,
  integrations = {
    diffview = true
  }
}

require("diffview").setup {
  enhanced_diff_hl = true,
}
