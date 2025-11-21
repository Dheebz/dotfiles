-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  LSP Keymaps                                                          ┃
-- ┃  Global keybindings for common LSP actions                            ┃
-- ┃  File: ~/.config/nvim/lua/globals/keybinds/lsp.lua                    ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}
M.enabled = true

function M.setup()
  local map = vim.keymap.set

  local function opts(desc)
    return { noremap = true, silent = true, desc = "[lsp] " .. desc }
  end

  -- Go to / info
  map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
  map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
  map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
  -- moved references off plain `gr` to avoid overlap
  map("n", "<leader>lr", vim.lsp.buf.references, opts("List references"))
  map("n", "K", vim.lsp.buf.hover, opts("Hover"))

  -- Workspace symbols
  map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts("Workspace symbols"))

  -- Rename / code actions
  map("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename symbol"))
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))

  -- Diagnostics
  map("n", "[d", vim.diagnostic.goto_prev, opts("Previous diagnostic"))
  map("n", "]d", vim.diagnostic.goto_next, opts("Next diagnostic"))
  map("n", "<leader>dd", vim.diagnostic.open_float, opts("Line diagnostics"))
  map("n", "<leader>dq", vim.diagnostic.setloclist, opts("Diagnostics to loclist"))

  -- Format (use LSP client that supports it)
  map({ "n", "v" }, "<leader>ff", function()
    vim.lsp.buf.format({ async = true })
  end, opts("Format buffer"))
end

return M

-- End of File: ~/.config/nvim/lua/globals/keybinds/lsp.lua
