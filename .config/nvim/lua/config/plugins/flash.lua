local flags = require("config.flags")

return {
  "folke/flash.nvim",
  enabled = flags.flash,
  event = "VeryLazy",
  opts = {},
}
