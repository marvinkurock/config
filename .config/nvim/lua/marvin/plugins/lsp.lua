return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },
    { "ray-x/lsp_signature.nvim" },

    -- Snippets
    { 'L3MON4D3/LuaSnip' },
    { 'rafamadriz/friendly-snippets' },
  },
  config = function()
    -- SETUP
    require('lspconfig.ui.windows').default_options = {
      border = "rounded"
    }

    local ensure_servers = {
      "bashls",
      "html",
      "tsserver",
      "yamlls",
    }

    local nvim_lsp = require 'lspconfig'
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    luasnip.config.setup {
      update_events = "TextChanged,TextChangedI",
    }
    require("luasnip.loaders.from_vscode").lazy_load()
    require("mason").setup()
    require("mason-lspconfig").setup {
      ensure_installed = ensure_servers
    }

    -- CONFIG
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.completion.completionItem.snippetSupport = true -- to support css auto complete

    local function on_attach(client, bufnr)
      local opts = { buffer = bufnr, remap = false }
      vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
      vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float() end, opts)
      vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
      vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
      vim.keymap.set('n', 'gh', function() vim.lsp.buf.references() end, opts)
      vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)

      vim.keymap.set('n', '<leader>.', '<cmd>Lspsaga code_action<cr>', opts)
      vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
      vim.keymap.set('n', 'gH', '<cmd>Lspsaga finder<CR>', opts)
      vim.keymap.set('i', '<C-K>', '<cmd>Lspsaga hover_doc<CR>', opts)
      vim.keymap.set("n", "gr", '<cmd>Lspsaga rename<CR>', opts)

      if client.name == "htmx" then
        client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
      end

      if vim.bo[bufnr].filetype == "helm" then
        vim.diagnostic.disable(bufnr)
        vim.defer_fn(function()
          vim.diagnostic.reset(nil, bufnr)
        end, 1000)
      end
    end
    require("mason-lspconfig").setup_handlers({
      function(server_name)
        nvim_lsp[server_name].setup {
          on_attach = on_attach,
          capabilities = capabilities
        }
      end,
      ["lua_ls"] = function()
        nvim_lsp.lua_ls.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" }
              }
            }
          }
        })
      end,
      ["emmet_language_server"] = function()
        nvim_lsp.emmet_language_server.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          filetypes = { "templ", "css", "eruby", "html", "htmldjango", "javascriptreact", "less", "pug", "sass", "scss", "typescriptreact" },
        })
      end,
      ["yamlls"] = function()
        nvim_lsp.yamlls.setup({
          settings = {
            yaml = {
              keyOrdering = false
            }
          }
        })
      end
    })

    local cmp_mappings = cmp.mapping.preset.insert({
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
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    })

    cmp.setup({
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          luasnip.lsp_expand(args.body) -- For `luasnip` users.
          -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
          -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
      },
      mapping = cmp_mappings,
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }
      }, {
        { name = "buffer" }
      })
    })
    require "lsp_signature".setup({
      zindex = 20
    })



    -- ADDITIONAL FILETYPES
    vim.filetype.add({ extension = { templ = "templ" } })

    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )

    -- SIGNS
    local signs = {
      Error = '',
      Warn = '',
      Hint = '',
      Info = '',
    }

    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    vim.diagnostic.config({
      underline = true,
      signs = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        focusable = false,
        -- header = { 'Diagnostics:', 'Normal' },
        -- source = 'always',
      },
      virtual_text = true
    })

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
    })

    -- SNIPPET FIX
    function Leave_snippet()
      if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
          and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
          and not require('luasnip').session.jump_active
      then
        require('luasnip').unlink_current()
      end
    end

    -- stop snippets when you leave to normal mode
    vim.api.nvim_command([[
        autocmd ModeChanged * lua Leave_snippet()
    ]])
  end
}
