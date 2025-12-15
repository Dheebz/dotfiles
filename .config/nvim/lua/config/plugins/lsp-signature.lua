local flags = require("config.flags")

return {
  "ray-x/lsp_signature.nvim",
  enabled = flags.lsp_signature,
  event = "LspAttach",
  opts = {},
}
