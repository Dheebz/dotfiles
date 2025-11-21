-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Spell Checking                                                       ┃
-- ┃  Enables spellcheck with Australian English                           ┃
-- ┃  File: ~/.config/nvim/lua/globals/options/spellcheck.lua              ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}
M.enabled = true

M.setup = function()
	vim.opt.spell = true
	vim.opt.spelllang = { "en_au" }
end

return M

-- End of File: ~/.config/nvim/lua/globals/options/spellcheck.lua
