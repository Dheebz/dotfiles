local flags = require("config.flags")

return {
  "folke/twilight.nvim",
  enabled = flags.twilight,
  cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
  opts = {},
}

