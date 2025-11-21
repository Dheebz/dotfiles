-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Transparency Settings                                                ┃
-- ┃  Applies transparent backgrounds to various UI elements               ┃
-- ┃  File: ~/.config/nvim/lua/globals/options/transparency.lua            ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}
M.enabled = true

M.setup = function()
	vim.cmd([[
    highlight Normal ctermbg=none guibg=none
    highlight NormalNC ctermbg=none guibg=none
    highlight NonText ctermbg=none guibg=none
    highlight SignColumn ctermbg=none guibg=none
    highlight EndOfBuffer ctermbg=none guibg=none
  ]])
end

return M

-- End of File: ~/.config/nvim/lua/globals/options/transparency.lua
