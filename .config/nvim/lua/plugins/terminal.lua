-- Plugins for integrated terminals in neovim

return {
	-- Toggle terminal
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
	opts = {
		direction = "float",
		float_opts = {
			width = function()
				return vim.o.columns * 0.5
			end,
			height = function()
				return vim.o.lines * 0.5
			end,
			border = "rounded",
			winblend = 0,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
	},
	keys = {
		{ "<leader>;", ":ToggleTerm<cr>", desc = "Toggle Terminal" },
	},
}
