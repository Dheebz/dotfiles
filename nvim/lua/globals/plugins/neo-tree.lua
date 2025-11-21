-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  File Explorer: neo-tree                                              ┃
-- ┃  Modern tree-style file explorer                                      ┃
-- ┃  File: ~/.config/nvim/lua/globals/plugins/neo-tree.lua                ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = true,
  lazy = false,
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  init = function()
    -- Recommended to disable netrw when using a tree plugin
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  opts = {
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      hijack_netrw_behavior = "open_default",
    },
    window = {
      width = 32,
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)

    local map = vim.keymap.set
    local function desc(d)
      return { noremap = true, silent = true, desc = "[neo-tree] " .. d }
    end

    -- Toggle file explorer
    map("n", "<leader>ee", "<cmd>Neotree toggle<CR>", desc("Toggle explorer"))

    -- Reveal current file in explorer
    map("n", "<leader>ef", "<cmd>Neotree reveal<CR>", desc("Reveal current file"))
  end,
}

-- End of File: ~/.config/nvim/lua/globals/plugins/neo-tree.lua
