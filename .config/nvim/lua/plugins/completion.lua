-- Code completion related plugins
return {
	{
		"saghen/blink.cmp",
		lazy = false, -- lazy loading handled internally
		dependencies = "rafamadriz/friendly-snippets",
		version = "v0.*",
		event = "InsertEnter",
		opts = {
			sources = {
				-- add lazydev to your completion providers
				default = { "lsp", "path", "snippets", "buffer", "lazydev" },
				providers = {
					-- dont show LuaLS require statements when lazydev has items
					lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallbacks = { "lsp" } },
				},
			},
			keymap = {
				preset = "enter", -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			},
			appearance = {
				use_nvim_cmp_as_default = true,
			},
			completion = {
				menu = {
					border = "rounded",
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
	},
}
