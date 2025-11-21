-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Telescope Keymaps (Profile Specific)                                 ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/keybinds/telescope.lua      ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}
M.enabled = true

function M.setup()
  local map = vim.keymap.set

  map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "[telescope] Find files" })
  map("n", "<leader>fs", "<cmd>Telescope live_grep<CR>", { desc = "[telescope] Live grep" })
  map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "[telescope] Buffers" })
  map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "[telescope] Help tags" })
  map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "[telescope] Recent files" })

  -- 🔥 Conditional mapping: only if todo-comments is available
  local ok, _ = pcall(require, "todo-comments")
  if ok then
    map("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "[telescope] TODOs" })
  end
end

return M

-- End of File: ~/.config/nvim/lua/profiles/dheebz/keybinds/telescope.lua
