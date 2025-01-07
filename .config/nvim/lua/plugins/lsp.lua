-- LSP related plugins

local function get_lsp_servers()
	local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
	local lsp_files = vim.fn.globpath(lsp_dir, "*.yaml", false, true)
	local servers = {}

	for _, file in ipairs(lsp_files) do
		local server_name = vim.fn.fnamemodify(file, ":t:r")
		table.insert(servers, server_name)
	end

	return servers
end

return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = { border = "rounded" },
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
			},
		},
	},
	{
		"tamago324/nlsp-settings.nvim",
		opts = {
			config_home = vim.fn.stdpath("config") .. "/lsp",
			local_settings_dir = ".nlsp-settings",
			local_settings_root_markers_fallback = { ".git" },
			append_default_schemas = true,
			loader = "yaml",
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")

			local global_capabilities = vim.lsp.protocol.make_client_capabilities()
			global_capabilities.textDocument.completion.completionItem.snippetSupport = true

			lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
				capabilities = global_capabilities,
			})

			for server, config in pairs(opts.servers or {}) do
				config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end
		end,
		init = function()
			local default_diagnostic_config = {
				virtual_text = false,
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			}
			vim.diagnostic.config(default_diagnostic_config)
			for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
			end

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
			require("lspconfig.ui.windows").default_options.border = "rounded"
		end,
		on_attach = function(client, bufnr)
			vim.api.nvim_create_autocmd("CursorHold", {
				buffer = bufnr,
				callback = function()
					local opts = {
						focusable = false,
						close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
						border = "rounded",
						source = "always",
						prefix = " ",
						scope = "cursor",
					}
					vim.diagnostic.open_float(nil, opts)
				end,
			})
		end,
		keys = {
			{ "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", desc = "Format" },
			{ "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Fix" },
			{ "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic" },
			{ "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
			{ "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "Line Diagnostics" },
			{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
			{ "<leader>lF", "<cmd>Telescope lsp_references<cr>", desc = "References" },
			{ "<leader>ld", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition" },
			{ "<leader>lD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
			{ "<leader>lI", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" },
			{ "<leader>lT", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" },
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		opts = {
			automatic_installation = false,
			handlers = {},
		},
	},
	{
		"nvimtools/none-ls.nvim",
		opts = {
			sources = {},
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
}
