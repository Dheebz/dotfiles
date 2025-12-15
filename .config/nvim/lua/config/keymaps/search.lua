local map = vim.keymap.set
local opts = { silent = true }


vim.keymap.set("n", "<leader>ff", function()
  local ok = pcall(require("telescope.builtin").git_files, { show_untracked = true })
  if not ok then
    require("telescope.builtin").find_files({ hidden = true })
  end
end, { silent = true, desc = "Find files (git)" })

--map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)

-- Quick: grep word under cursor
map("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", opts)
