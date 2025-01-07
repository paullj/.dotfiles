return {
	-- Tab and bufferline
	{
		"romgrk/barbar.nvim",
		event = "BufWinEnter",
		dependencies = {
			"lewis6991/gitsigns.nvim",
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			animation = false,
			tabpages = true,
			focus_on_close = "previous",
			icons = {
				filetype = { enabled = false },
				buffer_index = false,
				buffer_number = false,
				button = "",
				separator = { left = "", right = "" },
				modified = { button = "●" },
				pinned = { button = "󰐃", filename = true },
				inactive = { button = "×" },
			},
			sidebar_filetypes = {
				NvimTree = true,
			},
		},
    -- stylua: ignore
    keys = {
			{ "<leader>q", "<cmd>BufferClose<cr>", desc = "Close" },
      { "<leader>tp", "<Cmd>BufferPick<CR>", desc = "Pick" },
		  { "<leader>tn", "<cmd>$tabnew<cr>",   desc = "New Empty Tab" },
      { "<leader>tN", "<cmd>tabnew %<cr>",   desc = "New Tab" },
      { "<leader>to", "<cmd>tabonly<cr>",    desc = "Only" },
      { "<leader>th", "<cmd>-tabmove<cr>",   desc = "Move Left" },
      { "<leader>tl", "<cmd>+tabmove<cr>",   desc = "Move Right" }
    },
	},
	-- Search tabs with telescope
	{
		"LukasPietzschmann/telescope-tabs",
		config = function()
			require("telescope").load_extension("telescope-tabs")
		end,
		dependencies = { "nvim-telescope/telescope.nvim" },
		keys = {
			{ "<leader>tt", "<cmd>Telescope telescope-tabs list_tabs<cr>", desc = "Lookup Tabs" },
		},
	},
}
