-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Enable Wrap and Spell for Git Commit Messages                         ┃
-- ┃  File: ~/.config/nvim/lua/autocmds/gitcommit-wrap.lua                  ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

vim.api.nvim_create_autocmd("FileType", {
	desc = "Enable wrap and spell for gitcommit filetype",
	group = vim.api.nvim_create_augroup("GitCommitWrap", { clear = true }),
	pattern = { "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- 🏁 End of File: ~/.config/nvim/lua/autocmds/gitcommit-wrap.lua
