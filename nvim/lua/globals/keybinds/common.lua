local M = {}
M.enabled = true

M.setup = function()
	local keymap = vim.keymap -- for conciseness
	local opts = { noremap = true, silent = true }

	-- ===============================
	-- Core Keymaps
	-- ===============================
	keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" }) -- Save file
	keymap.set("n", "<C-q>", ":q<CR>", { desc = "Quit Neovim" }) -- Quit Neovim
	keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlighting" })
	keymap.set("n", "<leader>sv", ":source $MYVIMRC<CR>", { desc = "Source init.lua" }) -- Reload configuration

	-- ===============================
	-- Window Management Keymaps
	-- ===============================
	keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
	keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontally" })
	keymap.set("n", "<leader>we", "<C-w>=", { desc = "Equalize window sizes" })
	keymap.set("n", "<leader>wx", ":close<CR>", { desc = "Close current window" })

	-- ===============================
	-- Buffer Management Keymaps
	-- ===============================
	keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
	keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
	keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Delete buffer" })

	-- ===============================
	-- Tab Management Keymaps
	-- ===============================
	keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "Open new tab" })
	keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close current tab" })
	keymap.set("n", "<leader>to", ":tabonly<CR>", { desc = "Close all other tabs" })
	keymap.set("n", "<leader>tm", ":tabmove<CR>", { desc = "Move current tab" })
	keymap.set("n", "<leader>tl", ":tabnext<CR>", { desc = "Next tab" })
	keymap.set("n", "<leader>th", ":tabprevious<CR>", { desc = "Previous tab" })

	-- ===============================
	-- Search and Replace Keymaps
	-- ===============================
	keymap.set("n", "<leader>sr", ":%s//g<Left><Left>", { desc = "Search and replace in file" })
	keymap.set(
		"n",
		"<leader>sw",
		":lua require('telescope.builtin').grep_string({ search = vim.fn.input('Search: ') })<CR>",
		{ desc = "Search for a word in workspace" }
	)
	keymap.set(
		"n",
		"<leader>sf",
		":lua require('telescope.builtin').find_files()<CR>",
		{ desc = "Search for a file in workspace" }
	)
end

return M
