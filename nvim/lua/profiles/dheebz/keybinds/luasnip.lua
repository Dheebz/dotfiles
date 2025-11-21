-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  LuaSnip Keymaps (Profile Specific)                                    ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/keybinds/luasnip.lua         ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return function()
	local map = vim.keymap.set
	local ok, ls = pcall(require, "luasnip")

	if not ok then
		vim.notify("LuaSnip not loaded!", vim.log.levels.WARN)
		return
	end

	-- 🔥 Expand or Jump Forward
	map({ "i", "s" }, "<Tab>", function()
		if ls.expand_or_jumpable() then
			ls.expand_or_jump()
		else
			return "<Tab>"
		end
	end, { expr = true, desc = "LuaSnip: Expand or Jump Forward" })

	-- 🔥 Jump Backward
	map({ "i", "s" }, "<S-Tab>", function()
		if ls.jumpable(-1) then
			ls.jump(-1)
		else
			return "<S-Tab>"
		end
	end, { expr = true, desc = "LuaSnip: Jump Backward" })
end

-- End of File: ~/.config/nvim/lua/profiles/dheebz/keybinds/luasnip.lua
