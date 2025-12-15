local flags = require("config.flags")

return {
  "folke/trouble.nvim",
  enabled = flags.trouble,
  cmd = { "Trouble", "TroubleToggle" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
}

