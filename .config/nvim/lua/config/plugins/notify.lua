local flags = require("config.flags")

return {
  "rcarriga/nvim-notify",
  enabled = flags.notify,
  event = "VeryLazy",
  config = function()
    vim.notify = require("notify")
  end,
}

