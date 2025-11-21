-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Mason LSP Config                                                     ┃
-- ┃  Bridges Mason-installed servers to Neovim LSP                        ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/plugins/mason-lspconfig.lua ┃
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

-- End of File: ~/.config/nvim/lua/profiles/dheebz/plugins/mason-lspconfig.lua
