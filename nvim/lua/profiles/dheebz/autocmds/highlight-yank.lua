-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Highlight Yank: Visual Feedback When Yanking                          ┃
-- ┃  File: ~/.config/nvim/lua/autocmds/highlight-yank.lua                  ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank",
	group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch", -- You can change this highlight group if you want!
			timeout = 200,
		})
	end,
})

-- 🏁 End of File: ~/.config/nvim/lua/autocmds/highlight-yank.lua
