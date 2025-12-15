local flags = require("config.flags")

return {
  "windwp/nvim-autopairs",
  enabled = flags.autopairs,
  event = "InsertEnter",
  opts = {},
}
