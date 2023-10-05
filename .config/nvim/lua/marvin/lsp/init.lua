require('marvin.lsp.signs')
require('marvin.lsp.cmp')
local cfg = require('marvin.lsp.config')
local saga = require("lspsaga")
saga.init_lsp_saga({
    -- your configuration
})
require('lspconfig.ui.windows').default_options = {
  border = "rounded"
}

local nvim_lsp = require 'lspconfig'
local luasnip = require("luasnip")
luasnip.config.setup {
  update_events = "TextChanged,TextChangedI",
}
local ensure_servers = {
  -- "angularls",
  "bashls",
  "cssls",
  -- "gopls",
  "html",
  "pyright",
  "sumneko_lua",
  "tsserver",
  "yamlls",
}

require("mason").setup()

require("mason-lspconfig").setup {
  ensure_installed = ensure_servers
}

require("luasnip.loaders.from_vscode").lazy_load()

require("mason-lspconfig").setup_handlers({
  function (server_name)
    nvim_lsp[server_name].setup {
      on_attach = cfg.on_attach,
      capabilities = cfg.capabilities
    }
  end,
  ["rust_analyzer"] = function ()
    -- do nothing
  end,
  ["html"] = function ()
    nvim_lsp["html"].setup {
      on_attach = cfg.on_attach,
      capabilities = cfg.capabilities,
      filetypes = {
        "html",
        "handlebars"
      }
    }
  end,
})

require("flutter-tools").setup {
  dev_log = {
    enabled = true,
    open_cmd = "10new", -- command to use to open the log buffer
  },
  lsp = {
    on_attach = function ()
      local opts = { noremap = true, silent = true }
      -- vim.api.nvim_set_keymap('n', '<leader>R', '<cmd>FlutterRestart<CR>', opts)
    end
  }
}

require "lsp_signature".setup({
  zindex = 20
})
