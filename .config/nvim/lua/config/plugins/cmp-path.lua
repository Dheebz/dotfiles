local flags = require("config.flags")

return {
  "hrsh7th/cmp-path",
  enabled = flags.cmp_path,
  event = "InsertEnter",
  dependencies = { "hrsh7th/nvim-cmp" },
}
