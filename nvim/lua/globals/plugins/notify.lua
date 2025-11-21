-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Notify Plugin (Global)                                               ┃
-- ┃  Description: Configuration for the "nvim-notify" plugin,             ┃
-- ┃  providing a fancy notification manager for Neovim.                   ┃
-- ┃  File: ~/.config/nvim/lua/globals/plugins/notify.lua                  ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
  "rcarriga/nvim-notify",
  enabled = true,     
  event = "VeryLazy",
  config = function()
    local notify = require("notify")
    notify.setup({
      stages = "fade_in_slide_out",  -- Animation style
      background_colour = "#000000", -- Prevent transparent backgrounds being unreadable
      timeout = 1000,                -- Notification display time
      render = "compact",            -- You can try "default", "minimal", "compact", or "wrapped"
    })

    -- 👇 Override the built-in notify function
    vim.notify = notify
  end,
}
-- End of File: ~/.config/nvim/lua/globals/plugins/notify.lua