-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Line Numbering                                                       ┃
-- ┃  Enables absolute and relative line numbers                           ┃
-- ┃  File: ~/.config/nvim/lua/globals/options/line_numbering.lua          ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}
M.enabled = true

M.setup = function()
	vim.opt.number = true
	vim.opt.relativenumber = true
end

return M

-- End of File: ~/.config/nvim/lua/globals/options/line_numbering.lua
