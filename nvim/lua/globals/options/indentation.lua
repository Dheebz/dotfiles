-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Tabs and Indentation                                                 ┃
-- ┃  Configures tab width, expandtab, and indentation behavior            ┃
-- ┃  File: ~/.config/nvim/lua/globals/options/indentation.lua             ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}
M.enabled = true

M.setup = function()
	local opt = vim.opt
	opt.tabstop = 4
	opt.shiftwidth = 4
	opt.expandtab = true
	opt.autoindent = false
end

return M

-- End of File: ~/.config/nvim/lua/globals/options/indentation.lua
