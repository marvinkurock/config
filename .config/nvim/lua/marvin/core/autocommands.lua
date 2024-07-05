local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 200,
        })
    end,
})

autocmd('VimEnter', {
  callback = function(data)
    local isDir = vim.fn.isdirectory(data.file) == 1
    if not isDir then
      return
    end
    vim.cmd.cd(data.file)
  end
})
