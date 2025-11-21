-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Trouble.nvim Keymaps (Profile Specific)                               ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/keybinds/trouble.lua         ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return function()
  local map = vim.keymap.set

  map("n", "<leader>xx", "<cmd>Trouble<CR>", { desc = "Toggle Trouble window" })
  map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<CR>", { desc = "Workspace Diagnostics" })
  map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<CR>", { desc = "Document Diagnostics" })
  map("n", "<leader>xr", "<cmd>Trouble lsp_references<CR>", { desc = "LSP References" })
  map("n", "<leader>xq", "<cmd>Trouble quickfix<CR>", { desc = "Quickfix List" })
  map("n", "<leader>xl", "<cmd>Trouble loclist<CR>", { desc = "Location List" })
end

-- End of File: ~/.config/nvim/lua/profiles/dheebz/keybinds/trouble.lua
