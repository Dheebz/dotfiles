-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  nvim-dap Keymaps (Profile Specific)                                   ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/keybinds/nvim-dap.lua        ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return function()
	local map = vim.keymap.set
	local dap = require("dap")

	-- 🛑 Basic Debugging Controls
	map("n", "<F5>", function()
		dap.continue()
	end, { desc = "DAP Continue" })
	map("n", "<F10>", function()
		dap.step_over()
	end, { desc = "DAP Step Over" })
	map("n", "<F11>", function()
		dap.step_into()
	end, { desc = "DAP Step Into" })
	map("n", "<F12>", function()
		dap.step_out()
	end, { desc = "DAP Step Out" })

	map("n", "<leader>db", function()
		dap.toggle_breakpoint()
	end, { desc = "Toggle Breakpoint" })
	map("n", "<leader>dB", function()
		vim.ui.input({ prompt = "Breakpoint Condition: " }, function(condition)
			if condition then
				dap.set_breakpoint(condition)
			end
		end)
	end, { desc = "Conditional Breakpoint" })

	map("n", "<leader>dc", function()
		dap.run_to_cursor()
	end, { desc = "Run to Cursor" })
	map("n", "<leader>dr", function()
		dap.repl.toggle()
	end, { desc = "Toggle REPL" })

	map("n", "<leader>dq", function()
		dap.terminate()
	end, { desc = "Terminate Debugging" })
end

-- End of File: ~/.config/nvim/lua/profiles/dheebz/keybinds/nvim-dap.lua
