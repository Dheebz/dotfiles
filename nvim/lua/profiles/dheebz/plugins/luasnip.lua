-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Snippets: LuaSnip                                                   ┃
-- ┃  Snippet engine with JS regex support                                ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/plugins/luasnip.lua        ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
  "L3MON4D3/LuaSnip",
  enabled = true,
  version = "v2.*",
  build = "make install_jsregexp",
  config = function()
    local luasnip = require("luasnip")
    luasnip.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
    })
  end,
}

-- End of File: ~/.config/nvim/lua/profiles/dheebz/plugins/luasnip.lua
