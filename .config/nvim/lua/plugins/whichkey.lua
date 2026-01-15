return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		-- Disable which-key for NvimTree
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "NvimTree",
			callback = function()
				vim.b.which_key_ignore = true
			end,
		})
	end,
	opts = {
		preset = "modern",
		-- stylua: ignore
		spec = {
			{
				mode = { "n", "v" },
				{ "<leader>q", icon = "󰅘",  desc = "Quit" },
				{ "<leader>Q", "<cmd>confirm qa<CR>",  icon = "󰱞",desc = "Quit All"},
				{ "<leader>;", icon = "", desc = "Terminal" },
				{ "<leader>f", icon = "", desc = "Find" },
				{ "<leader>g", icon = "", desc = "Git" },
				{ "<leader>d", icon = "", desc = "Diffview" },
				{ "<leader>e", icon = "", desc = "Explorer" },
				{ "<leader>l", icon = "󰅩", desc = "LSP" },
				{ "<leader>r", group = "Reload/Toggle", icon = "" },
				{ "<leader>rn", desc = "Relative Numbers" },
				{ "<leader>rc", desc = "Reload Config" },
				{ "[", group = "prev", icon = "" },
				{ "]", group = "next", icon = "" },
				{ "g", group = "goto", icon = "" },
				{ "z", group = "fold", icon = "" },
			},
		},
	},
	keys = {},
}
