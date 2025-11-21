-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Telescope Fuzzy Finder                                               ┃
-- ┃  File: ~/.config/nvim/lua/globals/plugins/telescope.lua               ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
  "nvim-telescope/telescope.nvim",
  enabled = true,
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
      },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    -- All keymaps are handled in profile keybinds: profiles/dheebz/keybinds/telescope.lua
  end,
}

-- End of File: ~/.config/nvim/lua/globals/plugins/telescope.lua
