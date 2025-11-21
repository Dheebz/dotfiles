-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Mason Tool Installer                                                 ┃
-- ┃  Ensures external tools are installed via Mason                       ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/plugins/mason-tool-installer.lua ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  enabled = true,
  lazy = false,
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = {
        "lua-language-server",
        -- add formatters/linters here later (e.g., "stylua", "black")
      },
      auto_update = false,
      run_on_start = true,
    })
  end,
}

-- End of File: ~/.config/nvim/lua/profiles/dheebz/plugins/mason-tool-installer.lua
