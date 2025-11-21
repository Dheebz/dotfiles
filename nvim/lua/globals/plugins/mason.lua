-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Mason                                                                ┃
-- ┃  LSP/DAP/formatter installer                                          ┃
-- ┃  File: ~/.config/nvim/lua/globals/plugins/mason.lua                   ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
  "williamboman/mason.nvim",
  enabled = true,
  lazy = false,
  config = function()
    require("mason").setup({})
  end,
}

-- End of File: ~/.config/nvim/lua/globals/plugins/mason.lua
