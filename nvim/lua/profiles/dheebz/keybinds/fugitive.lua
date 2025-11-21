-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Fugitive (Git) Keymaps (Profile Specific)                             ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/keybinds/fugitive.lua        ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return function()
	local map = vim.keymap.set

	-- 🔥 Git Status (Fugitive's main interface)
	map("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Fugitive Git Status" })

	-- 🔥 Git Blame current file
	map("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Fugitive Git Blame" })

	-- 🔥 View commit history for current file
	map("n", "<leader>gh", "<cmd>Gclog<CR>", { desc = "Fugitive Git History (file)" })

	-- 🔥 Open Git diff
	map("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { desc = "Fugitive Git Diff Split" })
end

-- End of File: ~/.config/nvim/lua/profiles/dheebz/keybinds/fugitive.lua
