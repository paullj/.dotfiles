-- Dashboard when opening neovim

local logo = [[
                               __                
  ___     ___    ___   __  __ /\_\    ___ ___    
 / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  
/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ 
\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\
 \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/
]]

local buttons = {
	{ icon = "", desc = "Restore Session", key = "l", action = "NeovimProjectLoadRecent" },
	{ icon = "", desc = "Find project", key = "p", action = "NeovimProjectDiscover" },
	{ icon = "", desc = "Find file", key = "f", action = "Telescope find_files" },
	{ icon = "", desc = "New file", key = "n", action = "ene | startinsert" },
	{ icon = "", desc = "Recent files", key = "r", action = "Telescope oldfiles" },
	{ icon = "", desc = "Find text", key = "g", action = "Telescope live_grep" },
	{ icon = "", desc = "Quit", key = "Q", action = "qa" },
}

local logo = string.rep("\n", 10) .. logo .. "\n\n"

for _, button in ipairs(buttons) do
	button.icon = button.icon .. " "
	button.desc = button.desc .. string.rep(" ", 40 - #button.desc)
	button.key_format = "  %s"
end

return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",

	config = function()
		local function get_project_for_cwd()
			local projects = require("neovim-project.utils.path").get_all_projects()

			for _, project in pairs(projects) do
				if project.root == vim.fn.getcwd() then
					return project
				end
			end
			return nil
		end

		local project_for_cwd = get_project_for_cwd()
		if project_for_cwd then
			table.insert(buttons, 1, {
				icon = "",
				desc = "Open current project",
				key = "O",
				action = "NeovimProjectLoad " .. project_for_cwd.name,
			})
		end

		opts = {
			theme = "doom",
			disable_move = true,
			shortcut_type = "letter",
			hide = {
				tabline = true,
				winbar = true,
			},
			config = {
				header = vim.split(logo, "\n"),
				center = buttons,
				footer = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					return { "Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
				end,
			},
		}

		require("dashboard").setup(opts)
	end,
}
