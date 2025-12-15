local flags = require("config.flags")

return {
  "L3MON4D3/LuaSnip",
  enabled = flags.luasnip,
  event = "InsertEnter",
  opts = {},
}
