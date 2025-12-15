local map = vim.keymap.set
local opts = { silent = true }

map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", opts)
map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", opts)
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", opts)
