-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Remove Trailing Whitespace Before Save                                ┃
-- ┃  File: ~/.config/nvim/lua/autocmds/trailing-whitespace.lua             ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Remove trailing whitespace before saving",
	group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true }),
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})

-- 🏁 End of File: ~/.config/nvim/lua/autocmds/trailing-whitespace.lua
