-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Backspace Behavior                                                   ┃
-- ┃  Configures backspace in insert mode                                  ┃
-- ┃  File: ~/.config/nvim/lua/globals/options/backspace.lua               ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}
M.enabled = true

M.setup = function()
	vim.opt.backspace = "indent,eol,start"
end

return M

-- End of File: ~/.config/nvim/lua/globals/options/backspace.lua
