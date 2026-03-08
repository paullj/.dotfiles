local function tmux_nav(direction)
  return function()
    require("tmux").move_to(direction)
  end
end

local function tmux_resize(direction)
  return function()
    require("tmux").resize(direction)
  end
end

return {
  {
    "aserowy/tmux.nvim",
    keys = {
      { "<C-h>", tmux_nav("h"), desc = "Navigate left (tmux-aware)" },
      { "<C-j>", tmux_nav("j"), desc = "Navigate down (tmux-aware)" },
      { "<C-k>", tmux_nav("k"), desc = "Navigate up (tmux-aware)" },
      { "<C-l>", tmux_nav("l"), desc = "Navigate right (tmux-aware)" },
      { "<A-h>", tmux_resize("h"), desc = "Resize left (tmux-aware)" },
      { "<A-j>", tmux_resize("j"), desc = "Resize down (tmux-aware)" },
      { "<A-k>", tmux_resize("k"), desc = "Resize up (tmux-aware)" },
      { "<A-l>", tmux_resize("l"), desc = "Resize right (tmux-aware)" },
    },
    opts = {
      copy_sync = {
        enable = false,
      },
      navigation = {
        enable_default_keybindings = false,
      },
      resize = {
        enable_default_keybindings = false,
      },
      swap = {
        enable_default_keybindings = false,
      },
    },
  },
}
