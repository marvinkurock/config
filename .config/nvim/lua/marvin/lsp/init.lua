require('marvin.lsp.null-ls')
require('marvin.lsp.signs')
require('marvin.lsp.cmp')
local cfg = require('marvin.lsp.config')
local saga = require("lspsaga")
saga.init_lsp_saga({
    -- your configuration
})

local nvim_lsp = require 'lspconfig'
local luasnip = require("luasnip")
luasnip.config.setup {
  update_events = "TextChanged,TextChangedI",
}
local lsp_installer = require("nvim-lsp-installer")
local ensure_servers = {
  -- "angularls",
  "bashls",
  "cssls",
  -- "gopls",
  "html",
  "pyright",
  "sumneko_lua",
  "tsserver",
  "yamlls"
}
lsp_installer.setup {
  ensure_installed = ensure_servers
}
require("luasnip.loaders.from_vscode").lazy_load()

-- register servers
local installed_servers = require("nvim-lsp-installer.servers").get_installed_servers()
for _, server in ipairs(installed_servers) do
  if server.name == "html" then
    nvim_lsp[server.name].setup {
      on_attach = cfg.on_attach,
      capabilities = cfg.capabilities,
      filetypes = {
        "html",
        "handlebars"
      }
    }
  elseif server.name == "rust_analyzer" then
    -- do nothing. let rust tools set this up
  elseif server.name == 'dartls' then
    -- do nothing
  else
    nvim_lsp[server.name].setup {
      on_attach = cfg.on_attach,
      capabilities = cfg.capabilities
    }
  end
end

require("flutter-tools").setup {
  lsp = {
    on_attach = function ()
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('n', '<leader>R', '<cmd>FlutterRestart<CR>', opts)
    end
  }
}

require("rust-tools").setup {
  server = {
    on_attach = cfg.on_attach,
    capabilities = cfg.capabilities,
    settings = {
      ["rust_analyzer"] = {
        checkOnSave = {
          command = "clippy",
        }
      }
    }
  }
}

require "lsp_signature".setup({
})
