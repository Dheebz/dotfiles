-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Theme and Colorscheme Options                                        ┃
-- ┃  Configures background, termguicolors, signcolumn                     ┃
-- ┃  File: ~/.config/nvim/lua/globals/options/theme.lua                   ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}
M.enabled = true

M.setup = function()
	vim.opt.termguicolors = true
	vim.opt.background = "dark"
	vim.opt.signcolumn = "yes"
end

return M

-- End of File: ~/.config/nvim/lua/globals/options/theme.lua
