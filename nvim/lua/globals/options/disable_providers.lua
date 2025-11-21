-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Disable External Language Providers                                  ┃
-- ┃  Disables Perl and Ruby providers for faster startup                  ┃
-- ┃  File: ~/.config/nvim/lua/globals/options/disable_providers.lua       ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}
M.enabled = true

M.setup = function()
	vim.g.loaded_node_provider = 0
	vim.g.loaded_python3_provider = 0
	vim.g.loaded_python_provider = 0
	vim.g.loaded_perl_provider = 0
	vim.g.loaded_ruby_provider = 0
end

return M

-- End of File: ~/.config/nvim/lua/globals/options/disable_providers.lua
