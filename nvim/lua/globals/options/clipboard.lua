-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Clipboard Integration                                                ┃
-- ┃  Uses system clipboard for yank, paste, delete                        ┃
-- ┃  File: ~/.config/nvim/lua/globals/options/clipboard.lua               ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}
M.enabled = true

M.setup = function()
	vim.opt.clipboard:append("unnamedplus")
end

return M

-- End of File: ~/.config/nvim/lua/globals/options/clipboard.lua
