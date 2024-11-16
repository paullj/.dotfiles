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

servers = get_lsp_servers()

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
				virtual_text = true,
				update_in_insert = true,
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

			-- vim.api.nvim_create_autocmd("LspAttach", {
			-- 	group = vim.api.nvim_create_augroup("lsp-attach-format", { clear = true }),
			-- 	-- This is where we attach the autoformatting for reasonable clients
			-- 	callback = function(args)
			-- 		local client_id = args.data.client_id
			-- 		local client = vim.lsp.get_client_by_id(client_id)
			-- 		local bufnr = args.buf
			-- 		if not client.server_capabilities.documentFormattingProvider then
			-- 			return
			-- 		end
			-- 		vim.api.nvim_create_autocmd("BufWritePre", {
			-- 			group = get_augroup(client),
			-- 			buffer = bufnr,
			-- 			callback = function()
			-- 				if not format_is_enabled then
			-- 					return
			-- 				end
			-- 				vim.lsp.buf.format({
			-- 					async = false,
			-- 					filter = function(c)
			-- 						return c.id == client.id
			-- 					end,
			-- 				})
			-- 			end,
			-- 		})
			-- 	end,
			-- })
		end,
		toggle_inlay_hints = function()
			local bufnr = vim.api.nvim_get_current_buf()
			local enabled = vim.lsp.inlay_hint.get_status(bufnr)
			vim.lsp.inlay_hint.set_status(bufnr, not enabled)
		end,
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/inlayHint") then
				vim.lsp.inlay_hint.enable(bufnr, true)
			end
		end,
		keys = {
			{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
			{ "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", desc = "Format" },
			{ "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Fix" },
			{ "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic" },
			{ "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
			{ "<leader>lh", "<cmd>lua require('plugins.lsp').toggle_inlay_hints()<cr>", desc = "Toggle Hints" },
			{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
			{ "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
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
}
