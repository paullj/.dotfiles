-- quality of life plugins that tweak the interface and behavior of neovim

return {
	-- Notifications
	{
		"recarriga/nvim-notify",
		event = "VeryLazy",
		opts = {
			render = "wrapped-compact",
			stages = "static",
			timeout = 3000,
			top_down = false,
		},
	},
	-- Autopairs for brackets, quotes, etc.
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
	},
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		init = function()
			vim.g.undotree_WindowLayout = 3
			vim.g.undotree_SplitWidth = 35
			vim.g.undotree_SetFocusWhenToggle = 1
		end,
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
		},
	},
	-- Collection of interface tweaks
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			cmdline = {
				format = {
					cmdline = { pattern = "^:", icon = "", lang = "vim" },
					search_down = {
						kind = "search",
						pattern = "^/",
						icon = " ",
						lang = "regex",
					},
					search_up = {
						kind = "search",
						pattern = "^%?",
						icon = " ",
						lang = "regex",
					},
				},
			},
			views = {
				cmdline_popup = {
					position = { row = "40%", col = "50%" },
					size = { width = "25%", height = "auto" },
				},
				popupmenu = {
					position = { row = "50%", col = "50%" },
					size = { width = "25%", height = 10 },
					border = { style = "rounded", padding = { 0, 1 } },
					win_options = { winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" } },
				},
				confirm = {
					position = { row = "50%", col = "50%" },
					size = { width = "auto", height = "auto" },
					win_options = { winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticError" } },
				},
			},
		},
		dependencies = {
			"muniftanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
}
