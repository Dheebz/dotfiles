return {
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      local leap = require("leap")
      leap.setup({})

      vim.keymap.set({ "n", "x", "o" }, "s", function()
        leap.leap({ target_windows = { vim.api.nvim_get_current_win() } })
      end, { desc = "Leap forward" })

      vim.keymap.set({ "n", "x", "o" }, "S", function()
        leap.leap({ target_windows = vim.api.nvim_list_wins() })
      end, { desc = "Leap across windows" })
    end,
  },
}
