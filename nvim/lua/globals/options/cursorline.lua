-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Cursorline                                                           ┃
-- ┃  Highlights the current line under the cursor                         ┃
-- ┃  File: ~/.config/nvim/lua/globals/options/cursorline.lua              ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}
M.enabled = true

M.setup = function()
	vim.opt.cursorline = true
end

return M

-- End of File: ~/.config/nvim/lua/globals/options/cursorline.lua
