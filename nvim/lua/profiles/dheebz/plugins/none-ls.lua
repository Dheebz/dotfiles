-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  none-ls (null-ls fork)                                              ┃
-- ┃  Hook external formatters/linters into LSP                            ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/plugins/none-ls.lua         ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
  "nvimtools/none-ls.nvim",
  enabled = true,
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- Add builtins here later, e.g.:
        -- null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.black,
      },
    })
  end,
}

-- End of File: ~/.config/nvim/lua/profiles/dheebz/plugins/none-ls.lua
