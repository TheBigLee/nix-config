local autocmd = vim.api.nvim_create_autocmd

-- Git commit colorcolumn
autocmd("FileType", {
  pattern = "gitcommit",
  command = "setlocal colorcolumn=80",
})

-- Go format on save
autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format()
  end,
})
