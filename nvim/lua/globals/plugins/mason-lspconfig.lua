-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Mason LSP Config                                                     ┃
-- ┃  Installs & wires LSP servers via Mason                               ┃
-- ┃  File: ~/.config/nvim/lua/globals/plugins/mason-lspconfig.lua         ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
  "williamboman/mason-lspconfig.nvim",
  enabled = true,
  lazy = false,
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
      },
      automatic_installation = true,
    })
  end,
}

-- End of File: ~/.config/nvim/lua/globals/plugins/mason-lspconfig.lua

