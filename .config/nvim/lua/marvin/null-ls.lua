local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting;
local prettier_source = formatting.prettier
prettier_source.disabled_filetypes = { "html" }

null_ls.setup({
  sources = { 
    prettier_source,
  },
  on_attach = function (client, bufnr)
    -- nothing
  end,
})
