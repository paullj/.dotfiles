-- Plugins for project management

return {
	"coffebar/neovim-project",
	opts = {
		projects = {
			"~/Projects/paullj/*",
			"~/Projects/automata-tech/*",
			"~/Projects/paullj/.dotfiles",
		},
		dashboard_mode = true,
		picker = { type = "telescope" },
	},
	init = function()
		-- enable saving the state of plugins in the session
		vim.opt.sessionoptions:append("globals")
	end,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope.nvim" },
		{ "shatur/neovim-session-manager" },
	},
	lazy = false,
	priority = 100,
}
