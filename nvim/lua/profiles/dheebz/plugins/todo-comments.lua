-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  TODO Comments                                                        ┃
-- ┃  Highlights and searches TODO/FIXME/NOTE etc.                         ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/plugins/todo-comments.lua   ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
  "folke/todo-comments.nvim",
  enabled = true,
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup({})
  end,
}

-- End of File: ~/.config/nvim/lua/profiles/dheebz/plugins/todo-comments.lua
