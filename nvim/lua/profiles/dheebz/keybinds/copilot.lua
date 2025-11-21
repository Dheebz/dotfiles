-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  GitHub Copilot Keybindings                                             ┃
-- ┃  File: ~/.config/nvim/lua/keymaps/github_copilot.lua                    ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true, expr = true }

-- Accept suggestion
keymap("i", "<C-j>", 'copilot#Accept()', {
  silent = true,
  expr = true,
  noremap = true,
  replace_keycodes = false,
  desc = "Accept Copilot suggestion"
})


keymap("n", "<leader>ce", ":Copilot enable<CR>", { desc = "Enable Copilot" })
keymap("n", "<leader>cd", ":Copilot disable<CR>", { desc = "Disable Copilot" })
keymap("n", "<leader>cs", ":Copilot status<CR>", { desc = "Copilot Status" })


-- Optional: Manually trigger Copilot auth and status
-- keymap("n", "<leader>ca", ":Copilot auth<CR>", { noremap = true, silent = true, desc = "Copilot Auth" })
-- keymap("n", "<leader>cs", ":Copilot status<CR>", { noremap = true, silent = true, desc = "Copilot Status" })
-- keymap("n", "<leader>ce", ":Copilot enable<CR>", { noremap = true, silent = true, desc = "Enable Copilot" })
-- keymap("n", "<leader>cd", ":Copilot disable<CR>", { noremap = true, silent = true, desc = "Disable Copilot" })

-- End of File: ~/.config/nvim/lua/keymaps/github_copilot.lua
