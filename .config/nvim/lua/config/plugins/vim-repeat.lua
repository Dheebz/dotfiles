local flags = require("config.flags")

return {
  "tpope/vim-repeat",
  enabled = flags.vim_repeat,
  event = "VeryLazy",
}
