-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Line Wrapping                                                        ┃
-- ┃  Enables or disables line wrapping                                    ┃
-- ┃  File: ~/.config/nvim/lua/globals/options/wrapping.lua                ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}
M.enabled = true

M.setup = function()
	vim.opt.wrap = false
end

return M

-- End of File: ~/.config/nvim/lua/globals/options/wrapping.lua
