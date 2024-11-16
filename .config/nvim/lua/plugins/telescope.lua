return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true } },
		keys = {
			{ "<leader>fb", ":Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>ff", ":Telescope find_files<cr>", desc = "Files" },
			{ "<leader>fp", ":NeovimProjectDiscover<cr>", desc = "Projects" },
			{ "<leader>fr", ":Telescope oldfiles<cr>", desc = "Recent Files" },
			{ "<leader>fg", ":Telescope live_grep<cr>", desc = "Find Text" },
		},

		config = function()
			local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					prompt_prefix = " ",
					selection_caret = " ",
					entry_prefix = "   ",
					initial_mode = "insert",
					selection_strategy = "reset",
					path_display = { "smart" },
					color_devicons = true,
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--glob=!**/.git/*",
					},

					mappings = {
						i = {
							["<C-n>"] = actions.cycle_history_next,
							["<C-p>"] = actions.cycle_history_prev,

							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
						},
						n = {
							["<esc>"] = actions.close,
							["j"] = actions.move_selection_next,
							["k"] = actions.move_selection_previous,
							["q"] = actions.close,
						},
					},
				},
				pickers = {
					live_grep = { theme = "dropdown" },
					grep_string = { theme = "dropdown" },
					find_files = {
						theme = "dropdown",
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
					},
					buffers = {
						theme = "dropdown",
						previewer = false,
						initial_mode = "normal",
						mappings = {
							i = {
								["<C-d>"] = actions.delete_buffer,
							},
							n = {
								["dd"] = actions.delete_buffer,
							},
						},
					},
					colorscheme = { enable_preview = true },
					lsp_references = { theme = "dropdown", initial_mode = "normal" },
					lsp_definitions = { theme = "dropdown", initial_mode = "normal" },
					lsp_declarations = { theme = "dropdown", initial_mode = "normal" },
					lsp_implementations = { theme = "dropdown", initial_mode = "normal" },
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
				},
			})
		end,
	},
}
