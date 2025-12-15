local flags = require("config.flags")

return {
  "williamboman/mason.nvim",
  enabled = flags.mason,
  cmd = "Mason",
  opts = {
    ui = {
      border = "rounded",
    },
  },
}
