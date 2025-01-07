return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		-- stylua: ignore
		spec = {
			{
				mode = { "n", "v" },
				{ "<leader>q", icon = "󰅘",  desc = "Quit" },
				{ "<leader>Q", "<cmd>confirm qa<CR>",  icon = "󰱞",desc = "Quit All"},
				{ "<leader>;", icon = "", desc = "Terminal" },
				{ "<leader>f", icon = "", desc = "Find" },
				{ "<leader>g", icon = "", desc = "Git" },
				{ "<leader>e", icon = "", desc = "Explorer" },
				{ "<leader>l", icon = "󰅩", desc = "Language" },
				{ "[", group = "prev", icon = "" },
				{ "]", group = "next", icon = "" },
				{ "g", group = "goto", icon = "" },
				{ "z", group = "fold", icon = "" },
			},
		},
	},
	keys = {},
}
