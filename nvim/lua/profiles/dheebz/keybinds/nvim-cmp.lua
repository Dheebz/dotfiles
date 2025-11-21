-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  nvim-cmp Keymaps (Profile Specific)                                   ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/keybinds/nvim-cmp.lua        ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return function()
	local cmp_ok, cmp = pcall(require, "cmp")
	if not cmp_ok then
		vim.notify("nvim-cmp not loaded!", vim.log.levels.WARN)
		return
	end

	local map = vim.keymap.set

	-- 🔥 Completion Navigation inside cmp menu
	map("i", "<Tab>", function()
		if cmp.visible() then
			cmp.select_next_item()
		else
			return "<Tab>"
		end
	end, { expr = true, desc = "CMP: Next item" })

	map("i", "<S-Tab>", function()
		if cmp.visible() then
			cmp.select_prev_item()
		else
			return "<S-Tab>"
		end
	end, { expr = true, desc = "CMP: Previous item" })

	-- 🔥 Confirm completion
	map("i", "<CR>", function()
		if cmp.visible() then
			cmp.confirm({ select = true })
		else
			return "<CR>"
		end
	end, { expr = true, desc = "CMP: Confirm completion" })

	-- 🧠 Manually trigger completion menu
	map("i", "<C-Space>", function()
		cmp.complete()
	end, { desc = "CMP: Trigger completion menu" })
end

-- End of File: ~/.config/nvim/lua/profiles/dheebz/keybinds/nvim-cmp.lua
