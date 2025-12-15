local flags = require("config.flags")

return {
  "folke/which-key.nvim",
  enabled = flags.which_key,
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Group labels only (actual keymaps live in keymap files)
    wk.add({
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>t", group = "terminal" },
      { "<leader>x", group = "diagnostics" },
      { "<leader>c", group = "code" },
      { "<leader>s", group = "source/sync" },
    })
  end,
}

