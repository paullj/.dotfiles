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
	init = function()
		local keymap = require("helpers.keys").map
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			dir = "git_dir",
			direction = "float",
			float_opts = {
				width = function()
					return vim.o.columns * 0.75
				end,
				height = function()
					return vim.o.lines * 0.75
				end,
			},
			-- function to run on opening the terminal
			on_open = function(term)
				vim.cmd("startinsert!")
				keymap("n", "q", "<cmd>close<CR>", "Close")
			end,
			-- function to run on closing the terminal
			on_close = function(term)
				vim.cmd("startinsert!")
			end,
		})

		function _lazygit_toggle()
			lazygit:toggle()
		end
		keymap("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", "Lazy")
	end,
	keys = {
		{ "<leader>;", ":ToggleTerm<cr>", desc = "Toggle Terminal" },
	},
}
