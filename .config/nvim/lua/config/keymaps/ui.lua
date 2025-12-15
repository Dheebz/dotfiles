local map = vim.keymap.set
local opts = { silent = true }

map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
