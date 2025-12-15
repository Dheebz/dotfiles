local map = vim.keymap.set
local opts = { silent = true }

map("n", "<leader>tt", "<cmd>ToggleTerm<cr>", opts)
map("t", "<Esc>", [[<C-\><C-n>]], opts)
