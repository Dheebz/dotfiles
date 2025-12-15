local flags = require("config.flags")

return {
  "akinsho/toggleterm.nvim",
  enabled = flags.toggleterm,
  cmd = { "ToggleTerm", "TermExec" },
  opts = {},
}
