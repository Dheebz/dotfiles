-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Global Autocmds                                                      ┃
-- ┃  Editor-wide behaviour (yank highlight, resize splits, etc.)         ┃
-- ┃  File: ~/.config/nvim/lua/globals/autocmds/core.lua                   ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local api = vim.api

-- Highlight on yank
api.nvim_create_augroup("GlobalYankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  group = "GlobalYankHighlight",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Resize splits when the terminal window is resized
api.nvim_create_augroup("GlobalResizeSplits", { clear = true })
api.nvim_create_autocmd("VimResized", {
  group = "GlobalResizeSplits",
  command = "tabdo wincmd =",
})

return {}

-- End of File: ~/.config/nvim/lua/globals/autocmds/core.lua

