-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Mason                                                                ┃
-- ┃  Installer for LSP / DAP / formatters / linters                      ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/plugins/mason.lua           ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
  "williamboman/mason.nvim",
  enabled = true,
  lazy = false,
  config = function()
    require("mason").setup({})
  end,
}

-- End of File: ~/.config/nvim/lua/profiles/dheebz/plugins/mason.lua
