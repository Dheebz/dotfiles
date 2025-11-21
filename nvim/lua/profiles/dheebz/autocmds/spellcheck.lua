-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Enable Spellcheck for Certain Filetypes                               ┃
-- ┃  File: ~/.config/nvim/lua/autocmds/spellcheck.lua                      ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

vim.api.nvim_create_autocmd("FileType", {
	desc = "Enable spellcheck for text, markdown, and gitcommit",
	group = vim.api.nvim_create_augroup("Spellcheck", { clear = true }),
	pattern = { "gitcommit", "markdown", "text" },
	callback = function()
		vim.opt_local.spell = true
	end,
})

-- 🏁 End of File: ~/.config/nvim/lua/autocmds/spellcheck.lua
