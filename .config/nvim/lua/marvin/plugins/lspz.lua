return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },

    -- Snippets
    { 'L3MON4D3/LuaSnip' },
    { 'rafamadriz/friendly-snippets' },
  },
  config = function()
    local lsp = require("lsp-zero")
    lsp.preset({
      float_border = 'rounded',
      call_servers = 'local',
      configure_diagnostics = true,
      setup_servers_on_start = true,
      set_lsp_keymaps = { omit = { '<tab>', '<Tab>', '<C-k>' } },
      manage_nvim_cmp = {
        set_sources = 'recommended',
        set_basic_mappings = true,
        set_extra_mappings = false,
        use_luasnip = true,
        set_format = true,
        documentation_window = true,
      },
    })

    lsp.set_sign_icons({
      error = '',
      warn = '',
      hint = '',
      info = '',
    })
    require('mason').setup({})
    require('mason-lspconfig').setup({
      ensure_installed = {
        'tsserver',
        -- 'eslint',
        'rust_analyzer',
        'bashls',
        'yamlls',
        'cssls',
      },
      handlers = {
        lsp.default_setup
      }
    })


    local cmp = require('cmp')
    local luasnip = require('luasnip')
    require("luasnip.loaders.from_vscode").lazy_load()
    local cmp_mappings = cmp.mapping.preset.insert({
      -- ['<C-j>'] = cmp.mapping(function()
      --   luasnip.expand_or_jump()
      -- end, { "i", "s" }),
      -- ['<C-k>'] = cmp.mapping(function()
      --   luasnip.jump(-1)
      -- end, { "i", "s" }),
      -- ['<C-l>'] = cmp.mapping(function(fallback)
      --   if luasnip.choice_active() then
      --     luasnip.change_choice(1)
      --   else
      --     fallback()
      --   end
      -- end, { "i", "s" }),
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

    local lspkind = require('lspkind')
    local source_mapping = {
      buffer = "[Buffer]",
      nvim_lsp = "[LSP]",
      luasnip = "[Lua]",
      cmp_tabnine = "[TN]",
      path = "[Path]"
    }

    cmp.setup({
      mapping = cmp_mappings,
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }
      }, {
        { name = "buffer" }
      })
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
      -- vim.keymap.set("n", "<leader>cf", format, opts)
      -- vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
      vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
      vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float() end, opts)
      vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
      vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
      vim.keymap.set('n', 'gh', function() vim.lsp.buf.references() end, opts)
      vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)

      -- vim.keymap.set('n', '<leader>.', function() vim.lsp.buf.code_action() end, opts)
      -- vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
      -- vim.keymap.set('i', '<C-K>', function() vim.lsp.buf.hover() end, opts)
      -- vim.keymap.set("n", "gr", function() vim.lsp.buf.rename() end, opts)

      vim.keymap.set('n', '<leader>.', '<cmd>Lspsaga code_action<cr>', opts)
      vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
      vim.keymap.set('n', 'gH', '<cmd>Lspsaga finder<CR>', opts)
      vim.keymap.set('i', '<C-K>', '<cmd>Lspsaga hover_doc<CR>', opts)
      vim.keymap.set("n", "gr", '<cmd>Lspsaga rename<CR>', opts)
      -- if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
      if vim.bo[bufnr].filetype == "helm" then
        vim.diagnostic.disable(bufnr)
        vim.defer_fn(function()
          vim.diagnostic.reset(nil, bufnr)
        end, 1000)
      end
    end

    lsp.on_attach(on_attach)

    local lspconfig = require('lspconfig')
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    lspconfig.yamlls.setup({
      settings = {
        yaml = {
          keyOrdering = false
        }
      }
    })

    lspconfig.emmet_language_server.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "templ", "css", "eruby", "html", "htmldjango", "javascriptreact", "less", "pug", "sass", "scss", "typescriptreact" },
    })
    vim.filetype.add({ extension = { templ = "templ" } })

    -- lspconfig.sourcekit.setup {}


    lsp.setup()

    require("flutter-tools").setup {
      dev_log = {
        enabled = true,
        open_cmd = "10new", -- command to use to open the log buffer
      },
      lsp = {
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          local opts = { noremap = true, silent = true }
          -- vim.api.nvim_set_keymap('n', '<leader>R', '<cmd>FlutterRestart<CR>', opts)
        end
      }
    }
    vim.g.copilot_assume_mapped = true
    function leave_snippet()
      if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
          and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
          and not require('luasnip').session.jump_active
      then
        require('luasnip').unlink_current()
      end
    end

    require('lsp_signature').setup({});

    -- stop snippets when you leave to normal mode
    vim.api.nvim_command([[
        autocmd ModeChanged * lua leave_snippet()
    ]])
  end
}
