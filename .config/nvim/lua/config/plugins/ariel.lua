local flags = require("config.flags")

return {
  "stevearc/aerial.nvim",
  enabled = flags.aerial,
  cmd = { "AerialToggle", "AerialOpen", "AerialClose" },
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  opts = {},
}