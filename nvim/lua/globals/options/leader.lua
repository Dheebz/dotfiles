-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Leader Key Setup                                                     ┃
-- ┃  Sets the global mapleader and maplocalleader                         ┃
-- ┃  File: ~/.config/nvim/lua/globals/options/leader.lua                  ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}
M.enabled = true

M.setup = function()
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "
end

return M

-- End of File: ~/.config/nvim/lua/globals/options/leader.lua
