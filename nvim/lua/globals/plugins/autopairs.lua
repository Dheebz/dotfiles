-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  nvim-autopairs                                                       ┃
-- ┃  Auto-close brackets and quotes                                      ┃
-- ┃  File: ~/.config/nvim/lua/globals/plugins/autopairs.lua               ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
  "windwp/nvim-autopairs",
  enabled = true,
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({})
  end,
}

-- End of File: ~/.config/nvim/lua/globals/plugins/autopairs.lua
