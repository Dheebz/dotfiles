-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  LSP Server: lua_ls                                                   ┃
-- ┃  Language server for Lua (Neovim config aware)                        ┃
-- ┃  File: ~/.config/nvim/lua/globals/lsp/servers/lua_ls.lua              ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}
M.enabled = true

function M.setup()
  -- Shared capabilities (no cmp yet; keep it simple)
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
        },
      },
    },
  })

  -- Enable this server
  vim.lsp.enable({ "lua_ls" })
end

return M

-- End of File: ~/.config/nvim/lua/globals/lsp/servers/lua_ls.lua
