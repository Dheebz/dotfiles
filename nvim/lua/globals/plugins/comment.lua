-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Comment.nvim                                                         ┃
-- ┃  Toggle comments with gc / gcc                                       ┃
-- ┃  File: ~/.config/nvim/lua/globals/plugins/comment.lua                 ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
  "numToStr/Comment.nvim",
  enabled = true,
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("Comment").setup()
  end,
}

-- End of File: ~/.config/nvim/lua/globals/plugins/comment.lua

