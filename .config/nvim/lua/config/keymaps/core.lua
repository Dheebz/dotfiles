local map = vim.keymap.set
local opts = { silent = true }

-- Window navigation
map("n", "<C-h>", "<C-w>h", { silent = true, desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { silent = true, desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { silent = true, desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { silent = true, desc = "Window right" })

-- File explorer
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { silent = true, desc = "Explorer toggle" })
map("n", "<leader>E", "<cmd>Neotree focus<cr>",  { silent = true, desc = "Explorer focus" })

-- Config
map("n", "<leader>sv", function()
  vim.cmd("source " .. vim.fn.stdpath("config") .. "/init.lua")
end, { silent = true, desc = "Source config (init.lua)" })

-- Wrap Text Keymap
vim.keymap.set("n", "<leader>uw", function()
  vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle wrap" })

vim.keymap.set({ "n", "x", "o" }, "<leader>j", function()
  require("flash").jump()
end, { desc = "Flash jump" })

vim.keymap.set({ "n", "x", "o" }, "<leader>J", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })
