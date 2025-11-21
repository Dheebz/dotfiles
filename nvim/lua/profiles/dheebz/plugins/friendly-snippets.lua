-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Snippet Collection: friendly-snippets                               ┃
-- ┃  Prebuilt VSCode-style snippets                                      ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/plugins/friendly-snippets.lua ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
  "rafamadriz/friendly-snippets",
  enabled = true,
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}

-- End of File: ~/.config/nvim/lua/profiles/dheebz/plugins/friendly-snippets.lua
