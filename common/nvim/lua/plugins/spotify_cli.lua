return {
	{
		dir = "/Users/dheebz/Workspace/spotify-cli_nvim",
		name = "spotify-nvim",
		enabled = true,
		dev = true,
		config = function()
			-- Add the lua folder to runtimepath so require('spotify') works
			vim.opt.rtp:append("/Users/dheebz/Workspace/spotify-cli_nvim")
			require("spotify").setup({
				keymaps = true, -- Enable default keymaps (<leader>s...)
			})
		end,
	},
}
