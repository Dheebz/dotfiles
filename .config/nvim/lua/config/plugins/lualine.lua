local flags = require("config.flags")

return {
  "nvim-lualine/lualine.nvim",
  enabled = flags.lualine,
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      icons_enabled = true,
      globalstatus = true,
    },
  },
}