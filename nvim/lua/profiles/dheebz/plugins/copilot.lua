-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  GitHub Copilot                                                       ┃
-- ┃  AI suggestions in insert mode                                        ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/plugins/copilot.lua         ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
  "zbirenbaum/copilot.lua",
  enabled = true,
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = { enabled = true },
      panel = { enabled = false },
    })
  end,
}

-- End of File: ~/.config/nvim/lua/profiles/dheebz/plugins/copilot.lua
