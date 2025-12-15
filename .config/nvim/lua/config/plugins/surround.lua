local flags = require("config.flags")

return {
  "kylechui/nvim-surround",
  enabled = flags.surround,
  event = "VeryLazy",
  opts = {},
}
