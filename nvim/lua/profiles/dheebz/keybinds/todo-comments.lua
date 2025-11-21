-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Todo-comments.nvim Keymaps (Profile Specific)                         ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/keybinds/todo-comments.lua   ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return function()
	local map = vim.keymap.set
	local ok, todo = pcall(require, "todo-comments")

	if not ok then
		vim.notify("Todo-comments.nvim not loaded!", vim.log.levels.WARN)
		return
	end

	-- 🔥 Toggle TODO quicklist
	map("n", "<leader>td", "<cmd>TodoQuickFix<CR>", { desc = "Show TODOs in QuickFix" })

	-- 🔥 Open Telescope interface for TODOs (if Telescope is installed)
	local telescope_ok = pcall(require, "telescope")
	if telescope_ok then
		map("n", "<leader>tt", "<cmd>TodoTelescope<CR>", { desc = "Telescope TODOs" })
	end

	-- 🧠 Navigate TODOs quickly
	map("n", "]t", function()
		todo.jump_next()
	end, { desc = "Next TODO" })
	map("n", "[t", function()
		todo.jump_prev()
	end, { desc = "Previous TODO" })
end

-- End of File: ~/.config/nvim/lua/profiles/dheebz/keybinds/todo-comments.lua
