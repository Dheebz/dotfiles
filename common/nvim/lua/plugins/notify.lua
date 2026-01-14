return {
  {
    "rcarriga/nvim-notify",
    enabled = true,
    event = "VeryLazy",
    opts = {
      render = "minimal",
      stages = "fade_in_slide_out",
      timeout = 2000,
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify
    end,
  },
}
