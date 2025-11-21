-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Auto-open Quickfix List if :make Fails                                ┃
-- ┃  File: ~/.config/nvim/lua/autocmds/quickfix-autoopen.lua               ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	desc = "Open quickfix list automatically after :make if there are errors",
	group = vim.api.nvim_create_augroup("QuickfixAutoOpen", { clear = true }),
	pattern = { "make" },
	callback = function()
		if #vim.fn.getqflist() > 0 then
			vim.cmd("copen")
		end
	end,
})

-- 🏁 End of File: ~/.config/nvim/lua/autocmds/quickfix-autoopen.lua
