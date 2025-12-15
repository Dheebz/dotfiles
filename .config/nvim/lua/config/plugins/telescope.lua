local flags = require("config.flags")

return {
  "nvim-telescope/telescope.nvim",
  enabled = flags.telescope,
  cmd = "Telescope",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    defaults = {
      file_ignore_patterns = { "%.git/" },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob",
        "!.git/*",
      },
    },
    pickers = {
      find_files = {
        hidden = true,
      },
    },
  },
}
