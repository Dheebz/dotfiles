local flags = require("config.flags")

return {
  "folke/todo-comments.nvim",
  enabled = flags.todo_comments,
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
}
