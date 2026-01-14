return {
	{
		dir = "/Users/dheebz/Workspace/spotify-cli.nvim",
		name = "spotify-cli.nvim",
		enabled = true,
		dev = true,
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			keymaps = {
				prefix = "<leader>s",
			},
			statusline = {
				enabled = false,
				width = 20,

				scroll_speed = 125, -- Scroll interval (ms)
				update_interval = 5000, -- CLI fetch interval (ms)
				separator = "   ",
				format = "%s - %s", -- track, artists
				playing_icon = "",
				paused_icon = "",
				stopped_icon = "",
			},
		},
		config = function(_, opts)
			require("spotify").setup(opts)
		end,
	},
}
