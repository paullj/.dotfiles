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

return {
	{
		"nvim-tree/nvim-tree.lua",
		event = "VeryLazy",
		opts = {
			respect_buf_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = true,
			},
			view = { side = "right", width = 35 },
			filters = {
				custom = { "^\\.git$", "\\.pyc$", "__pycache__" },
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
			local keymap = require("helpers.keys").map
			keymap("n", "ga", git_add, "Git add/stage file")

			vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
			vim.api.nvim_create_autocmd({ "BufEnter", "CursorMoved" }, {
				pattern = "NvimTree_*",
				callback = function()
					vim.cmd("normal! 0") -- Move the cursor to the first non-whitespace character of the line
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
