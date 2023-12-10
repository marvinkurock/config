local M = {}

local function has_value(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

local disable_default_formatters = {
  "tsserver",
  -- "html"
}

local enable_auto_save = {
  -- "tsserver",
  -- "html",
  -- "rust_analyzer",
}
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
vim.api.nvim_set_keymap('n', 'üd', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', '+d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)

M.on_attach = function(client, bufnr)
  if has_value(disable_default_formatters, client.name) then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.document_range_formatting = false
  end
  --
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>Lspsaga preview_definition<CR>', { silent = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>Lspsaga rename<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-K>', '<cmd>Lspsaga hover_doc<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>.', '<cmd>Lspsaga code_action<cr>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>.', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
    vim.diagnostic.disable(bufnr)
    vim.defer_fn(function()
      vim.diagnostic.reset(nil, bufnr)
    end, 1000)
  end
  if has_value(enable_auto_save, client.name) then
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = true })")
  end
end

M.capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
M.capabilities.textDocument.completion.completionItem.snippetSupport = true -- to support css auto complete


return M
