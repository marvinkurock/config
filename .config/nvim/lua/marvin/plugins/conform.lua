return {
  "stevearc/conform.nvim",
  event = { "BufRead", "BufNewFile" },
  config = function ()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500
      },
    })
    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500
      })
    end, { desc = "Format file or range (invisual mode)"})
  end
}
