local flags = require("config.flags")

return {
  "hrsh7th/cmp-nvim-lsp",
  enabled = flags.cmp_nvim_lsp,
  event = "InsertEnter",
  dependencies = { "hrsh7th/nvim-cmp" },
}

