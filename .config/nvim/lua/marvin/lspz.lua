local lsp = require("lsp-zero")

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
local luasnip = require('luasnip')
local cmp_mappings = cmp.mapping.preset.insert({
  ['<C-j>'] = cmp.mapping(function()
    luasnip.expand_or_jump()
  end, { "i", "s" }),
  ['<C-k>'] = cmp.mapping(function()
    luasnip.jump(-1)
  end, { "i", "s" }),
  ['<C-l>'] = cmp.mapping(function(fallback)
    if luasnip.choice_active() then
      luasnip.change_choice(1)
    else
      fallback()
    end
  end, { "i", "s" }),
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.abort()
    else
      fallback()
    end
  end),
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  ["<Tab>"] = cmp.mapping(function(fallback)
    -- if cmp.visible() then
    --   cmp.select_next_item()
    -- elseif luasnip.expand_or_jumpable() then
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    else
      fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
    end
  end, { "i", "s" }),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
    -- if cmp.visible() then
    --   cmp.select_prev_item()
    -- elseif luasnip.jumpable(-1) then
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { "i", "s" }),
})

lsp.set_preferences({
  sign_icons = {
    error = '',
    warn = '',
    hint = '',
    info = '',
  },
  set_lsp_keymaps = { omit = { '<tab>', '<Tab>' } },
})



local lspkind = require('lspkind')
local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  luasnip = "[Lua]",
  cmp_tabnine = "[TN]",
  path = "[Path]"
}
lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind]
      local menu = source_mapping[entry.source.name]
      vim_item.menu = menu
      return vim_item
    end
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip', keyword_length = 3 },
    { name = 'buffer', keyword_length = 3 },
    { name = 'path' },
  }
})

function format()
  vim.lsp.buf.format({
    filter = function(client)
      return client.name ~= "tsserver"
    end
  })
end

function on_attach(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set("n", "<leader>cf", format, opts)
  -- vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set('n', 'gh', function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

  vim.keymap.set('n', '<leader>.', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('i', '<C-K>', function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "gr", function() vim.lsp.buf.rename() end, opts)

  -- vim.keymap.set('n', '<leader>.', '<cmd>Lspsaga code_action<cr>', opts)
  -- vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
  -- vim.keymap.set('n', 'gH', '<cmd>Lspsaga lsp_finder<CR>', opts)
  -- vim.keymap.set('i', '<C-K>', '<cmd>Lspsaga hover_doc<CR>', opts)
  -- vim.keymap.set("n", "gr", '<cmd>Lspsaga rename<CR>', opts)
end
lsp.on_attach(on_attach)

lsp.setup()

require("flutter-tools").setup {
  dev_log = {
    enabled = true,
    open_cmd = "10new", -- command to use to open the log buffer
  },
  lsp = {
    on_attach = function (client, bufnr)
      on_attach(client, bufnr)
      local opts = { noremap = true, silent = true }
      -- vim.api.nvim_set_keymap('n', '<leader>R', '<cmd>FlutterRestart<CR>', opts)
    end
  }
}
