-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Auto-create Missing Directories on Save                               ┃
-- ┃  File: ~/.config/nvim/lua/autocmds/mkdir-on-save.lua                   ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Automatically create missing directories before saving",
	group = vim.api.nvim_create_augroup("MkdirOnSave", { clear = true }),
	callback = function()
		local dir = vim.fn.expand("<afile>:p:h")
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
	end,
})

-- 🏁 End of File: ~/.config/nvim/lua/autocmds/mkdir-on-save.lua
