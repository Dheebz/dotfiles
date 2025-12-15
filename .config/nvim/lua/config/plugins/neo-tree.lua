local flags = require("config.flags")

return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = flags.neo_tree,
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    filesystem = {
      follow_current_file = { enabled = true },
      hijack_netrw_behavior = "open_default",
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
      },
    },
    window = {
      width = 32,
    },
  },
}
