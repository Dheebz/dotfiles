-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Swapfile Settings                                                    ┃
-- ┃  Disables swapfile creation                                           ┃
-- ┃  File: ~/.config/nvim/lua/globals/options/swapfile.lua                ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}
M.enabled = true

M.setup = function()
	vim.opt.swapfile = false
end

return M

-- End of File: ~/.config/nvim/lua/globals/options/swapfile.lua
