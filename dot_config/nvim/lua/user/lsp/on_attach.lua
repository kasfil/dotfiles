return function(_, bufnr)
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

  vim.api.nvim_create_augroup("lsp_on_attach", { clear = true })
  vim.api.nvim_create_autocmd("InsertEnter", {
    buffer = bufnr,
    callback = function() vim.lsp.inlay_hint(bufnr, true) end,
    group = "lsp_on_attach",
  })
  vim.api.nvim_create_autocmd("InsertLeave", {
    buffer = bufnr,
    callback = function() vim.lsp.inlay_hint(bufnr, false) end,
    group = "lsp_on_attach",
  })
end
