vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"

-- Commands to enable/disable autoformatting
vim.api.nvim_create_user_command("FormatDisable", function()
  vim.b.disable_autoformat = true
end, {})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
end, {})


-- Wrap Markdown GitCommit and Text 
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("UserWrapForText", { clear = true }),
  pattern = { "markdown", "gitcommit", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})

