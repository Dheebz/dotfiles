-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Basic Options                                                        ┃
-- ┃  Core editor defaults (UI, indent, search)                            ┃
-- ┃  File: ~/.config/nvim/lua/globals/options/basics.lua                  ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
local M = {}
M.enabled = true
function M.setup()
  local o = vim.opt
  local g = vim.g
  -- Leader
  g.mapleader = " "
  g.maplocalleader = " "
end

return M