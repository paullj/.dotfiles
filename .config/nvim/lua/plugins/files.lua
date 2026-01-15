-- Plugins for file management

local function open_nvim_tree(data)
	-- buffer is a real file on the disk
	local real_file = vim.fn.filereadable(data.file) == 1
	-- buffer is a [No Name]
	local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
	if not real_file and not no_name then
		return
	end
	-- open the tree, find the file but don't focus it
	require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
	vim.api.nvim_exec_autocmds("BufWinEnter", { buffer = require("nvim-tree.view").get_bufnr() })
end

local function tab_win_closed(winnr)
	local api = require("nvim-tree.api")
	local tabnr = vim.api.nvim_win_get_tabpage(winnr)
	local bufnr = vim.api.nvim_win_get_buf(winnr)
	local buf_info = vim.fn.getbufinfo(bufnr)[1]
	local tab_wins = vim.tbl_filter(function(w)
		return w ~= winnr
	end, vim.api.nvim_tabpage_list_wins(tabnr))
	local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
	if buf_info.name:match(".*NvimTree_%d*$") then -- close buffer was nvim tree
		-- Close all nvim tree on :q
		if not vim.tbl_isempty(tab_bufs) then -- and was not the last window (not closed automatically by code below)
			api.tree.close()
		end
	else -- else closed buffer was normal buffer
		if #tab_bufs == 1 then -- if there is only 1 buffer left in the tab
			local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
			if last_buf_info.name:match(".*NvimTree_%d*$") then -- and that buffer is nvim tree
				vim.schedule(function()
					if #vim.api.nvim_list_wins() == 1 then -- if its the last buffer in vim
						vim.cmd("quit") -- then close all of vim
					else -- else there are more tabs open
						vim.api.nvim_win_close(tab_wins[1], true) -- then close only the tab
					end
				end)
			end
		end
	end
end

local git_add = function()
	local api = require("nvim-tree.api")
	local node = api.tree.get_node_under_cursor()
	local gs = node.git_status.file

	-- If the current node is a directory get children status
	if gs == nil then
		gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
			or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
	end

	-- If the file is untracked, unstaged or partially staged, we stage it
	if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
		vim.cmd("silent !git add " .. node.absolute_path)

	-- If the file is staged, we unstage
	elseif gs == "M " or gs == "A " then
		vim.cmd("silent !git restore --staged " .. node.absolute_path)
	end

	api.tree.reload()
end

local toggle_git_ignored = function()
	local api = require("nvim-tree.api")
	api.tree.toggle_gitignore_filter()
end

local toggle_hidden_files = function()
	local api = require("nvim-tree.api")
	api.tree.toggle_hidden_filter()
end

return {
	{
		"nvim-tree/nvim-tree.lua",
		event = "VeryLazy",
		opts = {
			hijack_cursor = true,  -- Keep cursor on first letter of filename
			sync_root_with_cwd = true,
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")

				-- Default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- Make git_add globally accessible for the menu
				_G.nvim_tree_git_add = git_add

				-- Create file explorer context menu with keybind hints
				vim.cmd([[
					silent! aunmenu NvimTreePopup
					amenu 10.100 NvimTreePopup.(a)\ New\ File <cmd>lua require("nvim-tree.api").fs.create()<CR>
					amenu 10.110 NvimTreePopup.(A)\ New\ Folder <cmd>lua require("nvim-tree.api").fs.create()<CR>
					amenu 10.120 NvimTreePopup.(o)\ Open <cmd>lua require("nvim-tree.api").node.open.edit()<CR>
					amenu 10.130 NvimTreePopup.(t)\ Open\ in\ Tab <cmd>lua require("nvim-tree.api").node.open.tab()<CR>
					amenu 10.140 NvimTreePopup.(s)\ Open\ in\ Split <cmd>lua require("nvim-tree.api").node.open.horizontal()<CR>
					amenu 10.150 NvimTreePopup.(c)\ Copy <cmd>lua require("nvim-tree.api").fs.copy.node()<CR>
					amenu 10.160 NvimTreePopup.(x)\ Cut <cmd>lua require("nvim-tree.api").fs.cut()<CR>
					amenu 10.170 NvimTreePopup.(p)\ Paste <cmd>lua require("nvim-tree.api").fs.paste()<CR>
					amenu 10.180 NvimTreePopup.(r)\ Rename <cmd>lua require("nvim-tree.api").fs.rename()<CR>
					amenu 10.190 NvimTreePopup.(d)\ Delete <cmd>lua require("nvim-tree.api").fs.remove()<CR>
					amenu 10.200 NvimTreePopup.(y)\ Copy\ Path <cmd>lua require("nvim-tree.api").fs.copy.absolute_path()<CR>
					amenu 10.210 NvimTreePopup.(Y)\ Copy\ Name <cmd>lua require("nvim-tree.api").fs.copy.filename()<CR>
				]])

				-- Custom mappings
				vim.keymap.set('n', '?', api.tree.toggle_help, { desc = 'Help', buffer = bufnr, noremap = true, silent = true, nowait = true })
				vim.keymap.set('n', 'ga', git_add, { desc = 'Git add/stage', buffer = bufnr, noremap = true, silent = true, nowait = true })
				vim.keymap.set('n', 'I', toggle_git_ignored, { desc = 'Toggle gitignored', buffer = bufnr, noremap = true, silent = true, nowait = true })
				vim.keymap.set('n', 'H', toggle_hidden_files, { desc = 'Toggle hidden', buffer = bufnr, noremap = true, silent = true, nowait = true })

				-- Function to handle right-click in NvimTree
				_G.nvim_tree_right_click = function()
					-- Get mouse position
					local mouse_pos = vim.fn.getmousepos()
					-- Switch to the window under the mouse (should be NvimTree)
					if mouse_pos.winid ~= 0 then
						vim.fn.win_gotoid(mouse_pos.winid)
					end
					-- Set cursor to mouse position
					if mouse_pos.line > 0 and mouse_pos.column > 0 then
						vim.fn.cursor(mouse_pos.line, mouse_pos.column)
					end
					-- Show the NvimTree context menu
					vim.cmd('popup NvimTreePopup')
				end

				-- Right-click context menu
				vim.keymap.set('n', '<RightMouse>', '<cmd>lua nvim_tree_right_click()<CR>', { desc = 'Context menu', buffer = bufnr, noremap = true, silent = true, nowait = true })
			end,
			respect_buf_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = true,
			},
			view = {
				side = "right",
				width = 35,
				float = {
					enable = false,
					open_win_config = {
						border = "rounded",
					},
				},
			},
			filters = {
				custom = { "^\\.git$", "\\.pyc$", "__pycache__" },
				git_ignored = true,  -- Hide gitignored files by default
			},
			renderer = {
				special_files = {},
				icons = {
					show = { folder_arrow = false },
					git_placement = "right_align",
					glyphs = {
						default = "󰦪",
						symlink = "󱦴",
						bookmark = "",
						folder = {
							default = "",
							empty = "",
							open = "",
							empty_open = "",
						},
						git = {
							unstaged = "M",
							staged = "S",
							renamed = "R",
							untracked = "U",
							deleted = "D",
							ignored = "~",
						},
					},
				},
			},
		},
		init = function()
			-- Set highlight for active window separator
			vim.api.nvim_set_hl(0, "WinSeparatorActive", { fg = "#7aa2f7", bg = "#1e2030", bold = true })

			-- Set highlight for popup menu to make it stand out with a border effect
			vim.api.nvim_set_hl(0, "Pmenu", { bg = "#2e3440", fg = "#d8dee9" })
			vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#5e81ac", fg = "#eceff4", bold = true })
			vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#3b4252" })
			vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#88c0d0" })

			-- Set pumblend for slight transparency and border style
			vim.opt.pumblend = 10
			vim.opt.wildoptions = "pum"

			-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
			vim.api.nvim_create_autocmd({ "BufEnter", "CursorMoved" }, {
				pattern = "NvimTree_*",
				callback = function()
					vim.cmd("normal! 0") -- Move the cursor to the first non-whitespace character of the line
				end,
			})

			-- Highlight the nvim-tree window border when focused
			vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
				pattern = "NvimTree_*",
				callback = function()
					vim.wo.winhighlight = "Normal:NvimTreeNormal,WinSeparator:WinSeparatorActive,StatusLine:StatusLineNC"
				end,
			})

			vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
				pattern = "NvimTree_*",
				callback = function()
					vim.wo.winhighlight = ""
				end,
			})

			vim.api.nvim_create_autocmd("WinClosed", {
				callback = function()
					local winnr = tonumber(vim.fn.expand("<amatch>"))
					vim.schedule_wrap(tab_win_closed(winnr))
				end,
				nested = true,
			})
		end,
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Explorer" },
		},
	},
}
