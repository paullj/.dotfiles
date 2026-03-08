return {
  { "akinsho/bufferline.nvim", enabled = false },
  { "folke/trouble.nvim", enabled = false },
  { "nvim-mini/mini.icons", enabled = false },
  {
    "folke/which-key.nvim",
    opts = {
      preset = "modern",
      icons = {
        mappings = false,
        separator = "",
        group = "",
        keys = {},
      },
      replace = {
        key = {
          { "<Space>", "󱁐" },
          { "<leader>", "󱁐" },
        },
      },
      spec = {
        -- Groups
        { "<leader><tab>", group = "tabs" },
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>d", group = "debug" },
        { "<leader>dp", group = "profiler" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>gh", group = "hunks" },
        { "<leader>q", group = "quit/session" },
        { "<leader>s", group = "search" },
        { "<leader>sn", group = "noice" },
        { "<leader>u", group = "ui" },
        { "<leader>x", group = "diagnostics/quickfix" },
        { "<leader>w", group = "windows" },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "gs", group = "surround" },
        { "z", group = "fold" },

        -- Buffers
        { "<leader>bb", desc = "Switch to Other Buffer" },
        { "<leader>bd", desc = "Delete Buffer" },
        { "<leader>bo", desc = "Delete Other Buffers" },
        { "<leader>bD", desc = "Delete Buffer and Window" },

        -- Code
        { "<leader>cf", desc = "Format" },
        { "<leader>cd", desc = "Line Diagnostics" },
        { "<leader>cs", desc = "LSP Symbols" },
        { "<leader>cS", desc = "LSP Workspace Symbols" },

        -- Find/File
        { "<leader>,", desc = "Buffers" },
        { "<leader>/", desc = "Grep (Root)" },
        { "<leader>:", desc = "Command History" },
        { "<leader><space>", desc = "Find Files (Root)" },
        { "<leader>fb", desc = "Buffers" },
        { "<leader>fB", desc = "Buffers (all)" },
        { "<leader>fc", desc = "Config File" },
        { "<leader>ff", desc = "Find Files (Root)" },
        { "<leader>fF", desc = "Find Files (cwd)" },
        { "<leader>fg", desc = "Git Files" },
        { "<leader>fn", desc = "New File" },
        { "<leader>fr", desc = "Recent" },
        { "<leader>fR", desc = "Recent (cwd)" },
        { "<leader>fp", desc = "Projects" },
        { "<leader>ft", desc = "Terminal (Root)" },
        { "<leader>fT", desc = "Terminal (cwd)" },

        -- Git
        { "<leader>gg", desc = "Lazygit (Root)" },
        { "<leader>gG", desc = "Lazygit (cwd)" },
        { "<leader>gb", desc = "Blame Line" },
        { "<leader>gB", desc = "Browse (open)" },
        { "<leader>gd", desc = "Diff (hunks)" },
        { "<leader>gD", desc = "Diff (origin)" },
        { "<leader>gf", desc = "File History" },
        { "<leader>gl", desc = "Log" },
        { "<leader>gL", desc = "Log (cwd)" },
        { "<leader>gs", desc = "Status" },
        { "<leader>gS", desc = "Stash" },
        { "<leader>gi", desc = "GitHub Issues (open)" },
        { "<leader>gI", desc = "GitHub Issues (all)" },
        { "<leader>gp", desc = "GitHub Pull Requests (open)" },
        { "<leader>gP", desc = "GitHub Pull Requests (all)" },
        { "<leader>gY", desc = "Browse (copy)" },
        { "<leader>uG", desc = "Toggle Git Signs" },

        -- Git Hunks
        { "<leader>ghs", desc = "Stage Hunk" },
        { "<leader>ghr", desc = "Reset Hunk" },
        { "<leader>ghS", desc = "Stage Buffer" },
        { "<leader>ghu", desc = "Undo Stage Hunk" },
        { "<leader>ghR", desc = "Reset Buffer" },
        { "<leader>ghp", desc = "Preview Hunk Inline" },
        { "<leader>ghb", desc = "Blame Line" },
        { "<leader>ghB", desc = "Blame Buffer" },
        { "<leader>ghd", desc = "Diff This" },
        { "<leader>ghD", desc = "Diff This ~" },

        -- Search
        { '<leader>s"', desc = "Registers" },
        { "<leader>s/", desc = "Search History" },
        { "<leader>sa", desc = "Autocmds" },
        { "<leader>sb", desc = "Buffer Lines" },
        { "<leader>sB", desc = "Grep Open Buffers" },
        { "<leader>sc", desc = "Command History" },
        { "<leader>sC", desc = "Commands" },
        { "<leader>sd", desc = "Diagnostics" },
        { "<leader>sD", desc = "Buffer Diagnostics" },
        { "<leader>sg", desc = "Grep (Root)" },
        { "<leader>sG", desc = "Grep (cwd)" },
        { "<leader>sh", desc = "Help Pages" },
        { "<leader>sH", desc = "Highlights" },
        { "<leader>si", desc = "Icons" },
        { "<leader>sj", desc = "Jumps" },
        { "<leader>sk", desc = "Keymaps" },
        { "<leader>sl", desc = "Location List" },
        { "<leader>sm", desc = "Marks" },
        { "<leader>sM", desc = "Man Pages" },
        { "<leader>sp", desc = "Plugin Spec" },
        { "<leader>sq", desc = "Quickfix List" },
        { "<leader>sr", desc = "Search and Replace" },
        { "<leader>sR", desc = "Resume" },
        { "<leader>ss", desc = "LSP Symbols" },
        { "<leader>sS", desc = "LSP Workspace Symbols" },
        { "<leader>st", desc = "Todo" },
        { "<leader>sT", desc = "Todo/Fix/Fixme" },
        { "<leader>su", desc = "Undotree" },
        { "<leader>sw", desc = "Word (Root)", mode = { "n", "x" } },
        { "<leader>sW", desc = "Word (cwd)", mode = { "n", "x" } },

        -- Noice
        { "<leader>snl", desc = "Last Message" },
        { "<leader>snh", desc = "History" },
        { "<leader>sna", desc = "All" },
        { "<leader>snd", desc = "Dismiss All" },
        { "<leader>snt", desc = "Noice Picker" },

        -- UI Toggles
        { "<leader>uf", desc = "Toggle Format on Save" },
        { "<leader>uF", desc = "Toggle Format on Save (global)" },
        { "<leader>us", desc = "Toggle Spelling" },
        { "<leader>uw", desc = "Toggle Wrap" },
        { "<leader>uL", desc = "Toggle Relative Number" },
        { "<leader>ud", desc = "Toggle Diagnostics" },
        { "<leader>ul", desc = "Toggle Line Number" },
        { "<leader>uc", desc = "Toggle Conceal Level" },
        { "<leader>uC", desc = "Colorschemes" },
        { "<leader>uA", desc = "Toggle Tabline" },
        { "<leader>uT", desc = "Toggle Treesitter" },
        { "<leader>ub", desc = "Toggle Dark Background" },
        { "<leader>uD", desc = "Toggle Dim" },
        { "<leader>ua", desc = "Toggle Animate" },
        { "<leader>ug", desc = "Toggle Indent Guides" },
        { "<leader>uS", desc = "Toggle Scroll" },
        { "<leader>uh", desc = "Toggle Inlay Hints" },
        { "<leader>ui", desc = "Inspect Pos" },
        { "<leader>uI", desc = "Inspect Tree" },
        { "<leader>un", desc = "Dismiss Notifications" },
        { "<leader>ur", desc = "Redraw / Clear hlsearch" },

        -- Debug/Profiler
        { "<leader>dpp", desc = "Toggle Profiler" },
        { "<leader>dph", desc = "Profiler Highlights" },

        -- Quit
        { "<leader>qq", desc = "Quit All" },

        -- Tabs
        { "<leader><tab>l", desc = "Last Tab" },
        { "<leader><tab>o", desc = "Close Other Tabs" },
        { "<leader><tab>f", desc = "First Tab" },
        { "<leader><tab><tab>", desc = "New Tab" },
        { "<leader><tab>]", desc = "Next Tab" },
        { "<leader><tab>d", desc = "Delete Tab" },
        { "<leader><tab>[", desc = "Previous Tab" },

        -- Windows
        { "<leader>-", desc = "Split Below" },
        { "<leader>|", desc = "Split Right" },
        { "<leader>wd", desc = "Delete Window" },
        { "<leader>wm", desc = "Maximize (Zoom)" },

        -- Misc
        { "<leader>K", hidden = true },
        { "<leader>l", desc = "Lazy" },
        { "<leader>L", hidden = true },
        { "<leader>n", desc = "Notification History" },
        { "<leader>?", hidden = true },
        { "<leader>xl", desc = "Location List" },
        { "<leader>xq", desc = "Quickfix List" },
        { "<leader>xt", desc = "Todo" },
        { "<leader>xT", desc = "Todo/Fix/Fixme" },

        -- Goto (LSP)
        { "gd", desc = "Goto Definition" },
        { "gr", desc = "References" },
        { "gI", desc = "Goto Implementation" },
        { "gy", desc = "Goto Type Definition" },
      },
    },
  },
  -- snacks.nvim - dashboard
  {
    "snacks.nvim",
    keys = {
      { "<leader>E", false }, -- Disable snacks explorer
      { "<leader>e", false }, -- Disable snacks explorer
      { "<leader>uz", false }, -- Disable zen mode
      { "<leader>uZ", false }, -- Disable zen zoom
      { "<leader>z", false }, -- Disable zen
      { "<leader>Z", false }, -- Disable zoom
      { "<leader>uf", false }, -- Disable fullscreen if exists
    },
    opts = {
      dashboard = {
        sections = {
          { section = "header" },
          { section = "recent_files", title = "Recent Files", padding = 1 },
          { section = "projects", title = "Projects", padding = 1 },
          { section = "keys", padding = 1 },
          { section = "startup", icon = "" },
        },
        preset = {
          pick = function(cmd, opts)
            return LazyVim.pick(cmd, opts)()
          end,
          -- stylua: ignore
          header = [[
                __
___     ___    ___   __  __ /\_\    ___ ___
 / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\
 /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \
 \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\
  \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/
]],
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = "", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
      notifier = {
        top_down = false,
      },
      explorer = { enabled = false },
      zen = { enabled = false },
    },
  },
  -- lualine - status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = " "
      else
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = LazyVim.config.icons
      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          theme = "auto",
          section_separators = "",
          component_separators = "",
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            LazyVim.lualine.root_dir(),
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { LazyVim.lualine.pretty_path() },
          },
          lualine_x = {
            Snacks.profiler.status(),
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = function() return { fg = Snacks.util.color("Statement") } end,
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return { fg = Snacks.util.color("Constant") } end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return { fg = Snacks.util.color("Special") } end,
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {},
        },
        extensions = { "neo-tree", "lazy" },
      }

      return opts
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "File Explorer (root)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "File Explorer (cwd)",
      },
      { "<leader>e", "<leader>fE", desc = "File Explorer (cwd)", remap = true },
      { "<leader>E", "<leader>fe", desc = "File Explorer (root)", remap = true },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer Explorer",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
              require("neo-tree")
            end
          end
        end,
      })
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status" },
      open_files_do_not_replace_types = { "terminal", "trouble", "qf", "Outline" },
      add_blank_line_at_top = false,
      hide_root_node = false,
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = false,
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_hidden = true,
        },
      },
      window = {
        position = "right",
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["<space>"] = "none",
          ["H"] = "toggle_hidden",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
            desc = "Copy Path to Clipboard",
          },
          ["O"] = {
            function(state)
              require("lazy.util").open(state.tree:get_node().path, { system = true })
            end,
            desc = "Open with System Application",
          },
          ["P"] = { "toggle_preview", config = { use_float = true, title = "Preview" } },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = "󰉋",
          folder_open = "󰝰",
          folder_empty = "󰉖",
          folder_empty_open = "󰷏",
          default = "󰈤",
          highlight = "NeoTreeFileIcon",
          provider = function(icon, node, state)
            if node.type == "file" then
              local name = node.name
              local ext = name:match("%.([^%.]+)$")

              if ext then
                -- Scripts
                if
                  ext == "sh"
                  or ext == "bash"
                  or ext == "zsh"
                  or ext == "fish"
                  or ext == "ps1"
                  or ext == "bat"
                  or ext == "cmd"
                then
                  icon.text = "󰑷"
                -- Configs
                elseif
                  ext == "conf"
                  or ext == "yaml"
                  or ext == "yml"
                  or ext == "toml"
                  or ext == "json"
                  or ext == "ini"
                  or ext == "cfg"
                  or ext == "env"
                  or ext == "properties"
                  or ext == "xml"
                then
                  icon.text = "󱁼"
                -- Markdown
                elseif ext == "md" or ext == "markdown" or ext == "mdx" then
                  icon.text = "󰧮"
                -- Images
                elseif
                  ext == "png"
                  or ext == "jpg"
                  or ext == "jpeg"
                  or ext == "gif"
                  or ext == "svg"
                  or ext == "webp"
                  or ext == "bmp"
                  or ext == "ico"
                  or ext == "mp4"
                  or ext == "mov"
                  or ext == "avi"
                  or ext == "mkv"
                  or ext == "webm"
                  or ext == "flv"
                  or ext == "wmv"
                then
                  icon.text = "󰺰"
                -- Programming languages
                elseif
                  ext == "js"
                  or ext == "ts"
                  or ext == "tsx"
                  or ext == "jsx"
                  or ext == "py"
                  or ext == "go"
                  or ext == "rs"
                  or ext == "java"
                  or ext == "c"
                  or ext == "cpp"
                  or ext == "h"
                  or ext == "hpp"
                  or ext == "rb"
                  or ext == "php"
                  or ext == "lua"
                  or ext == "vim"
                  or ext == "cs"
                  or ext == "swift"
                  or ext == "kt"
                  or ext == "scala"
                  or ext == "r"
                  or ext == "m"
                  or ext == "mm"
                then
                  icon.text = "󱀫"
                else
                  icon.text = "󰈤"
                end
              else
                icon.text = ""
              end
            end
          end,
        },
        git_status = {
          symbols = {
            added = "✚",
            deleted = "✖",
            modified = "",
            renamed = "󰁕",
            untracked = "U",
            ignored = "I",
            unstaged = "M",
            staged = "S",
            conflict = "C",
          },
        },
      },
    },
    config = function(_, opts)
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end

      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
      require("neo-tree").setup(opts)
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
  },
}
