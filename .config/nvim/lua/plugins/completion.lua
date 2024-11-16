-- Code completion related plugins
return {
	"saghen/blink.cmp",
	lazy = false, -- lazy loading handled internally
	dependencies = "rafamadriz/friendly-snippets",
	version = "v0.*",
	event = "InsertEnter",
	opts = {
		keymap = { preset = "enter" }, -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		highlight = {
			use_nvim_cmp_as_default = true,
		},
		windows = {
			autocomplete = {
				-- draw = "reversed",
				winblend = vim.o.pumblend,
			},
			documentation = {
				auto_show = true,
			},
		},
	},
	-- allows extending the enabled_providers array elsewhere in your config
	-- without having to redefining it
	opts_extend = { "sources.completion.enabled_providers" },
}
