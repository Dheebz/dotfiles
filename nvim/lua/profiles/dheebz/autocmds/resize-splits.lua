-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Auto Resize Splits on VimResized Event                                 ┃
-- ┃  File: ~/.config/nvim/lua/autocmds/resize-splits.lua                    ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

vim.api.nvim_create_autocmd("VimResized", {
	desc = "Equalize window splits when the terminal is resized",
	group = vim.api.nvim_create_augroup("ResizeSplits", { clear = true }),
	callback = function()
		vim.cmd("wincmd =")
	end,
})

-- 🏁 End of File: ~/.config/nvim/lua/autocmds/resize-splits.lua
