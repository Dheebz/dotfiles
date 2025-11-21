-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Comment.nvim Keymaps (Profile Specific)                               ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/keybinds/comment.lua         ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return function()
	local map = vim.keymap.set
	local ok, comment = pcall(require, "Comment.api")

	if not ok then
		vim.notify("Comment.nvim not loaded!", vim.log.levels.WARN)
		return
	end

	-- 🔥 Comment toggle current line
	map("n", "gcc", function()
		comment.toggle.linewise.current()
	end, { desc = "Toggle Comment Line" })

	-- 🔥 Comment toggle visual selection
	map("v", "gc", function()
		comment.toggle.linewise(vim.fn.visualmode())
	end, { desc = "Toggle Comment Selection" })
end

-- End of File: ~/.config/nvim/lua/profiles/dheebz/keybinds/comment.lua
