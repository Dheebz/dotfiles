local flags = require("config.flags")

return {
  "numToStr/Comment.nvim",
  enabled = flags.comment,
  event = "VeryLazy",
  opts = {},
}
