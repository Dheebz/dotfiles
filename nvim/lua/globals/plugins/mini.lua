-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Mini Icons Plugin (Global)                                           ┃
-- ┃  Description: Configuration for the "mini.icons" plugin,              ┃
-- ┃  providing icon support for Neovim.                                   ┃
-- ┃  File: ~/.config/nvim/lua/globals/plugins/mini.lua                    ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
	"echasnovski/mini.icons",
	enabled = true,
	version = false,
	config = function()
		require("mini.icons").setup()
	end,
}
-- End of File: ~/.config/nvim/lua/globals/plugins/mini.lua