local flags = require("config.flags")

return {
  "saadparwaiz1/cmp_luasnip",
  enabled = flags.cmp_luasnip,
  event = "InsertEnter",
  dependencies = { "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip" },
}

