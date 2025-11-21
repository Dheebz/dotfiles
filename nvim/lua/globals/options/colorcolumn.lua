-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Color Column and Winblend                                            ┃
-- ┃  Sets character limit guide and window transparency                   ┃
-- ┃  File: ~/.config/nvim/lua/globals/options/colorcolumn.lua             ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}
M.enabled = true

M.setup = function()
	vim.opt.colorcolumn = "108"
	vim.opt.winblend = 10
end

return M

-- End of File: ~/.config/nvim/lua/globals/options/colorcolumn.lua
