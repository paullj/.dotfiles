-- Git related plugins
return {
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
}
