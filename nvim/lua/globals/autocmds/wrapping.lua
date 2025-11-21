-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Enable soft wrapping for selected filetypes                            ┃
-- ┃  File: ~/.config/nvim/lua/globals/autocmds/wrapping.lua                 ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local api = vim.api

-- Only load if wrapping is enabled in global config
local wrapping_enabled = require("globals.options.wrapping").enabled
if not wrapping_enabled then return end

-- Filetypes where soft wrapping should be used
local soft_wrap_filetypes = {
  "markdown",
  "text",
  "rst",
  "tex",
  "gitcommit",
}

-- Create autocommand group
api.nvim_create_augroup("SoftWrapGroup", { clear = true })

-- Set local wrapping settings on matching filetypes
api.nvim_create_autocmd("FileType", {
  group = "SoftWrapGroup",
  pattern = soft_wrap_filetypes,
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
  end,
})

-- End of File: ~/.config/nvim/lua/globals/autocmds/wrapping.lua
