-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Window Split Behavior                                                ┃
-- ┃  Controls split direction for new windows                             ┃
-- ┃  File: ~/.config/nvim/lua/globals/options/splits.lua                  ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}
M.enabled = true

M.setup = function()
	vim.opt.splitright = true -- Vertical splits to the right
	vim.opt.splitbelow = true -- Horizontal splits to the bottom
end

return M

-- End of File: ~/.config/nvim/lua/globals/options/splits.lua
