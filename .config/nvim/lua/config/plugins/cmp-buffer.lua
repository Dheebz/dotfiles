local flags = require("config.flags")

return {
  "hrsh7th/cmp-buffer",
  enabled = flags.cmp_buffer,
  event = "InsertEnter",
  dependencies = { "hrsh7th/nvim-cmp" },
}

