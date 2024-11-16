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
	{ icon = "", desc = "Open recent project", key = "l", action = "NeovimProjectLoadRecent" },
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
			-- stylua: ignore
			center = buttons,
			footer = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				return { "Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
			end,
		},
	},
}
