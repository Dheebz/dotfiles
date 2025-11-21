-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Disable Auto Comment Continuation on New Line                         ┃
-- ┃  File: ~/.config/nvim/lua/autocmds/disable-auto-comment.lua            ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Disable auto-comment continuation on new line",
	group = vim.api.nvim_create_augroup("DisableAutoComment", { clear = true }),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- 🏁 End of File: ~/.config/nvim/lua/autocmds/disable-auto-comment.lua
