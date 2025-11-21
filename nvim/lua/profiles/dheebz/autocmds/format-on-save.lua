-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Format on Save Autocommand                                             ┃
-- ┃  File: ~/.config/nvim/lua/autocmds/format-on-save.lua                   ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.lua", "*.py", "*.js", "*.ts", "*.json", "*.css", "*.html", "*.toml", "*.yml", "*.yaml" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- 🏁 End of File: ~/.config/nvim/lua/autocmds/format-on-save.lua
