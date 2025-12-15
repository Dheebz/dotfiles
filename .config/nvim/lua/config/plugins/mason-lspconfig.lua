local flags = require("config.flags")

return {
  "mason-org/mason-lspconfig.nvim",
  enabled = flags.mason_lspconfig,
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    ensure_installed = {
      "lua_ls",
      "bashls",
      "ruff",
      "ty",
    },
    automatic_installation = true,

    -- Important: we enable servers ourselves via vim.lsp.enable()
    automatic_enable = false,
  },
}
