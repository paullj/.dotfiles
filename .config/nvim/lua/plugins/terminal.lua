-- Plugins for integrated terminals in neovim

return {
	-- Toggle terminal
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
	opts = {
		direction = "float",
		open_mapping = [[<c-\>]],  -- Alternative way to toggle
		hide_numbers = true,
		insert_mappings = true,
		terminal_mappings = true,
		start_in_insert = true,  -- Start in terminal mode
		on_open = function(term)
			vim.cmd("startinsert!")  -- Force insert mode
		end,
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
