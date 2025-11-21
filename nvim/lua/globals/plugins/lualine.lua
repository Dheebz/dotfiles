-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Statusline: lualine                                                  ┃
-- ┃  File: ~/.config/nvim/lua/globals/plugins/lualine.lua                 ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
  "nvim-lualine/lualine.nvim",
  enabled = true,
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "tokyonight",
      section_separators = "",
      component_separators = "",
    },
  },
  config = function(_, opts)
    require("lualine").setup(opts)
  end,
}

-- End of File: ~/.config/nvim/lua/globals/plugins/lualine.lua
