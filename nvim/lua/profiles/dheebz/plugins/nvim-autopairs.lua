-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  nvim-autopairs                                                       ┃
-- ┃  Auto-close brackets, quotes, etc.                                   ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/plugins/nvim-autopairs.lua  ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
  "windwp/nvim-autopairs",
  enabled = true,
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({})
  end,
}

-- End of File: ~/.config/nvim/lua/profiles/dheebz/plugins/nvim-autopairs.lua
