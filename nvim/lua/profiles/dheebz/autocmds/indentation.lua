-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Set Indentation per Filetype                                          ┃
-- ┃  File: ~/.config/nvim/lua/autocmds/indentation.lua                     ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

vim.api.nvim_create_autocmd("FileType", {
	desc = "Set indentation rules per filetype",
	group = vim.api.nvim_create_augroup("Indentation", { clear = true }),
	callback = function()
		local ft = vim.bo.filetype
		if ft == "lua" or ft == "javascript" or ft == "typescript" or ft == "json" then
			vim.opt_local.shiftwidth = 2
			vim.opt_local.tabstop = 2
			vim.opt_local.expandtab = true
		elseif ft == "python" or ft == "go" then
			vim.opt_local.shiftwidth = 4
			vim.opt_local.tabstop = 4
			vim.opt_local.expandtab = true
		end
	end,
})

-- 🏁 End of File: ~/.config/nvim/lua/autocmds/indentation.lua
