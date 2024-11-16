return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		integrations = {
			dashboard = true,
			blink_cmp = true,
			gitsigns = true,
			nvimtree = true,
			treesitter = true,
			notify = true,
			mason = true,
			which_key = true,
		},
	},
	init = function()
		vim.cmd.colorscheme("catppuccin")
	end,
}
