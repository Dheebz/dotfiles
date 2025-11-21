-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  which-key                                                            ┃
-- ┃  Shows pending keymaps in a popup                                     ┃
-- ┃  File: ~/.config/nvim/lua/globals/plugins/which-key.lua               ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
  "folke/which-key.nvim",
  enabled = true,
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    wk.setup({})

    -- New-style group spec (matches the healthcheck suggestion)
    wk.add({
      { "<leader>f", group = "file/search" },
    })
  end,
}

-- End of File: ~/.config/nvim/lua/globals/plugins/which-key.lua
