local signs = {
  Error = '',
  Warn = '',
  Hint = '',
  Info = '',
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
