-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Neo-tree Keymaps (Profile Specific)                                   ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/keybinds/neo-tree.lua        ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return function()
	local map = vim.keymap.set

	map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
	map("n", "<leader>ef", "<cmd>Neotree focus<CR>", { desc = "Focus Neo-tree" })
	map("n", "<leader>er", "<cmd>Neotree reveal<CR>", { desc = "Reveal file in Neo-tree" })
end

-- End of File: ~/.config/nvim/lua/profiles/dheebz/keybinds/neo-tree.lua
