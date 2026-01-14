return {
  {
    "williamboman/mason.nvim",
    enabled = true,
    build = ":MasonUpdate",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    enabled = true,
    dependencies = { "williamboman/mason.nvim" },
  },
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("lsp").setup()
    end,
  },
}
