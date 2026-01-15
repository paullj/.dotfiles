-- Git related plugins
return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufWinEnter",
		opts = {
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			preview_config = {
				border = "rounded",
			},
		},
		-- stylua: ignore
		keys = {
			{ "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff"},
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout" },
			{ "<leader>gl", "<cmd>lua require('gitsigns').blame_line()<cr>", desc = "Blame" },
			{ "<leader>gj", "<cmd>lua require('gitsigns').next_hunk({navigation_message = false})<cr>", desc = "Next Hunk" },
			{ "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", desc = "Prev Hunk" },
			-- { "<leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<cr>", desc = "Preview Hunk" },
			{ "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<cr>", desc = "Reset Hunk" },
			-- { "<leader>gR", "<cmd>lua require('gitsigns').reset_buffer()<cr>", desc = "Reset Buffer" },
			{ "<leader>gs", "<cmd>lua require('gitsigns').stage_hunk()<cr>", desc = "Stage Hunk" },
			{ "<leader>gu", "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", desc = "Undo Stage Hunk" },

		},
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
		opts = {
			enhanced_diff_hl = true,
			use_icons = false,
			view = {
				default = {
					layout = "diff2_horizontal",
					winbar_info = false,
				},
				merge_tool = {
					layout = "diff3_horizontal",
					disable_diagnostics = true,
					winbar_info = true,
				},
				file_history = {
					layout = "diff2_horizontal",
					winbar_info = false,
				},
			},
			file_panel = {
				position = "right",
				width = 35,
			},
		},
		-- stylua: ignore
		keys = {
			{ "<leader>d", function()
				local view = require("diffview.lib").get_current_view()
				if view then
					vim.cmd("DiffviewClose")
				else
					vim.cmd("DiffviewOpen")
				end
			end, desc = "Diffview" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
			{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Repo History" },
		},
	},
}
