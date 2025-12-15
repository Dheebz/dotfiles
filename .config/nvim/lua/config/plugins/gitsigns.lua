local flags = require("config.flags")

return {
  "lewis6991/gitsigns.nvim",
  enabled = flags.gitsigns,
  event = { "BufReadPost", "BufNewFile" },
  opts = {},
}