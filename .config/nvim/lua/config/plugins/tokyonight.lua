local flags = require("config.flags")

return {
  "folke/tokyonight.nvim",
  enabled = flags.tokyonight,
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight")

    -- Hard force transparency (terminal is the source of truth)
    local groups = {
      "Normal",
      "NormalNC",
      "SignColumn",
      "EndOfBuffer",
      "LineNr",
      "CursorLineNr",
      "FoldColumn",
      "VertSplit",

      -- Floating windows / popups
      "NormalFloat",
      "FloatBorder",

      -- Common plugin windows
      "TelescopeNormal",
      "TelescopeBorder",
      "NeoTreeNormal",
      "NeoTreeNormalNC",
      "NeoTreeEndOfBuffer",
    }

    for _, g in ipairs(groups) do
      vim.api.nvim_set_hl(0, g, { bg = "none" })
    end
  end,
}
