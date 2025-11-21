-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  GitSigns Keymaps (Profile Specific)                                   ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/keybinds/git-signs.lua       ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return function()
	local map = vim.keymap.set
	local gs = require("gitsigns")

	-- 🔥 Navigation
	map("n", "]c", function()
		gs.next_hunk()
	end, { desc = "Next Hunk" })
	map("n", "[c", function()
		gs.prev_hunk()
	end, { desc = "Previous Hunk" })

	-- 🛠 Actions
	map("n", "<leader>hs", function()
		gs.stage_hunk()
	end, { desc = "Stage Hunk" })
	map("n", "<leader>hr", function()
		gs.reset_hunk()
	end, { desc = "Reset Hunk" })
	map("n", "<leader>hS", function()
		gs.stage_buffer()
	end, { desc = "Stage Buffer" })
	map("n", "<leader>hu", function()
		gs.undo_stage_hunk()
	end, { desc = "Undo Stage Hunk" })
	map("n", "<leader>hR", function()
		gs.reset_buffer()
	end, { desc = "Reset Buffer" })

	-- 📜 Preview / Blame
	map("n", "<leader>hp", function()
		gs.preview_hunk()
	end, { desc = "Preview Hunk" })
	map("n", "<leader>hb", function()
		gs.blame_line()
	end, { desc = "Blame Line" })
end

-- End of File: ~/.config/nvim/lua/profiles/dheebz/keybinds/git-signs.lua
