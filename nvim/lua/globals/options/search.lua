-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Search Behavior                                                      ┃
-- ┃  Configures ignorecase and smartcase search settings                  ┃
-- ┃  File: ~/.config/nvim/lua/globals/options/search.lua                  ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}
M.enabled = true

M.setup = function()
	vim.opt.ignorecase = true
	vim.opt.smartcase = true
end

return M

-- End of File: ~/.config/nvim/lua/globals/options/search.lua
