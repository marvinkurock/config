local lsp = require("lsp-zero")
local saga = require("lspsaga")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  -- 'eslint',
  'sumneko_lua',
  'rust_analyzer',
  'bashls',
  'yamlls',
  'cssls',
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.set_preferences({
  sign_icons = {
      Error = '',
      Warn = '',
      Hint = '',
      Info = '',
  }
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
  print(client.name)
  if client.name == 'tsserver' then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.document_range_formatting = false
  end
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set('n', '<leader>.', '<cmd>Lspsaga code_action<cr>', opts)
  vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
  vim.keymap.set('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', opts)
  vim.keymap.set('i', '<C-K>', '<cmd>Lspsaga hover_doc<CR>', opts)
  vim.keymap.set("n", "gr", '<cmd>Lspsaga rename<CR>', opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()
